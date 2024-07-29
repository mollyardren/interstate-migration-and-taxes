// This do file has graphs summarizing the inflow and outflow of state migrants: specifically a bar graph comparing the ratio of total net agi to the non-migrant/same state migrant total agi

//bar graph 

cd "$datainputPath"

use "potmig_totalmigall.dta", clear

// Keep years 2013-14, 2017-18, and 2020-21

keep if Year == 2021 | Year== 1718 | Year == 1314

// get rid of DC
keep if state_fips != 11

//make the ratio a percent 
gen pct_agi_ratio_potmig = agi_ratio_potmig * 100

graph bar pct_agi_ratio_potmig, over(Year2) over(y2_state) asyvars scale(.4) scheme(stcolor) title("Ratio of Net AGI total to Nonmigrant and Same-state Migrant AGI total") subtitle("2013-14, 2017-18, 2020-21") ytitle("Percent of Potential Migrants (per state)") plotregion(margin(l=20 r=20 t=0 b=0)) graphregion(margin(l=0 r=0 t=0 b=0)) aspectratio(.4) 
graph export "$graphoutputPath/Ratio of Net AGI total to Nonmigrant and Same-state Migrant AGI total.pdf", replace


// Repeat the same for i. number of returns and ii. number of indv 

//i. Number of returns

//make the ratio a percent 
gen pct_filers_ratio_potmig = filers_ratio_potmig * 100

graph bar pct_filers_ratio_potmig, over(Year2) over(y2_state) xsize(8) asyvars scale(.4)scheme(stcolor)  title("Total Net Filers as a share of Potential Migrant Filers by State") legend(order(1 "2013-2014" 2 "2017-2018" 3 "2020-2021"))ytitle("Percent of Potential Migrants (per state)") plotregion(margin(tiny)) graphregion(margin(tiny)) aspectratio(.4) 
graph export "$graphoutputPath/Total Net Filers as a share of Nonmigrant and Same-state Migrant Filers by State.pdf", replace


//ii. Number of indv

//make the ratio a percent 
gen pct_indv_ratio_potmig = indv_ratio_potmig * 100

graph bar pct_indv_ratio_potmig, over(Year2) over(y2_state) asyvars scale(.4)scheme(stcolor)  title("Total Net Individuals to Nonmigrant/Same-state Individuals") subtitle("2013-14, 2017-18, 2020-21") ytitle("Percent of Potential Migrants (per state)") plotregion(margin(l=20 r=20 t=0 b=0)) graphregion(margin(l=0 r=0 t=0 b=0)) aspectratio(.4) 
graph export "$graphoutputPath/Total Net Individuals to Nonmigrant and Same-state Individuals.pdf", replace






