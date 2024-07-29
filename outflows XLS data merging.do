// creating merged outflow data sets for years that have no .csv file 

//starting with 1011 0910 0809 0708 0607 0506 0405

//merge all the states outflow

// Define the list of years
local years "0708 0607 0506"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
 foreach x in  "Alabama" "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "Delaware" "DistrictofColumbia" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming" {
 	
	import excel "`x'`i'out.xls", cellrange(A9:F60) clear
 	destring A, generate(state_fips)
	generate Year = `i'
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen filers_out_AGI_avg = agi/filers
	
// only keep total migrants 
	keep if state_fips == 97
	
	//merge and save as .dta file 
	merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
	save "`x'`i'out.dta", replace
}

 
 

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/Alabama`i'out.dta", clear 
 foreach j in "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "Delaware" "DistrictofColumbia" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming" {
	append using "`j'`i'out.dta"
	//drop other variables 
	drop A
	drop state_fips
	drop C
	drop year 
	//save the data as one merged file
	save "outflow`i'.dta", replace
	
}

}




//do the same for 0405 where the fipps codes are not string val 
// Define the list of years
local years "0405"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
 foreach x in  "Alabama" "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "Delaware" "DistrictofColumbia" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming" {
 	
	import excel "`x'`i'out.xls", cellrange(A9:F60) clear
 	rename A state_fips
	generate Year = `i'
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen year = `i'
	gen filers_out_AGI_avg = agi/filers
	
// only keep total migrants 
	keep if state_fips == 97
	
	
	//save as .dta file 
		
	//merge and save as .dta file 
	merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
    save "`x'`i'out.dta", replace
	

 
 }

 //append states into one file 
 // set working directory 
 use "$datainputPath/state0405/Alabama`i'out.dta", clear 
 foreach j in "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "Delaware" "DistrictofColumbia" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming" {
	append using "`j'`i'out.dta"
	//save the data as one merged file
		//drop other varibales 
	drop state_fips 
	drop C
	drop year
	save "outflow`i'.dta", replace
}

}


//add 0304 which have different .xls filenames 
local years "0304"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
 foreach x in  "alab" "alas" "ariz" "arkas" "cali" "colo" "conn" "dela" "dico" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nrbt" "neva" "neha" "neje" "neme" "neyo" "noca" "noda" "ohio" "okla" "oreg" "penn" "rhod" "soca" "soda" "tenn" "texa" "utah" "verm" "virg" "wash" "wvir" "wisc" "wyom" {
 	
	import excel "`x'04ot.xls", cellrange(A9:F10) clear
 	rename A state_fips
	generate Year = `i'
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen filers_out_AGI_avg = agi/filers
	
// only keep total migrants 
	keep if state_fips == 97
	
	//save as .dta file 
	merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
    save "`x'`i'out.dta", replace
	 

 
 }

 //append states into one file 
 // set working directory 
 use "$datainputPath/state0304/alab0304out.dta", clear 
foreach j in "alas" "ariz" "arkas" "cali" "colo" "conn" "dela" "dico" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nrbt" "neva" "neha" "neje" "neme" "neyo" "noca" "noda" "ohio" "okla" "oreg" "penn" "rhod" "soca" "soda" "tenn" "texa" "utah" "verm" "virg" "wash" "wvir" "wisc" "wyom" {
	append using "`j'`i'out.dta", force
	
	//drop other variables 
	drop state_fips
	drop C
	drop year
	//save the data as one merged file
	save "outflow`i'.dta", replace
}

}



// finish with the rest of the years where the files are neamed in lowercase
local years "0203"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "03" {	
 foreach x in  "alab" "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "virg" "wash" "west" "wisc" "wyom" {
 	
	import excel "`x'`p'ot.xls", cellrange(A9:F60) clear
	destring A, generate(state_fips)
	gen Year = `i'
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen year = `i'
	gen filers_out_AGI_avg = agi/filers
	
// only keep total migrants 
	keep if state_fips == 97
	
	//save as .dta file 
	merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/alab`i'out.dta", clear 
 foreach j in "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "virg" "wash" "west" "wisc" "wyom"  {
	append using "`j'`i'out.dta"
		//drop other variables 
	drop state_fips
	drop C
	drop A
	drop year
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}



