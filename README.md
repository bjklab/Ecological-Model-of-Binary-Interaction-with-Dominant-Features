
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Ecological Model of Binary Interaction with Dominant Features (EMBIID)

We have previously reported the utility of interaction models to account
for the effect of microbial interactions on infection risk. For example,
*Staphylococcus aureus* interactions with *Corynebacterium* species in
the upper respiratory tract appear to alter the risk of lower
respiratory tract infection. Likewise, *Clostridioides difficile*
interactions with *Ruminococcus* and *Lachnospira* species in the
gastrointestinal tract can influence the risk of *C. difficile*
infection.

Here we report the utility of our binary interaction model to understand
team lineup selection to optimize pairings with a selected “keystone”
player. Unlike dominant features of microbial communities, the selection
of one keystone player over another potential keystone is often
arbitrary, or related to factors outside of athletic performance. But we
observe that keystone player selection is common throughout professional
sports.

## Informative Observations

We take as an informative observation each minute of playing time shared
with the selected keystone player. For optimal performance, and to allow
for random effects that could account for opponent-specific or
situation-specific (e.g., fourth-quarter) differences, models would be
fit to real, minute-level data. For demonstration purposes, we have
imputed minute-level lineup data from aggregate lineup data that is
publicly available at
[nba.com](https://www.nba.com/stats/lineups/advanced/).

## Prior Knowledge re: Pairings with Selected Keystone Players

During the course of a season, not all roster members are paired with
the selected keystone player. Below we illustrate this with tables
describing duration of paired time on the floor across teammates of Joel
Embiid and Steph Curry during the NBA’s 2020-2021 season:

<div align="center">

<div id="euovdfzswz" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Chivo:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
html {
  font-family: Chivo, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#euovdfzswz .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: 300;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: none;
  border-top-width: 3px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#euovdfzswz .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#euovdfzswz .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#euovdfzswz .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#euovdfzswz .gt_bottom_border {
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#euovdfzswz .gt_col_headings {
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #000000;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#euovdfzswz .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: normal;
  text-transform: uppercase;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#euovdfzswz .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: normal;
  text-transform: uppercase;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#euovdfzswz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#euovdfzswz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#euovdfzswz .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #000000;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#euovdfzswz .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #000000;
  border-bottom-style: solid;
  border-bottom-width: 1px;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#euovdfzswz .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #000000;
  border-bottom-style: solid;
  border-bottom-width: 1px;
  border-bottom-color: #FFFFFF;
  vertical-align: middle;
}

#euovdfzswz .gt_from_md > :first-child {
  margin-top: 0;
}

#euovdfzswz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#euovdfzswz .gt_row {
  padding-top: 3px;
  padding-bottom: 3px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#euovdfzswz .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-right-style: solid;
  border-right-width: 0px;
  border-right-color: #FFFFFF;
  padding-left: 12px;
}

#euovdfzswz .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#euovdfzswz .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#euovdfzswz .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#euovdfzswz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#euovdfzswz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#euovdfzswz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#euovdfzswz .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#euovdfzswz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#euovdfzswz .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#euovdfzswz .gt_sourcenote {
  font-size: 12px;
  padding: 4px;
}

#euovdfzswz .gt_left {
  text-align: left;
}

#euovdfzswz .gt_center {
  text-align: center;
}

#euovdfzswz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#euovdfzswz .gt_font_normal {
  font-weight: normal;
}

#euovdfzswz .gt_font_bold {
  font-weight: bold;
}

#euovdfzswz .gt_font_italic {
  font-style: italic;
}

#euovdfzswz .gt_super {
  font-size: 65%;
}

