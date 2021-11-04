#' #################################
#' #################################
#' 
#' Ecological Model of Binary Interaction with Dominant Features (EMBIID)
#' 
#' #################################
#' #################################


#' #################################
#' load libraries and set seed
#' #################################
library(tidyverse)
library(ggtext)
library(readxl)
library(tidybayes)
library(cmdstanr)
library(brms)
library(gt)
library(gtExtras)
set.seed(16)
# library(tensorflow)
# tensorflow::set_random_seed(seed = 16)
# library(keras)
# keras::k_backend()
# library(tfdatasets)
# library(tfruns)



#' #################################
#' read data
#' #################################
read_csv("./data/gsw_warriors_lineups_2019_2020_long.csv") %>%
  identity() -> gsw19
gsw19


read_csv("./data/gsw_warriors_lineups_2020_2021_long.csv") %>%
  identity() -> gsw20
gsw20


read_csv("./data/phl_sixers_lineups_2019_2020_long.csv") %>%
  identity() -> phl19
phl19


read_csv("./data/phl_sixers_lineups_2020_2021_long.csv") %>%
  identity() -> phl20
phl20




#' #################################
#' observed co-occurrence
#' #################################

observed_with_dominant <- function(dominant_feature = "j_embiid", dat) {
  dat %>%
    #filter({{dominant_feature}} == TRUE) %>%
    filter(.data[[dominant_feature]] == TRUE) %>%
    #select(-{{dominant_feature}}) %>%
    select(-.data[[dominant_feature]]) %>%
    summarise_if(.predicate = ~ is.logical(.x), .funs = ~ sum(.x)) %>%
    pivot_longer(cols = everything(), names_to = "player", values_to = "minutes_with_keystone") %>%
    mutate(keystone = dominant_feature) %>%
    arrange(desc(minutes_with_keystone)) %>%
    identity() -> obs_dom
  return(obs_dom)
}


observed_with_dominant("j_embiid", select(phl19, where(~ is.logical(.x)))) %>%
  identity() -> phl19_minutes

observed_with_dominant("j_embiid", select(phl20, where(~ is.logical(.x)))) %>%
  identity() -> phl20_minutes

observed_with_dominant("s_curry", select(gsw19, where(~ is.logical(.x)))) %>%
  identity() -> gsw19_minutes

observed_with_dominant("s_curry", select(gsw20, where(~ is.logical(.x)))) %>%
  identity() -> gsw20_minutes


structure(.Data = ls(pattern = "_minutes"), .Names = ls(pattern = "_minutes")) %>%
  map(.f = ~ get(.x) %>%
        mutate_if(.predicate = ~ is.character(.x),
                  .funs = ~ stringr::str_to_title(string = gsub("_"," ",.x))) %>%
        rename_all(.funs = ~ stringr::str_to_title(gsub("_"," ",.x))) %>%
        gt() %>%
        gt_color_rows(columns = `Minutes With Keystone`, palette = "ggsci::blue_material") %>%
        gt_theme_538) %>%
  map2(.x = ., .y = names(.), .f = ~ gtsave(data = .x, filename = paste0(.y,".html"), path = "./tabs/"))


structure(.Data = ls(pattern = "_minutes"), .Names = ls(pattern = "_minutes")) %>%
  map(.f = ~ get(.x) %>%
        mutate_if(.predicate = ~ is.character(.x),
                  .funs = ~ stringr::str_to_title(string = gsub("_"," ",.x))) %>%
        rename_all(.funs = ~ stringr::str_to_title(gsub("_"," ",.x))) %>%
        gt() %>%
        gt_color_rows(columns = `Minutes With Keystone`, palette = "ggsci::blue_material") %>%
        gt_theme_538) %>%
  map2(.x = ., .y = names(.), .f = ~ write_rds(x = .x, file = paste0("./tabs/",.y,".rds")))



#' #################################
#' prepare data for modeling
#' #################################

prep_dat_embiid <- function(dominant_feature = "j_embiid", outcome_var = "netrtg", dat, co_occur_tib) {
  # choose outcome variable and all binary occurence variables
  dat %>%
    select(.data[[outcome_var]], where(~ is.logical(.x))) %>%
    identity() -> dat_simple
  # narrow to only those observed with the dominant feature
  co_occur_tib %>%
    filter(minutes_with_keystone == 0) %>%
    pull(player) %>%
    identity() -> zero_with_dominant
  dat_simple %>%
    select(-zero_with_dominant) %>%
    identity() -> dat_mod
  return(dat_mod)
}

