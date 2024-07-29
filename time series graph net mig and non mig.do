//generate a time series graph showing the percent of net migrant AGI as a share of total AGI of potentia migrants 



cd "$datainputPath"

use "nonmig_totalmigall.dta", clear 


xtset state_fips Year2 

keep if y2_state == "FL" | y2_state == "TX" | y2_state == "NY" | y2_state == "CA"
//gen percent for y axis 
gen pct_agi_ratio_nonmig = 100* agi_ratio_nonmig
xtline pct_agi_ratio_nonmig, xline(2017, lwidth(thin) lcolor(blue)) xline(2020, lwidth(thin) lcolor(red)) overlay tlabel(#3) legend(order(1 "California" 2 "Florida" 3 "New York" 4 "Texas")) title("Net Migrant AGI as a share of Total AGI of Non-Migrant Filers") ytitle("Percent") xtitle("Year")
graph export "$graphoutputPath/timeseries_netmig_nonmig_agi_ratio.pdf", replace

gen pct_filers_ratio_nonmig = 100* filers_ratio_nonmig
xtline pct_agi_ratio_nonmig, xline(2017, lwidth(thin) lcolor(blue)) xline(2020, lwidth(thin) lcolor(red)) overlay tlabel(#3) legend(order(1 "California" 2 "Florida" 3 "New York" 4 "Texas")) title("Net Migrant Filers as a share of Total Non-Migrant Filers") ytitle("Percent") xtitle("Year")
graph export "$graphoutputPath/timeseries_netmig_nonmig_filers_ratio.pdf", replace

gen pct_indv_ratio_nonmig = 100* indv_ratio_nonmig
xtline pct_agi_ratio_nonmig, xline(2017, lwidth(thin) lcolor(blue)) xline(2020, lwidth(thin) lcolor(red)) overlay tlabel(#3) legend(order(1 "California" 2 "Florida" 3 "New York" 4 "Texas")) title("Net Migrant Invdiduals as a share of Total Non-Migrant Individuals") ytitle("Percent") xtitle("Year")

graph export "$graphoutputPath/timeseries_netmig_nonmig_indv_ratio.pdf", replace