// finish with the rest of the years where the files are neamed in lowercase
local years "0102"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "02" {	
 foreach x in  "alab" "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "virg" "wash" "west" "wisc" "wyom" {
 	
	import excel "`x'`p'ot.xls", cellrange(A9:F60) clear
	destring A, generate(state_fips)
	generate Year = `i'
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen year = `i'
	gen filers_out_AGI_avg = agi/filers
	
// only keep total migrants 
	keep if state_fips == 97
	
	//save as .dta file 
	merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/alab`i'out.dta", clear 
 foreach j in "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "virg" "wash" "west" "wisc" "wyom"  {
	append using "`j'`i'out.dta"
	//drop variables
	drop A
	drop state_fips
	drop C
	drop year 
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}



// finish with the rest of the years where the files are neamed in lowercase
local years "0001"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "01" {	
 foreach x in  "alab" "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "vrg" "wash" "west" "wisc" "wyom" {
 	
	import excel "`x'`p'otr.xls", cellrange(A9:F60) clear
	destring A, generate(state_fips)
	rename B y2_state
	generate Year = `i'
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen year = `i'
	gen filers_out_AGI_avg = agi/filers
	
// only keep total migrants 
	keep if state_fips == 97
	
	//save as .dta file 
	merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/alab`i'out.dta", clear 
 foreach j in "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "vrg" "wash" "west" "wisc" "wyom"  {
	append using "`j'`i'out.dta"
	
//drop var 
drop A
drop state_fips
drop C
drop year
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}


// finish with the rest of the years where the files are neamed in lowercase
local years "9900"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "00" {	
 foreach x in  "alab" "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "vrg" "wash" "west" "wisc" "wyom" {
 	
	import excel "`x'`p'ot.xls", cellrange(A9:F60) clear
	destring A, generate(state_fips)
	generate Year = `i'
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen year = `i'
	gen filers_out_AGI_avg = agi/filers
	
// only keep total migrants 
	keep if state_fips == 97
	
	//save as .dta file 
		merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/alab`i'out.dta", clear 
 foreach j in "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "vrg" "wash" "west" "wisc" "wyom"  {
	append using "`j'`i'out.dta"
	//drop variables 
	drop A 
	drop state_fips
	drop C
	drop year
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}

// finish with the rest of the years where the files are neamed in lowercase
local years "9899"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "99" {	
 foreach x in  "alab" "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "virg" "wash" "west" "wisc" "wyom" {
 	
	import excel "`x'`p'ot.xls", cellrange(A9:F60) clear
	destring A, generate(state_fips)
	generate Year = `i'
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen year = `i'
	gen filers_out_AGI_avg = agi/filers
	
// only keep total migrants 
	keep if state_fips == 97
	
	//save as .dta file 
		merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/alab`i'out.dta", clear 
 foreach j in "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "virg" "wash" "west" "wisc" "wyom"  {
	append using "`j'`i'out.dta"
	//drop variables 
	drop A
	drop state_fips
	drop C
	drop year 
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}


// finish with the rest of the years where the files are neamed in lowercase
local years "9798"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "98" {	
 foreach x in  "alab" "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "for" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "vrg" "wash" "west" "wsc" "wyom" {
 	
	import excel "`x'`p'ot.xls", cellrange(A9:F60) clear
	destring A, generate(state_fips)
	generate Year =`i'
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen year = `i'
	gen filers_out_AGI_avg = agi/filers
	
// only keep total migrants 
	keep if state_fips == 97
	
	//save as .dta file 
		merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/alab`i'out.dta", clear 
 foreach j in "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "for" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "vrg" "wash" "west" "wsc" "wyom"  {
	append using "`j'`i'out.dta"
	//drop variables 
	drop A 
	drop state_fips 
	drop year 
	drop C
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}

//do alabama seprately because of strig variable 
	cd "$datainputPath/state9697"
	 	
	import excel "alab97ot.xls", cellrange(A9:F20)  clear
	destring A, generate(state_fips)
	generate Year = 9697
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen filers_out_AGI_avg = agi/filers
	
		keep if state_fips == 97
	
	merge 1:1 Year using "alab9697in.dta", keep(match) nogenerate
    save "alab9697out.dta", replace
	
	clear
	