prep_dat_embiid("j_embiid", "netrtg", phl19, phl19_minutes) -> phl19_dat

prep_dat_embiid("j_embiid", "netrtg", phl20, phl20_minutes) -> phl20_dat

prep_dat_embiid("j_embiid", "netrtg", gsw19, gsw19_minutes) -> gsw19_dat

prep_dat_embiid("j_embiid", "netrtg", gsw20, gsw20_minutes) -> gsw20_dat



#' #################################
#' run EMBIID model
#' #################################

run_model_embiid <- function(model_data, dominant_feature = "j_embiid", outcome_var = "netrtg")  {
  model_formula <- bf(glue::glue("{outcome_var} ~ 1 + {dominant_feature} + {dominant_feature} * ."))
  data_name <- deparse(substitute(model_data))
  model_data %>%
    brm(data = .,
        family = gaussian(),
        formula = model_formula,
        prior = set_prior("horseshoe(1)"),
        iter = 2000,
        warmup = 1000,
        chains = 4,
        cores = 4,
        control = list("adapt_delta" = 0.999, max_treedepth = 16),
        backend = "cmdstanr",
        seed = 16,
        file = glue::glue("./models/m_{outcome_var}_{dominant_feature}_{data_name}"),
        file_refit = "on_change"
    ) -> m_output
  return(m_output)
}


run_model_embiid(phl19_dat, "j_embiid", "netrtg") -> phl19_mod

run_model_embiid(phl20_dat, "j_embiid", "netrtg") -> phl20_mod

run_model_embiid(gsw19_dat, "s_curry", "netrtg") -> gsw19_mod

run_model_embiid(gsw20_dat, "s_curry", "netrtg") -> gsw20_mod


list(phl19_mod, phl20_mod, gsw19_mod, gsw20_mod) %>%
  map(.x = ., .f = ~ rstan::check_hmc_diagnostics(.x$fit))


list(phl19_mod, phl20_mod, gsw19_mod, gsw20_mod) %>%
  map(.x = ., .f = ~ brms::pp_check(.x))




#' #################################
#' posterior model contrasts
#' #################################


embiid_interaction <- function(model, dominant_feature = "j_embiid", outcome_var = "netrtg") {
  model %>%
    brms::as_draws_df() %>%
    as_tibble() %>%
    select(contains(paste0("b_",dominant_feature,"TRUE:"))) %>%
    rename_all(~ gsub(paste0("b_",dominant_feature,"TRUE:|TRUE"), "", .x)) %>%
    pivot_longer(cols = everything(), names_to = "player", values_to = "dominant_feature_interaction") %>%
    mutate(outcome = outcome_var) %>%
    identity() -> interax
  return(interax)
}


embiid_neteffect <- function(model, dominant_feature = "j_embiid", outcome_var = "netrtg", posterior_draws = 500) {
  model %>%
    pluck("data") %>%
    as_tibble() %>%
    select(-{{outcome_var}}) %>%
    slice(1:2) %>%
    mutate_all(.funs = ~ c(TRUE, FALSE)) %>%
    # include only time with dominant feature
    mutate_at(.vars = dominant_feature, .funs = ~ c(TRUE, TRUE)) %>%
    expand(!!! rlang::syms(names(.))) %>%
    add_epred_draws(newdata = ., object = model, ndraws = posterior_draws) %>%
    ungroup() %>%
    select(-.row, -.draw, -.chain, -.iteration) %>%
    select(-{{dominant_feature}}) %>%
    # # contrast players on/off court with dominant feature
    pivot_longer(cols = c(-.epred), names_to = "player", values_to = "on_court") %>%
    pivot_wider(id_cols = player, names_from = on_court, values_from = .epred, names_prefix = "on_court_") %>%
    mutate(on_off_contrast = map2(.x = on_court_TRUE, .y = on_court_FALSE, .f = ~ .x - .y)) %>%
    select(player, on_off_contrast) %>%
    unnest(cols = on_off_contrast) %>%
    mutate(outcome = outcome_var) %>%
    identity() -> neteffect
  return(neteffect)
}


embiid_interaction(phl19_mod, "j_embiid") -> phl19_interaction
phl19_interaction
embiid_neteffect(phl19_mod, "j_embiid", "netrtg", 500) -> phl19_net
phl19_net


embiid_interaction(phl20_mod, "j_embiid") -> phl20_interaction
phl20_interaction
embiid_neteffect(phl20_mod, "j_embiid", "netrtg", 500) -> phl20_net
phl20_net


