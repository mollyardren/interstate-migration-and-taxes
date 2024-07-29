//merge with nonmig going back further because same-state variable is only calculated back to 2008-2009, this one will go back to 1994-1995

//append 2021-0807 to 0607-9293

cd "$datainputPath"
use "outflowsallyear.dta",replace
append using "0607-9293_out.dta", force

drop if Year == 9495
drop if Year == 9394
save "totalmigall.dta", replace 





//merge new year variables, state_fips, and state names 

import excel "migration_all_1993-2022.xlsx", sheet("Sheet2") firstrow clear

merge m:m Year y2_state using "totalmigall.dta", keep(match) 

//generate a heterogenius state indicator 

save "totalmigall.dta", replace 

clear

//merge new year variables, state_fips, and state names 

import excel "migration_all_1993-2022.xlsx", sheet("Sheet2") firstrow clear

merge m:m Year y2_state using "nonmiginflowsallyear.dta", keep(match) 

save "nonmiginflowsallyear.dta", replace

//merge in the non-migrants 
use "totalmigall.dta", clear 
merge m:m state_fips Year using "nonmiginflowsallyear.dta", keep(match) nogenerate 

//generate nonmig ratios 
gen net_filers_N = filers_in_N - filers_out_N
gen net_agi = agi_in - agi_out 
gen net_agi_avg = filers_in_AGI_avg - filers_out_AGI_avg
gen net_indv_N = indv_in_N - indv_out_N
gen agi_ratio_nonmig = net_agi / nonmig_AGI
gen agi_avg_ratio_nonmig = net_agi_avg / nonmig_AGI_avg
gen filers_ratio_nonmig = net_filers_N / nonmig_filers_N
gen indv_ratio_nonmig = net_indv_N / nonmig_indv_N

save "nonmig_totalmigall.dta", replace 