#euovdfzswz .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="border-top-width: 0px; border-top-style: solid; border-top-color: black;">Player</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="border-top-width: 0px; border-top-style: solid; border-top-color: black;">Minutes With Keystone</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="border-top-width: 0px; border-top-style: solid; border-top-color: black;">Keystone</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">D Green</td>
<td class="gt_row gt_right" style="background-color: #0D47A1; color: #FFFFFF;">1253</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">T Harris</td>
<td class="gt_row gt_right" style="background-color: #1255B0; color: #FFFFFF;">1186</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">B Simmons</td>
<td class="gt_row gt_right" style="background-color: #135AB4; color: #FFFFFF;">1165</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">S Curry</td>
<td class="gt_row gt_right" style="background-color: #1562BD; color: #FFFFFF;">1126</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">S Milton</td>
<td class="gt_row gt_right" style="background-color: #6CB8F6; color: #000000;">396</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">M Thybulle</td>
<td class="gt_row gt_right" style="background-color: #72BBF7; color: #000000;">378</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">F Korkmaz</td>
<td class="gt_row gt_right" style="background-color: #8CC8F9; color: #000000;">291</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">T Maxey</td>
<td class="gt_row gt_right" style="background-color: #A8D5FA; color: #000000;">202</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">M Scott</td>
<td class="gt_row gt_right" style="background-color: #ADD7FA; color: #000000;">187</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">G Hill</td>
<td class="gt_row gt_right" style="background-color: #CFE8FC; color: #000000;">72</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">I Joe</td>
<td class="gt_row gt_right" style="background-color: #D8ECFC; color: #000000;">41</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">D Mathias</td>
<td class="gt_row gt_right" style="background-color: #DDEFFD; color: #000000;">23</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">D Howard</td>
<td class="gt_row gt_right" style="background-color: #E1F1FD; color: #000000;">8</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">A Tolliver</td>
<td class="gt_row gt_right" style="background-color: #E2F1FD; color: #000000;">4</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">T Bradley</td>
<td class="gt_row gt_right" style="background-color: #E3F2FD; color: #000000;">0</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">P Reed</td>
<td class="gt_row gt_right" style="background-color: #E3F2FD; color: #000000;">0</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">R Tucker</td>
<td class="gt_row gt_right" style="background-color: #E3F2FD; color: #000000;">0</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">M Jones</td>
<td class="gt_row gt_right" style="background-color: #E3F2FD; color: #000000;">0</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">T Ferguson</td>
<td class="gt_row gt_right" style="background-color: #E3F2FD; color: #000000;">0</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">G Clark</td>
<td class="gt_row gt_right" style="background-color: #E3F2FD; color: #000000;">0</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left">V Poirier</td>
<td class="gt_row gt_right" style="background-color: #E3F2FD; color: #000000;">0</td>
<td class="gt_row gt_left">J Embiid</td></tr>
    <tr><td class="gt_row gt_left" style="border-bottom-width: 3px; border-bottom-style: solid; border-bottom-color: transparent;">I Brazdeikis</td>
<td class="gt_row gt_right" style="background-color: #E3F2FD; color: #000000; border-bottom-width: 3px; border-bottom-style: solid; border-bottom-color: transparent;">0</td>
<td class="gt_row gt_left" style="border-bottom-width: 3px; border-bottom-style: solid; border-bottom-color: transparent;">J Embiid</td></tr>
  </tbody>
  
  
</table>
</div>

<br>

<div id="nfhlvzogvx" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Chivo:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
html {
  font-family: Chivo, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#nfhlvzogvx .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: 300;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: none;
  border-top-width: 3px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#nfhlvzogvx .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#nfhlvzogvx .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#nfhlvzogvx .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#nfhlvzogvx .gt_bottom_border {
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nfhlvzogvx .gt_col_headings {
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #000000;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#nfhlvzogvx .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: normal;
  text-transform: uppercase;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#nfhlvzogvx .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: normal;
  text-transform: uppercase;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#nfhlvzogvx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#nfhlvzogvx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#nfhlvzogvx .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #000000;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#nfhlvzogvx .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #000000;
  border-bottom-style: solid;
  border-bottom-width: 1px;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#nfhlvzogvx .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #000000;
  border-bottom-style: solid;
  border-bottom-width: 1px;
  border-bottom-color: #FFFFFF;
  vertical-align: middle;
}

#nfhlvzogvx .gt_from_md > :first-child {
  margin-top: 0;
}

#nfhlvzogvx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#nfhlvzogvx .gt_row {
  padding-top: 3px;
  padding-bottom: 3px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#nfhlvzogvx .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-right-style: solid;
  border-right-width: 0px;
  border-right-color: #FFFFFF;
  padding-left: 12px;
}

#nfhlvzogvx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nfhlvzogvx .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#nfhlvzogvx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nfhlvzogvx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#nfhlvzogvx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#nfhlvzogvx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nfhlvzogvx .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#nfhlvzogvx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#nfhlvzogvx .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#nfhlvzogvx .gt_sourcenote {
  font-size: 12px;
  padding: 4px;
}

#nfhlvzogvx .gt_left {
  text-align: left;
}

#nfhlvzogvx .gt_center {
  text-align: center;
}

#nfhlvzogvx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#nfhlvzogvx .gt_font_normal {
  font-weight: normal;
}

#nfhlvzogvx .gt_font_bold {
  font-weight: bold;
}