embiid_interaction(gsw19_mod, "s_curry") -> gsw19_interaction
gsw19_interaction
embiid_neteffect(gsw19_mod, "s_curry", "netrtg", 200) -> gsw19_net
gsw19_net


embiid_interaction(gsw20_mod, "s_curry") -> gsw20_interaction
gsw20_interaction
embiid_neteffect(gsw20_mod, "s_curry", "netrtg", 200) -> gsw20_net
gsw20_net




#' #################################
#' model contrast plots
#' #################################

embiid_plot <- function(interaction_tib, neteffect_tib, dominant_name = "Joel Embiid", outcome_name = "Net Rating", post_cred_width = 0.95) {
  interaction_tib %>%
    select(player, dominant_feature_interaction) %>%
    group_by(player) %>%
    tidybayes::median_qi(.width = post_cred_width, .simple_names = FALSE) %>%
    ungroup() %>%
    identity() -> plot_dat_i
  neteffect_tib %>%
    select(player, on_off_contrast) %>%
    group_by(player) %>%
    tidybayes::median_qi(.width = post_cred_width, .simple_names = FALSE) %>%
    ungroup() %>%
    identity() -> plot_dat_n
  full_join(select(plot_dat_i, player, contains("dominant_feature_interaction")),
            select(plot_dat_n, player, contains("on_off_contrast")),
            by = "player") %>%
    mutate(player = stringr::str_to_title(string = gsub("_"," ",player)),
           player = gsub("Iii","III",player),
           player = gsub("Ii","II",player),
           player = forcats::fct_reorder(.f = factor(player), .x = on_off_contrast)) %>%
    identity() -> plot_dat
  ggplot(data = plot_dat) +
    geom_vline(xintercept = 0, linetype = 2, color = "darkgrey") +
    geom_linerange(aes(y = player, xmin = dominant_feature_interaction.lower, xmax = dominant_feature_interaction.upper), color = "#0072B5FF", position = position_nudge(y = -0.1)) +
    geom_point(aes(y = player, x = dominant_feature_interaction), color = "#0072B5FF", position = position_nudge(y = -0.1)) + #shape = 21
    geom_linerange(aes(y = player, xmin = on_off_contrast.lower, xmax = on_off_contrast.upper), color = "#BC3C29FF", position = position_nudge(y = 0.1)) +
    geom_point(aes(y = player, x = on_off_contrast), color = "#BC3C29FF", position = position_nudge(y = 0.1)) + #shape = 21
    theme_bw() +
    theme(plot.title.position = "plot",
          plot.title = ggtext::element_markdown(),
          plot.subtitle = ggtext::element_markdown(),
          axis.text.x = ggtext::element_markdown(color = "black"),
          axis.title.x = ggtext::element_markdown(color = "black"),
          axis.text.y = ggtext::element_markdown(color = "black"),
          axis.title.y = ggtext::element_markdown(color = "black")
          ) +
    labs(title = "Ecological Model of Binary Interaction with Dominant Features",
         subtitle = glue::glue("<span style='color:#0072B5FF'>Interaction Effect ('Fit')</span> & <span style='color:#BC3C29FF'>Total Effect</span> of Pairing with {dominant_name}"),
         x = glue::glue("Expected Change in Lineup's {outcome_name}<br>(posterior median and {post_cred_width*100}% credible interval)"),
         y = "") -> plot
  return(plot)
}


embiid_plot(phl19_interaction, phl19_net, "Joel Embiid (2019-2020 season)", "Net Rating", 0.95) -> p_phl19
embiid_plot(phl20_interaction, phl20_net, "Joel Embiid (2020-2021 season)", "Net Rating", 0.95) -> p_phl20

embiid_plot(gsw19_interaction, gsw19_net, "Steph Curry (2019-2020 season)", "Net Rating", 0.95) -> p_gsw19
embiid_plot(gsw20_interaction, gsw20_net, "Steph Curry (2020-2021 season)", "Net Rating", 0.95) -> p_gsw20

tibble(plot_name = c("p_phl19", "p_phl20", "p_gsw19", "p_gsw20")) %>%
  mutate(plot = map(.x = plot_name, .f = ~ get(.x))) %>%
  identity() -> plot_tib

plot_tib %>%
  map2(.x = .$plot_name, .y = .$plot, .f = ~ ggsave(plot = .y, filename = glue::glue("./figs/{.x}.pdf"), height = 6, width = 8, units = "in"))

