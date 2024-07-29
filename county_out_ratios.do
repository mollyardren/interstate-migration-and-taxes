//creating a county level data set to have a comparison between cross-state flows and cross-county flows (within each state)

//2011-2022
cd "$datainputPath"

//add description
// This do file imports inflow and outflow data, appends all years, and calculates the total filers in, filers out, and average AGI.

//load in data inflows


// Define the list of years
local years "2122 2021 1920 1819 1718 1617 1516 1415 1314 1213 1112"

// Loop through each year and process the files
foreach i of local years {
    // Import the CSV file
    import delimited using "countyinflow`i'.csv", clear
	// only keep the totals US, Same state, different state 
	keep if y1_statefips==97
	
		// Generate new variables for same-state migration
	gen Year = `i'
	gen S_filers_in_N1 = n1 if y1_countyfips == 1
	gen S_indv_in_N1 = n2 if y1_countyfips == 1
	gen S_agi_in1 = agi if y1_countyfips == 1
	gen S_filers_in_AGI_avg1 = agi/n1 if y1_countyfips == 1
	
		//Gen different state migration
	gen D_filers_in_N1 = n1 if y1_countyfips == 3
	gen D_indv_in_N1 = n2 if y1_countyfips == 3
	gen D_agi_in1 = agi if y1_countyfips == 3
	gen D_filers_in_AGI_avg1 = agi/n1 if y1_countyfips == 3
	
		// Gen total migration
	gen T_filers_in_N1 = n1 if y1_countyfips == 0
	gen T_indv_in_N1 = n2 if y1_countyfips == 0
	gen T_agi_in1 = agi if y1_countyfips == 0
	gen T_filers_in_AGI_avg1 = agi/n1 if y1_countyfips == 0
	

	// sum by state 
	egen S_filers_in_N = total(S_filers_in_N1), by(y2_statefips)
	egen S_indv_in_N = total(S_indv_in_N1), by(y2_statefips)
	egen S_agi_in = total(S_agi_in1), by(y2_statefips)
	egen S_filers_in_AGI_avg = total(S_filers_in_AGI_avg1), by(y2_statefips)
	
	egen D_filers_in_N = total(D_filers_in_N1), by(y2_statefips)
	egen D_indv_in_N = total(D_indv_in_N1), by(y2_statefips)
	egen D_agi_in = total(D_agi_in1), by(y2_statefips)
	egen D_filers_in_AGI_avg = total(D_filers_in_AGI_avg1), by(y2_statefips)
	
	egen T_filers_in_N = total(T_filers_in_N1), by(y2_statefips)
	egen T_indv_in_N = total(T_indv_in_N1), by(y2_statefips)
	egen T_agi_in = total(T_agi_in1), by(y2_statefips)
	egen T_filers_in_AGI_avg = total(T_filers_in_AGI_avg1), by(y2_statefips)
	
	gen pct_diff_filers = D_filers_in_N/T_filers_in_N
	gen pct_diff_indv = D_indv_in_N/T_indv_in_N
	gen pct_diff_agi = D_agi_in/T_agi_in

	
    // Save the dataset as a .dta file
    save "county_inflowdata`i'.dta", replace


}


	


	// initialize the data set  
	use "county_inflowdata2122.dta", clear
	foreach i in "2021" "1920" "1819" "1718" "1617" "1516" "1415" "1314" "1213" "1112" {
	append using "county_inflowdata`i'.dta"
	//drop extra variables 
	drop n1
	drop n2
	drop agi
	//save the data as one merged file
	save "county_inflowsallyear.dta", replace
}



// Keep years 2013-14, 2017-18, and 2020-21

keep if Year == 2122 | Year== 1718 | Year == 1314

//generate percent as multiplied by 100 
gen pct_diff_filers2 = pct_diff_filers*100

graph bar pct_diff_filers2, over(Year) over(y1_state) asyvars scale(.4) scheme(stcolor) title("Percent of Total Migrant Filers who Previously Resided in a Different State") ytitle("Percent")    plotregion(margin(tiny)) graphregion(margin(tiny)) aspectratio(.4) legend(order(1 "2013-2014" 2 "2017-2018" 3 "2021-2022"))
graph export "$graphoutputPath/Percent of Total Migrant Filers who Previously Resided in a Different State.pdf", replace

gen pct_diff_agi2 = pct_diff_agi*100 
graph bar pct_diff_agi2, over(Year) over(y1_state) asyvars scale(.4) scheme(stcolor) title("Percent of Total Migrant AGI from Different Sate") subtitle("2013-14, 2017-18, 2021-22") ytitle("Percent of AGI")  legend(order(1 "2013-2014" 2 "2017-2018" 3 "2021-2022"))  plotregion(margin(tiny)) graphregion(margin(tiny)) aspectratio(.4) 
graph export "$graphoutputPath/Percent of Total Migrant AGI from Different Sate.pdf", replace

gen pct_diff_indv2 = pct_diff_indv*100
graph bar pct_diff_indv, over(Year) over(y1_state) asyvars scale(.4) scheme(stcolor) title("Percent of Individual Migrants from Different State") subtitle("2013-14, 2017-18, 2021-22") ytitle("Percent of AGI")  legend(order(1 "2013-2014" 2 "2017-2018" 3 "2021-2022"))  plotregion(margin(tiny)) graphregion(margin(tiny)) aspectratio(.4) 
graph export "$graphoutputPath/Percent of Individual Migrants from Different State.pdf", replace
