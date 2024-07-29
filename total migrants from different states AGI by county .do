//get total migrants from different states agi by county 

//2011-2022
cd "$datainputPath"

//add description
//finding total migrants agi by county who migrated from a different state to see the distribution of migrant agi inflows in the state 

//load in data inflows


// Define the list of years
local years "2122 2021 1920 1819 1718 1617 1516 1415 1314 1213 1112"

// Loop through each year and process the files
foreach i of local years {
    // Import the CSV file
    import delimited using "countyinflow`i'.csv", clear
	// only keep the totals US, Same state, different state 
	keep if y1_statefips==97
	
	gen Year = `i'
	
		//Gen different state migration
		keep if y1_countyfips ==3
	gen D_filers_in_N1 = n1 if y1_countyfips == 3
	gen D_indv_in_N1 = n2 if y1_countyfips == 3
	gen D_agi_in1 = agi if y1_countyfips == 3
	gen D_filers_in_AGI_avg = agi/n1 if y1_countyfips == 3
	

	
    // Save the dataset as a .dta file
    save "county_AGI_inflowdata`i'.dta", replace


}


	


	// initialize the data set  
	use "county_AGI_inflowdata2122.dta", clear
	foreach i in "2021" "1920" "1819" "1718" "1617" "1516" "1415" "1314" "1213" "1112" {
	append using "county_AGI_inflowdata`i'.dta"
	//drop extra variables 
	drop n1
	drop n2
	drop agi
	//save the data as one merged file
	save "county_AGI_inflowsallyear.dta", replace
}