plot_tib %>%
  map2(.x = .$plot_name, .y = .$plot, .f = ~ ggsave(plot = .y, filename = glue::glue("./figs/{.x}.svg"), height = 6, width = 8, units = "in"))

plot_tib %>%
  map2(.x = .$plot_name, .y = .$plot, .f = ~ ggsave(plot = .y, filename = glue::glue("./figs/{.x}.png"), height = 6, width = 8, units = "in", dpi = 600))



#' #################################
#' posterior model contrast: multiple players specified
#' #################################

gsw20_mod %>%
  pluck("data") %>%
  as_tibble() %>%
  select(-netrtg) %>%
  slice(1:2) %>%
  mutate_all(.funs = ~ c(TRUE, FALSE)) %>%
  # include only time with dominant feature & specified lineup components
  mutate_at(.vars = c("s_curry", "d_green", "k_bazemore", "a_wiggins"), .funs = ~ c(TRUE, TRUE)) %>%
  mutate_at(.vars = c("k_oubre_jr", "j_toscano_anderson", "b_wanamaker", "d_lee", "e_paschall", "m_mulder", "j_poole", "n_mannion", "g_payton_ii", "m_chriss"), .funs = ~ c(FALSE, FALSE)) %>%
  expand(!!! rlang::syms(names(.))) %>%
  add_epred_draws(newdata = ., object = gsw20_mod, ndraws = 1000) %>%
  ungroup() %>%
  select(-.row, -.draw, -.chain, -.iteration) %>%
  select(.epred, k_looney, j_wiseman) %>%
  # # contrast players on/off court with dominant feature
  pivot_longer(cols = c(-.epred), names_to = "player", values_to = "on_court") %>%
  pivot_wider(id_cols = player, names_from = on_court, values_from = .epred, names_prefix = "on_court_") %>%
  mutate(on_off_contrast = map2(.x = on_court_TRUE, .y = on_court_FALSE, .f = ~ .x - .y)) %>%
  select(player, on_off_contrast) %>%
  unnest(cols = on_off_contrast) %>%
  mutate(outcome = "netrtg") %>%
  identity() -> looney_wiseman_neteffect
looney_wiseman_neteffect


looney_wiseman_neteffect %>%
  select(player, on_off_contrast) %>%
  group_by(player) %>%
  tidybayes::median_qi(.width = 0.95, .simple_names = FALSE) %>%
  ungroup() %>%
  mutate(player = stringr::str_to_title(string = gsub("_"," ",player)),
         player = gsub("Iii","III",player),
         player = gsub("Ii","II",player),
         player = forcats::fct_reorder(.f = factor(player), .x = on_off_contrast)) %>%
  ggplot(data = .) +
  geom_vline(xintercept = 0, linetype = 2, color = "darkgrey") +
  geom_linerange(aes(y = player, xmin = on_off_contrast.lower, xmax = on_off_contrast.upper), color = "#BC3C29FF", position = position_nudge(y = 0)) +
  geom_point(aes(y = player, x = on_off_contrast), color = "#BC3C29FF", position = position_nudge(y = 0)) + #shape = 21
  theme_bw() +
  theme(plot.title.position = "plot",
        plot.title = ggtext::element_markdown(),
        plot.subtitle = ggtext::element_markdown(),
        axis.text.x = ggtext::element_markdown(color = "black"),
        axis.title.x = ggtext::element_markdown(color = "black"),
        axis.text.y = ggtext::element_markdown(color = "black"),
        axis.title.y = ggtext::element_markdown(color = "black")
  ) +
  labs(title = "Ecological Model of Binary Interaction with Dominant Features",
       subtitle = glue::glue("<span style='color:#BC3C29FF'>Total Effect</span> of Addition to Lineup with S. Curry, D. Green, K. Bazemore, A. Wiggins (2020-2021 Season)"),
       x = glue::glue("Expected Change in Lineup's Net Rating<br>(posterior median and 95% credible interval)"),
       y = "") -> p_looney_wiseman
p_looney_wiseman

p_looney_wiseman %>%
  ggsave(plot = ., filename = "./figs/p_looney_wiseman_20.pdf", height = 3, width = 8, units = "in")
p_looney_wiseman %>%
  ggsave(plot = ., filename = "./figs/p_looney_wiseman_20.svg", height = 3, width = 8, units = "in")
p_looney_wiseman %>%
  ggsave(plot = ., filename = "./figs/p_looney_wiseman_20.png", height = 3, width = 8, units = "in", dpi = 600)
