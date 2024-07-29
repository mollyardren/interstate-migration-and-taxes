

//add description
// This do file imports inflow and outflow data, appends all years, and calculates the total filers in, filers out, and average AGI.

//load in data inflows

cd "$datainputPath"
// Define the list of years
local years "2122 2021 1920 1819 1718 1617 1516 1415 1314 1213 1112"

// Loop through each year and process the files

foreach i of local years {
	
    // Import the CSV file
    import delimited using "stateinflow`i'.csv", clear
    // Generate new variables 
	gen Year = `i'
	gen filers_in_N = n1
	gen indv_in_N = n2
	gen agi_in = agi
	gen filers_in_AGI_avg = agi/n1
	//look only at totals 
	// only keep the totals
	keep if y1_statefips==97
    // Save the dataset as a .dta file
    save "inflowdata`i'.dta", replace


}



	
foreach i of local years{

use "inflowdata`i'.dta", replace
 foreach x in  "AL" "AK" "AZ" "AR" "CA" "CO" "CT" "DE" "FL" "GA" "HI" "ID" "IL" "IN" "IA" "KS" "KY" "LA" "ME" "MD" "MA" "MI" "MN" "MS" "MO" "MT" "NE" "NV" "NH" "NJ" "NM" "NY" "NC" "ND" "OH" "OK" "OR" "PA" "RI" "SC" "SD" "TN" "TX" "UT" "VT" "VA" "WA" "WV" "WI" "WY" {
	// Get rid of same state migration
	keep if y1_state_name != "`x' Total Migration-Same State"

    save "inflowdata`i'.dta", replace
}
	
}

	// initialize the data set  
	use "inflowdata2122.dta", clear
	foreach i in "2021" "1920" "1819" "1718" "1617" "1516" "1415" "1314" "1213" "1112" {
	append using "inflowdata`i'.dta"
	//drop extra variables 
	drop y1_statefips
	drop y1_state_name 
	drop n1
	drop n2
	drop agi
	//save the data as one merged file
	save "inflowsallyear.dta", replace
}




clear
***follow same process for outflow 

cd "$datainputPath"



//load in data outflows


// Define the list of years
local years "2122 2021 1920 1819 1718 1617 1516 1415 1314 1213 1112"

// Loop through each year and process the files
foreach i of local years {
    // Import the CSV file
    import delimited using "stateoutflow`i'.csv", clear
    // Generate new variables 
	gen Year = `i'
	gen filers_out_N = n1
	gen indv_out_N = n2
	gen agi_out = agi
	gen filers_out_AGI_avg = agi/n1
	// only keep the totals
	keep if y2_statefips==97
    // Save the dataset as a .dta file
    save "outflowdata`i'.dta", replace
}

	
foreach i of local years{

use "outflowdata`i'.dta", replace
 foreach x in  "AL" "AK" "AZ" "AR" "CA" "CO" "CT" "DE" "FL" "GA" "HI" "ID" "IL" "IN" "IA" "KS" "KY" "LA" "ME" "MD" "MA" "MI" "MN" "MS" "MO" "MT" "NE" "NV" "NH" "NJ" "NM" "NY" "NC" "ND" "OH" "OK" "OR" "PA" "RI" "SC" "SD" "TN" "TX" "UT" "VT" "VA" "WA" "WV" "WI" "WY" {
	// Get rid of same state migration
	keep if y2_state_name != "`x' Total Migration-Same State"

	save "outflowdata`i'.dta", replace

}

}

foreach i of local years{
	
	use "outflowdata`i'.dta", replace 
	 merge m:m Year using "inflowdata`i'.dta", keep(match) nogenerate
	 
	 	save "outflowdata`i'.dta", replace
}




	// initialize the data set  
	use "outflowdata2122.dta", clear
	foreach i in "2021" "1920" "1819" "1718" "1617" "1516" "1415" "1314" "1213" "1112" {
	append using "outflowdata`i'.dta"
		//drop extra variables 
	drop y1_statefips
	drop n1
	drop n2
	drop agi
	drop y2_statefips
	drop y2_state_name
	drop y1_state 
	drop y1_state_name

	//save the data as one merged file
	save "totals_migration.dta", replace
}