#nfhlvzogvx .gt_font_italic {
  font-style: italic;
}

#nfhlvzogvx .gt_super {
  font-size: 65%;
}

#nfhlvzogvx .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="border-top-width: 0px; border-top-style: solid; border-top-color: black;">Player</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="border-top-width: 0px; border-top-style: solid; border-top-color: black;">Minutes With Keystone</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="border-top-width: 0px; border-top-style: solid; border-top-color: black;">Keystone</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">D Green</td>
<td class="gt_row gt_right" style="background-color: #0D47A1; color: #FFFFFF;">1740</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">A Wiggins</td>
<td class="gt_row gt_right" style="background-color: #1461BC; color: #FFFFFF;">1569</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">K Oubre Jr</td>
<td class="gt_row gt_right" style="background-color: #1E86E3; color: #FFFFFF;">1180</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">K Bazemore</td>
<td class="gt_row gt_right" style="background-color: #389FF4; color: #000000;">844</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">K Looney</td>
<td class="gt_row gt_right" style="background-color: #3FA3F5; color: #000000;">799</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">J Toscano Anderson</td>
<td class="gt_row gt_right" style="background-color: #5BB0F6; color: #000000;">636</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">J Wiseman</td>
<td class="gt_row gt_right" style="background-color: #70BAF7; color: #000000;">534</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">M Mulder</td>
<td class="gt_row gt_right" style="background-color: #90CAF9; color: #000000;">389</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">D Lee</td>
<td class="gt_row gt_right" style="background-color: #90CAF9; color: #000000;">386</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">J Poole</td>
<td class="gt_row gt_right" style="background-color: #B6DCFB; color: #000000;">217</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">E Paschall</td>
<td class="gt_row gt_right" style="background-color: #B9DDFB; color: #000000;">201</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">B Wanamaker</td>
<td class="gt_row gt_right" style="background-color: #D2E9FC; color: #000000;">82</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">G Payton Ii</td>
<td class="gt_row gt_right" style="background-color: #E0F0FD; color: #000000;">16</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">M Chriss</td>
<td class="gt_row gt_right" style="background-color: #E1F1FD; color: #000000;">12</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">N Mannion</td>
<td class="gt_row gt_right" style="background-color: #E2F1FD; color: #000000;">7</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left">A Smailagic</td>
<td class="gt_row gt_right" style="background-color: #E3F2FD; color: #000000;">0</td>
<td class="gt_row gt_left">S Curry</td></tr>
    <tr><td class="gt_row gt_left" style="border-bottom-width: 3px; border-bottom-style: solid; border-bottom-color: transparent;">J Bell</td>
<td class="gt_row gt_right" style="background-color: #E3F2FD; color: #000000; border-bottom-width: 3px; border-bottom-style: solid; border-bottom-color: transparent;">0</td>
<td class="gt_row gt_left" style="border-bottom-width: 3px; border-bottom-style: solid; border-bottom-color: transparent;">S Curry</td></tr>
  </tbody>
  
  
</table>
</div>

</div>

The absence of paired minutes likely reflects prior knowledge regarding
the efficacy of pairing. In our demonstration examples, we have not
taken differences in prior probability of successful pairing into
account, but the EMBIID model structure permits this prior knowledge to
be incorporated.

## Interaction Model Likelihood

The interaction model can be specified using a variety of outcome
variables, including continuous and binary variables. Here we
demonstrate the model using lineup net rating (offensive rating -
defensive rating) data.

## Model Parameters

The EMBIID model permits examination of two parameters for each player
pairing, each on the scale of the chosen outcome variable (e.g.,
continuous net rating, shooting percentage, etc). The first parameter is
the interaction term between a roster player and the keystone player.
This parameter can be interpreted as the players’ ‘fit’ – the expected
effect of their pairing, controlled for the expected effects of their
individual performances. The second parameter is the total effect of the
pairing. This accounts for both the fit term and the paired players’
individual effect. This is important to examine because a positive fit
can have a negative total effect if the paired player is, individually,
a detriment to team performance. Below we demonstrate the model output
using pairings from the NBA’s 2020-2021 season:

<img src="./figs/p_phl20.svg" width="90%" style="display: block; margin: auto;" />
<br>
<img src="./figs/p_gsw20.svg" width="90%" style="display: block; margin: auto;" />

## Model Parameters

Just as microbial community models can be better understood by examining
interactions in the light of community member features, so too can the
EMBIID model output be better understood by mapping the parameters onto
paired player features.
