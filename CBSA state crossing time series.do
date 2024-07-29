//time series graphs of percent of migration within a CBSA that crosses state lines (Filers AGI and Indv)

cd "$datainputPath"

//load in data 
use "cbsa_state_crossing_flows.dta", clear

//ajust for main cbsa to examin 

keep if cbsa1 == 47900 | cbsa1== 35620 | cbsa1 == 28140 | cbsa1 == 38900 | cbsa1 == 17300 | cbsa1 == 22020 | cbsa1 == 24220 | cbsa1== 30300 | cbsa1 == 36620 | cbsa1 == 45500

//make time series 
xtline pct_same_cbsa_diff_state_filers2, xline(2017, lwidth(thin) lcolor(blue)) xline(2020, lwidth(thin) lcolor(red)) overlay tlabel(#3) legend(order(1 "TN-KY" 2 "ND-MN" 3 "ND-MN2" 4 "MO-KS" 5 "ID-WA" 6 "NY-NJ" 7 "OR-ID" 8 "OR-WA" 9 "TX-AR" 10 "DC-VA-MD-WV")) title("Migrant Filers within a CBSA that crosses State Lines") ytitle("Percent") xtitle("Year")
graph export "$graphoutputPath/Migrant Filers within a CBSA that crosses State Lines.pdf", replace


xtline pct_same_cbsa_diff_state_agi2, xline(2017, lwidth(thin) lcolor(blue)) xline(2020, lwidth(thin) lcolor(red)) overlay tlabel(#3) legend(order(1 "TN-KY" 2 "ND-MN" 3 "ND-MN2" 4 "MO-KS" 5 "ID-WA" 6 "NY-NJ" 7 "OR-ID" 8 "OR-WA" 9 "TX-AR" 10 "DC-VA-MD-WV")) title("Migrant AGI within a CBSA that crosses State Lines") ytitle("Percent") xtitle("Year")
graph export "$graphoutputPath/Migrant AGI within a CBSA that crosses State Lines.pdf", replace


xtline pct_same_cbsa_diff_state_indv2, xline(2017, lwidth(thin) lcolor(blue)) xline(2020, lwidth(thin) lcolor(red)) overlay tlabel(#3)legend(order(1 "TN-KY" 2 "ND-MN" 3 "ND-MN2" 4 "MO-KS" 5 "ID-WA" 6 "NY-NJ" 7 "OR-ID" 8 "OR-WA" 9 "TX-AR" 10 "DC-VA-MD-WV")) title("Migrant Indv within a CBSA that crosses State Lines") ytitle("Percent") xtitle("Year")
graph export "$graphoutputPath/Migrant Indv within a CBSA that crosses State Lines.pdf", replace

