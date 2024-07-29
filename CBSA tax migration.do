//This data set that looks at the percent of migrants within a CBSA that cross state lines within the same CBSA. First I found the total migration within a CBSA that cross a state line, then those within the same cbsa who migrated within their state, and the total non-migrants. Then I added the same-state, same CBSA migrants with the different-state same CBSA migrants to get the total cbsa migrants. I found the percent of migrants within the cbsa that crossed state boarders, and summed this percent by CBSA and year.

cd "$datainputPath"

//load in county migrations with cbsa labels 
use "cbsa_county_inflows20112022years.dta", clear

 //only keep those who moved states but stayed within the same cbsa
 keep if cbsa1==cbsa2

 drop _merge 
save "cbsa_state_crossing_flows.dta", replace 

//drop the cbsa that include more than 2 states

 //make a variable for migrations that change states and stay within the same cbsa 
 gen same_cbsa_diff_state_filers = n1 if cbsa1==cbsa2 & y1_statefips!=y2_statefips
 gen same_cbsa_diff_state_indv  = n2 if cbsa1==cbsa2 & y1_statefips!=y2_statefips
 gen same_cbsa_diff_state_agi  = agi if cbsa1==cbsa2 & y1_statefips!=y2_statefips
 
 
 //make a variable for same state migration within the same cbsa 
  gen same_cbsa_same_state_filers = n1 if cbsa1==cbsa2 & y1_statefips==y2_statefips
 gen same_cbsa_same_state_indv  = n2 if cbsa1==cbsa2 & y1_statefips==y2_statefips
 gen same_cbsa_same_state_agi  = agi if cbsa1==cbsa2 & y1_statefips==y2_statefips
 
 

 
 
	//egen T_same_cbsa_diff_state_filers = total(same_cbsa_diff_state_filers), by(cbsa1 Year)
	//egen T_same_cbsa_diff_state_indv  = total(same_cbsa_diff_state_indv), by(cbsa1 Year)
	//egen T_same_cbsa_diff_state_agi = total(same_cbsa_diff_state_agi), by(cbsa1 Year)
	
	//egen T_same_cbsa_same_state_filers = total(same_cbsa_same_state_filers), by(cbsa1 Year)
	//egen T_same_cbsa_same_state_indv  = total(same_cbsa_same_state_indv), by(cbsa1 Year)
	//egen T_same_cbsa_same_state_agi = total(same_cbsa_same_state_agi), by(cbsa1 Year)
	
	//egen T_total_cbsa_mig_filers =  total(total_cbsa_mig_filers), by(cbsa1 Year)
	//egen T_total_cbsa_mig_indv =  total(total_cbsa_mig_indv), by(cbsa1 Year)
	//egen T_total_cbsa_mig_agi =  total(total_cbsa_mig_agi), by(cbsa1 Year)

gen T_filers_nonmig_N = n1 if y1_statefips==y2_statefips & y1_countyfips==y2_countyfips
gen T_indv_nonmig_N = n2 if y1_statefips==y2_statefips & y1_countyfips==y2_countyfips
gen T_agi_nonmig =  agi if y1_statefips==y2_statefips & y1_countyfips==y2_countyfips

	//egen totalnonmig_filers = total(T_filers_nonmig_N), by(cbsa1 Year)
	//egen totalnonmig_indv = total(T_indv_nonmig_N), by(cbsa1 Year)
	//egen totalnonmig_agi = total(T_agi_nonmig), by(cbsa1 Year)

	//egen totaly1_filers = total(n1), by(cbsa1 Year)
	//egen totaly1_indv = total(n2), by(cbsa1 Year)
	//egen totaly1_agi = total(agi), by(cbsa1 Year)


//collapse and sum the metrics by cbsa 
collapse (sum) same_cbsa_diff_state_filers same_cbsa_diff_state_agi same_cbsa_diff_state_indv same_cbsa_same_state_filers same_cbsa_same_state_agi same_cbsa_same_state_indv T_filers_nonmig_N T_agi_nonmig T_indv_nonmig_N  , by(Year cbsa1 cbsatitle)

 //sum the flows within a cbsa 
 gen total_cbsa_mig_filers = same_cbsa_diff_state_filers +  same_cbsa_same_state_filers
 gen total_cbsa_mig_indv = same_cbsa_diff_state_indv +  same_cbsa_same_state_indv
 gen total_cbsa_mig_agi = same_cbsa_diff_state_agi +  same_cbsa_same_state_agi
 

 
 //find the percent of migrants who change state within the same cbsa, by origin state
 
 gen pct_same_cbsa_diff_state_filers = same_cbsa_diff_state_filers/total_cbsa_mig_filers
 
 gen pct_same_cbsa_diff_state_indv  = same_cbsa_diff_state_indv/total_cbsa_mig_indv
 
 gen pct_same_cbsa_diff_state_agi  = same_cbsa_diff_state_agi/total_cbsa_mig_agi
 
 
save  "cbsa_state_crossing_flows.dta", replace 


//only look at a few years 

//keep if Year == 1213 | Year == 1617 | Year == 2021 | Year == 2122

 
 
//look at graphs for cbsa DC-VA-MD-WV(47900)
keep if cbsa1 == 47900 | cbsa1== 16980 | cbsa1== 35620 | cbsa1 == 28140 | cbsa1 == 38900 | cbsa1 == 17300 | cbsa1 == 22020 | cbsa1 == 24220 | cbsa1== 30300 | cbsa1 == 36620 | cbsa1 == 45500
 



//merge in years and make a time series plot 

//merge new year variables, state_fips, and state names 

import excel "migration_all_1993-2022.xlsx", sheet("Sheet2") firstrow clear

merge m:m Year using "cbsa_state_crossing_flows.dta", keep(match) 


save  "cbsa_state_crossing_flows.dta", replace 


keep if cbsa1 == 47900 | cbsa1== 16980 | cbsa1== 35620 | cbsa1 == 28140 | cbsa1 == 38900 | cbsa1 == 17300 | cbsa1 == 22020 | cbsa1 == 24220 | cbsa1== 30300 | cbsa1 == 36620 | cbsa1 == 45500
xtset  cbsa1 Year2 


gen pct_same_cbsa_diff_state_filers2 = pct_same_cbsa_diff_state_filers*100

gen pct_same_cbsa_diff_state_agi2 = pct_same_cbsa_diff_state_agi*100

gen pct_same_cbsa_diff_state_indv2 = pct_same_cbsa_diff_state_indv*100

save  "cbsa_state_crossing_flows.dta", replace 