// do the same in 1011 0910 0809 where the variable names are different 


//load in data inflows


// Define the list of years
local years "1011 0910 0809"

// Loop through each year and process the files
foreach i of local years {
    // Import the CSV file
    import delimited using "stateinflow`i'.csv", clear
	// drop the total US 
	drop if state_code_dest == 0 
    // Generate new variables 
	gen Year = `i'
	gen filers_in_N = return_num
	gen filers_in_AGI_avg = aggr_agi/return_num
	gen indv_in_N = exmpt_num
	gen agi_in = aggr_agi
	rename state_abbrv y2_state
	//look only at totals 
	// only keep the totals
	keep if state_code_origin==97
    // Save the dataset as a .dta file
    save "inflowdata`i'.dta", replace
}

	
foreach i of local years{

use "inflowdata`i'.dta", replace
 foreach x in  "AL" "AK" "AZ" "AR" "CA" "CO" "CT" "DE" "FL" "GA" "HI" "ID" "IL" "IN" "IA" "KS" "KY" "LA" "ME" "MD" "MA" "MI" "MN" "MS" "MO" "MT" "NE" "NV" "NH" "NJ" "NM" "NY" "NC" "ND" "OH" "OK" "OR" "PA" "RI" "SC" "SD" "TN" "TX" "UT" "VT" "VA" "WA" "WV" "WI" "WY" {

	
	save "inflowdata`i'.dta", replace
}
	
}

	// initialize the data set  
	use "inflowsallyear.dta", clear
	foreach i in "1011" "0910" "0809" {
	append using "inflowdata`i'.dta"
	//save the data as one merged file
	save "inflowsallyear.dta", replace
}



clear


***follow same process for outflow 

cd "$datainputPath"



//load in data outflows


// Define the list of years
local years "1011 0910 0809"

// Loop through each year and process the files
foreach i of local years {
    // Import the CSV file
    import delimited using "stateoutflow`i'.csv", clear
	// drop the total US 
	drop if state_code_origin == 0 
    // Generate new variables 
	gen Year = `i'
	gen filers_out_N = return_num
	gen filers_out_AGI_avg = aggr_agi/return_num
	gen indv_out_N = exmpt_num
	gen agi_out = aggr_agi 
	rename state_abbrv y2_state
	//look only at totals 
	// only keep the totals
	keep if state_code_dest==97
    // Save the dataset as a .dta file
    save "outflowdata`i'.dta", replace
}

	
foreach i of local years{

use "outflowdata`i'.dta", replace
 foreach x in  "AL" "AK" "AZ" "AR" "CA" "CO" "CT" "DE" "FL" "GA" "HI" "ID" "IL" "IN" "IA" "KS" "KY" "LA" "ME" "MD" "MA" "MI" "MN" "MS" "MO" "MT" "NE" "NV" "NH" "NJ" "NM" "NY" "NC" "ND" "OH" "OK" "OR" "PA" "RI" "SC" "SD" "TN" "TX" "UT" "VT" "VA" "WA" "WV" "WI" "WY" {

	
	save "outflowdata`i'.dta", replace
	merge m:m Year using "inflowdata`i'.dta", keep(match) nogenerate
	drop state_code_origin
	drop county_code_origin
	drop state_code_dest
	drop county_code_dest
	drop state_name
	drop return_num
	drop exmpt_num
	drop aggr_agi

}
	
}


	// initialize the data set  
	use "totals_migration.dta", clear
	foreach i in "1011" "0910" "0809" {
	append using "outflowdata`i'.dta"
	//save the data as one merged file
	save "outflowsallyear.dta", replace
}



