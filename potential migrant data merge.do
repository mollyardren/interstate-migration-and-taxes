
//append 2021-0807 to 0607-9293

cd "$datainputPath"
use "outflowsallyear.dta",replace
append using "0607-9293_out.dta", force

drop if Year == 9495
drop if Year == 9394
save "totalmigall.dta", replace 

//checks to see if any data is missing (sum of total inflows and outflows per year should be the same since we are not counting forgein migration)


*collapse (sum) filers_in_N filers_out_N, by(Year)

*collapse (sum) agi_in agi_out, by(Year)

*collapse (sum) indv_in_N indv_out_N, by(Year)

//merge in same state data to non mig data to create potential migrant variable 

use "nonmig_totalmigall.dta", clear


merge m:m y2_statefips Year using "same-state-migallyear.dta", keep(match) nogenerate 

save "potmig_totalmigall.dta", replace 


//generate potential migrant variable as a sum of same state and non migrant variables 
gen potmig_filers = S_filers_in_N + nonmig_filers_N
gen potmig_indv = S_indv_in_N + nonmig_indv_N
gen potmig_agi = S_agi_in + nonmig_AGI 
gen potmig_agi_avg = S_filers_in_AGI_avg + nonmig_AGI_avg


gen filers_ratio_potmig = net_filers / potmig_filers
gen indv_ratio_potmig = net_indv / potmig_indv
gen agi_ratio_potmig = net_agi / potmig_agi 
gen agi_filers_avg_potmig = net_agi_avg / potmig_agi_avg
save "potmig_totalmigall.dta", replace 