// finish with the rest of the years where the files are neamed in lowercase
local years "9697"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "97" {	
 foreach x in "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "virg" "wash" "west" "wsc" "wyom" {
 	
	import excel "`x'`p'ot.xls", cellrange(A9:F20)  clear
	rename A state_fips
	generate Year =`i'
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen filers_out_AGI_avg = agi/filers
	
// only keep total migrants 
	keep if state_fips == 97
	
	//save as .dta file 
	merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/alab`i'out.dta", clear 
 foreach j in "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "ncar" "ndak" "ohio" "okla" "oreg" "penn" "rhod" "scar" "sdak" "tenn" "texa" "utah" "verm" "virg" "wash" "west" "wsc" "wyom"  {
	append using "`j'`i'out.dta"
	//drop variables
	drop A 
	drop state_fips 
	drop C
	drop year 
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}


 
// finish with the rest of the years where the files are neamed in lowercase
local years "9596"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "956" {	
 foreach x in  "al" "ak" "az" "ar" "ca" "co" "ct" "de" "dc" "fl" "ga" "hi" "id" "il" "in" "ia" "ks" "ky" "la" "me" "md" "ma" "mi" "mn" "ms" "mo" "mt" "ne" "nv" "nh" "nj" "nm" "ny" "nc" "nd" "oh" "ok" "or" "pa" "ri" "sc" "sd" "tn" "tx" "ut" "vt" "va" "wa" "wv" "wi" "wy" {
 	
	import excel "s`p'`x'or.xls", cellrange(A10:F60) clear
	destring A, generate(state_fips)
	generate Year = `i'
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen year = `i'
	gen filers_out_AGI_avg = agi/filers
	
// only keep total migrants 
	keep if state_fips == 97
	
	//save as .dta file 
	merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/al`i'out.dta", clear 
 foreach j in "ak" "az" "ar" "ca" "co" "ct" "de" "dc" "fl" "ga" "hi" "id" "il" "in" "ia" "ks" "ky" "la" "me" "md" "ma" "mi" "mn" "ms" "mo" "mt" "ne" "nv" "nh" "nj" "nm" "ny" "nc" "nd" "oh" "ok" "or" "pa" "ri" "sc" "sd" "tn" "tx" "ut" "vt" "va" "wa" "wv" "wi" "wy"  {
	append using "`j'`i'out.dta"
	//drop variables 
	drop A 
	drop state_fips 
	drop C
	drop year 
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}



// finish with the rest of the years where the files are neamed in lowercase
local years "9495"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "95" {	
 foreach x in  "alab" "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "noca" "noda" "ohio" "okla" "oreg" "penn" "rhod" "soca" "soda" "tenn" "texa" "utah" "verm" "virg" "wash" "west" "wisc" "wyom" {
 	
	import excel "`x'`p'ot.xls", cellrange(A9:F60) clear
	rename A state_fips
	generate Year = `i'
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen year = `i'
	gen filers_out_AGI_avg = agi/filers
	
	
	
// only keep total migrants 
	keep if C == "Total Outflow"
	
	//save as .dta file 
		merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate

    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/alab`i'out.dta", clear 
 foreach j in "alas" "ariz" "arka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "noca" "noda" "ohio" "okla" "oreg" "penn" "rhod" "soca" "soda" "tenn" "texa" "utah" "verm" "virg" "wash" "west" "wisc" "wyom"  {
	append using "`j'`i'out.dta"
	//drop variable
	

	drop C
	drop year 
	drop y2_state
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}


// finish with the rest of the years where the files are neamed in lowercase
local years "9394"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "94" {	
 foreach x in  "alab" "alas" "az" "aka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "noca" "noda" "ohio" "okla" "oreg" "penn" "rhod" "soca" "soda" "tenn" "texa" "utah" "verm" "vrg" "wash" "west" "wisc" "wyom" {
 	
	import excel "`x'`p'ot.xls", cellrange(A9:F60) clear
	generate Year = `i'
	rename A state_fips
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen year = `i'
	gen filers_out_AGI_avg = agi/filers
	
	
	
// only keep total migrants 
	keep if C == "Total Outflow"
	
	//save as .dta file 
			merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/alab`i'out.dta", clear 
 foreach j in "alas" "az" "aka" "cali" "colo" "conn" "dela" "dist" "flor" "geor" "hawa" "idah" "illi" "indi" "iowa" "kans" "kent" "loui" "main" "mary" "mass" "mich" "minn" "miss" "miso" "mont" "nebr" "neva" "newh" "newj" "newm" "newy" "noca" "noda" "ohio" "okla" "oreg" "penn" "rhod" "soca" "soda" "tenn" "texa" "utah" "verm" "vrg" "wash" "west" "wisc" "wyom"  {
	append using "`j'`i'out.dta"
	//drop variables 
	drop C
	drop year
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}


	

local years "9293"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "93" {	
 foreach x in  "Alabama" "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "Delaware" "DistrictofColumbia" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming"{
 	
	import excel "`x'`p'out.xls", cellrange(A9:F61) clear
	destring A, generate(state_fips)
	generate Year = `i'
	rename B y2_state
	rename D filers_out_N
	rename E indv_out_N
	rename F agi_out
	gen filers_out_AGI_avg = agi/filers
	
	
// only keep total migrants 

keep if y2_state == "XX"
	
	//save as .dta file 
	merge 1:1 Year using "`x'`i'in.dta", keep(match) nogenerate
    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/Alabama`i'out.dta", clear 
 foreach j in "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "Delaware" "DistrictofColumbia" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "NewHampshire" "NewJersey" "NewMexico" "NewYork" "NorthCarolina" "NorthDakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "RhodeIsland" "SouthCarolina" "SouthDakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "WestVirginia" "Wisconsin" "Wyoming"  {
	append using "`j'`i'out.dta"
	//drop variables 
	drop A
	drop state_fips 
	drop C
	drop year 
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}






local years "9192"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "92" {	
 foreach x in  "Alabama" "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "Delaware" "District of Columbia" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "New Hampshire" "New Jersey" "New Mexico" "New York" "North Carolina" "North Dakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "Rhode Island" "South Carolina" "South Dakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "West Virginia" "Wisconsin" "Wyoming"{
 	
	import excel "`x'`p'out.xls", cellrange(A9:F61) clear
	
	destring A, generate(state_fips)
	rename B state
	rename D filers_out_N
	rename F indv_out_N
	gen year = `i'
	

	
// only keep total migrants 

keep if C == "TOTAL FLOW"
	
	//save as .dta file 
    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/Alabama`i'out.dta", clear 
 foreach j in "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "Delaware" "District of Columbia" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "New Hampshire" "New Jersey" "New Mexico" "New York" "North Carolina" "North Dakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "Rhode Island" "South Carolina" "South Dakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "West Virginia" "Wisconsin" "Wyoming"  {
	append using "`j'`i'out.dta"
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}


local years "9091"

foreach i of local years {
	// set working directory 
	cd "$datainputPath/state`i'"
foreach p in "91" {	
 foreach x in  "Alabama" "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "Delaware" "District of Columbia" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "New Hampshire" "New Jersey" "New Mexico" "New York" "North Carolina" "North Dakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "Rhode Island" "South Carolina" "South Dakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "West Virginia" "Wisconsin" "Wyoming"{
 	
	import excel "`x'`p'out.xls", cellrange(A9:G61) clear
	
	destring A, generate(state_fips)
	rename B state
	rename E filers_out_N
	rename G indv_out_N
	gen year = `i'
	

	
// only keep total migrants 

keep if state_fips==96
	
	//save as .dta file 
    save "`x'`i'out.dta", replace
	
}

 //append states into one file 
 // set working directory 
 use "$datainputPath/state`i'/Alabama`i'out.dta", clear 
 foreach j in "Alaska" "Arizona" "Arkansas" "California" "Colorado" "Connecticut" "Delaware" "District of Columbia" "Florida" "Georgia" "Hawaii" "Idaho" "Illinois" "Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Maryland" "Massachusetts" "Michigan" "Minnesota" "Mississippi" "Missouri" "Montana" "Nebraska" "Nevada" "New Hampshire" "New Jersey" "New Mexico" "New York" "North Carolina" "North Dakota" "Ohio" "Oklahoma" "Oregon" "Pennsylvania" "Rhode Island" "South Carolina" "South Dakota" "Tennessee" "Texas" "Utah" "Vermont" "Virginia" "Washington" "West Virginia" "Wisconsin" "Wyoming"  {
	append using "`j'`i'out.dta", force
	//save the data as one merged file
	save "outflow`i'.dta", replace
}
}
}




 
//append the years into one file

 
 cd "$datainputPath/state0708" 
use "outflow0708.dta", clear
foreach i in "0607" "0506" "0405" "0304" "0203" "0102" "0001" "9900" "9899" "9798" "9697" "9596" "9495" "9394"    {
 cd "$datainputPath/state`i'"
	append using "outflow`i'.dta", force
		//save as .dta file 
	cd "$datainputPath"
    save "0607-9293_out.dta", replace
	
	
}
