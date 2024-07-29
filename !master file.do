//Molly's summer internship: Tax's and migration May20th-August2nd 2024
//master .do file 

clear all
macro drop _all
set more off


global base "/Users/main/Documents/Dropbox/Research/Main" //  "/Users/mollyardren/Dropbox/Main"
global programPath     "$base/codes"                                     // baseline programs 

//data from IRS and intermediate data 
global datainputPath "$base/data_raw"
//result path 
global dataoutputPath  "$base/data_final"                               // IRSdata 
//graphs 
global graphoutputPath  "$base/graphs"   



//find totals for all migrant filers, inflows and outflows 1995-2021

//merge IRS inflow and outflow data, appends all years, and calculate the total filers in, filers out, and average AGI 2011-2022
do "$programPath/IRS inflow outflows 2008-2022"
save "$datainputPath/CSV_inflow_outflows", replace 


//merge all the the .xls spreadsheets of inflows from 1990-2007 
do "$programPath/merging XLS inflows"
save "$datainputPath/XLS_inflows", replace 


//merge all the the .xls spreadsheets of outflows from 1990-2007 and merge inflow data 
do "$programPath/outflows XLS data merging"
save "$datainputPath/XLS_outflows", replace 


//finding "non migrant filers, indv, agi" from 1995-2022
do "$programPath/nonmigrant data to append"
save "$dataoutputPath/nonmigrant_data", replace 

//merge into one file spanning from 1996 to 2022 of migrant net values and nonmigrants 
do "$programPath/nonmigrant and net migrant totals"
save "$dataoutputPath/nonmigrant_netmigrant_merged", replace 

//time series graph of California, Texas, Florida, and NewYork net migrant/ potentila migrant ratios from 1995/96 to 2021/22
do "$programPath/time series graph net mig and non mig"



//generate same state variable, add it to nonmig and create potential migrant ratios from 2007/2008 to 2021/2022
do "$programPath/potential migrant data merge"
save "$dataoutputPath/potmig_data", replace 

//bar plot of net migrant to potential migrant agi, filers, indv 
do "$programPath/bar net migrant ratios"



// AGI inflows by county, so we can get an idea of the average income group moving into each state 
do "$programPath/total migrants from different states AGI by county "
save "$dataoutputPath/total_mig_diff_state_AGI_bycounty", replace 

// creating a county level data set to have a comparison between cross-state flows and cross-county flows (within each state), and bar graphs of percent of migration that crossed state borders
do "$programPath/county_out_ratios"



// sorting county inflows by cbsa so we can merge the cbsa identifier into the data set 
do "$programPath/sorting counties by cbsa"
save "$dataoutputPath/counties_by_cbsa", replace 

// This data set that looks at the percent of migrants within a CBSA that cross state lines within the same CBSA. First I found the total migration within a CBSA that cross a state line, then those within the same cbsa who migrated within their state, and the total non-migrants. Then I added the same-state, same CBSA migrants with the different-state same CBSA migrants to get the total cbsa migrants. I found the percent of migrants within the cbsa that crossed state boarders, and summed this percent by CBSA and year.
do "$programPath/CBSA tax migration"
save "$dataoutputPath/CBSA_migration_diff_state", replace 

// Time series graphs of state migration within a CBSA using the data set above 
do "$programPath/CBSA state crossing time series"



