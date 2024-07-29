//merge the IRS data to the county fipps / csa cross walk from NBER 

cd "$datainputPath"

//create a county inflow data set 
// Define the list of years
local years "2122 2021 1920 1819 1718 1617 1516 1415 1314 1213 1112"

// Loop through each year and process the files
foreach i of local years {
    // Import the CSV file
    import delimited using "countyinflow`i'.csv", clear
	//gen year variable 
	gen Year = `i'
	
save "cbsa_county_origindata`i'.dta", replace
	//merge with the cbsa
	use "cbsa2fipsxw.dta", clear 

// destring the fipscountycode
destring fipscountycode, generate(y1_countyfips)
destring cbsacode, generate(cbsa1)
destring fipsstatecode, generate(y1_statefips)


//drop other variables 
drop cbsacode 
drop metropolitandivisioncode
drop metropolitandivisiontitle
drop metropolitanmicropolitanstatis
drop csatitle
drop fipsstatecode
drop fipscountycode
drop centraloutlyingcounty
drop csacode 


//merge with y1_countyfips and y1_statefips origin data 

merge 1:m y1_statefips y1_countyfips using "cbsa_county_origindata`i'.dta", keep(match) 
drop _merge

save "cbsa1`i'.dta", replace 

//match the cbsa counties to y2_countyfips and y2_statefips destinations 
    import delimited using "countyoutflow`i'.csv", clear
	//gen year variable 
	gen Year = `i'
save "cbsa_county_destdata`i'.dta", replace
use "cbsa2fipsxw.dta", clear 

// destring the fipscountycode
destring fipscountycode, generate(y2_countyfips)
destring cbsacode, generate(cbsa2)
destring fipsstatecode, generate(y2_statefips)


//drop other variables 
drop cbsacode 
drop metropolitandivisioncode
drop metropolitandivisiontitle
drop metropolitanmicropolitanstatis
drop csatitle
drop fipsstatecode
drop fipscountycode
drop centraloutlyingcounty
drop csacode 

merge 1:m y2_statefips y2_countyfips using "cbsa_county_destdata`i'.dta", keep(match) 
drop _merge
//save as a new data set 
save "cbsa2`i'.dta", replace 

//use the y2 and y1 counties by cbsa and match them by cbsa -- that way looking at migration within the same cbsa
use "cbsa1`i'.dta", clear 
merge m:m y1_countyfips y1_statefips y2_countyfips y2_statefips using "cbsa2`i'.dta" 

    // Save the dataset as a .dta filed
    save "cbsa_by_county_inflowdata`i'.dta", replace


}


	// initialize the data set  
	use "cbsa_by_county_inflowdata2122.dta", clear
	foreach i in "2021" "1920" "1819" "1718" "1617" "1516" "1415" "1314" "1213" "1112" {
	append using "cbsa_by_county_inflowdata`i'.dta"

	//save the data as one merged file
	save "cbsa_county_inflows20112022years.dta", replace
}





//look at only 35620 the new york, newark, jersey city cbsa 

//keep if cbsa == 35620 




