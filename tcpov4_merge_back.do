* TCPOVERTY: STEP 4
* MERGE BACK POVERTY RESULTS 
* Ernie Tedeschi
* Last Updated: 21 March 2019

set more off
clear all
pause on

* SETTINGS

local wd "~/Documents/data/cpsasec"								// Working directory
local asec asecmaster.dta										// CPS ASEC extract
local base "~/c17_taxsim-17-#-#-#.csv"							// Baseline tc CLI dump
local reform "~/c17_taxsim-17-#-reform-#.csv"					// Reform tc CLI dump
local ids "~/Tax-Calculator/taxcalc/validation/taxsim/ids.csv"	// ids.csv file created in Step 2a


* END SETTINGS
******************************************************************************


* Merge ids, base, and reform files, and 
* create a single file with serial, pernum, 
* and the effects of the reform

cd `wd'

import delimited `ids', case(preserve) clear 

save ids,replace

import delimited `base', case(preserve) clear 
keep RECID aftertax_income
ren aftertax ati1
save c17_base, replace

import delimited `reform', case(preserve) clear 
merge 1:1 RECID using c17_base, nogen keep(master match)
merge 1:1 RECID using ids, nogen keep(master match)
gen dati = aftertax_income - ati1

keep serial pernum dati

save dreform, replace

* Merge the effects file into the CPS ASEC

use year age serial pernum spmwt spmthresh spmtotres spmfamunit if year == 2018 using `asec'

merge 1:1 serial pernum using dreform, nogen keep(master match)	

* Aggregate reform effects by SPM family unit

bysort spmfamunit: egen sum_dati = total(dati)

* Create baseline (spm1) and reform (spm2) SPM poverty indicators

gen spm1 = spmtotres < spmthresh
gen spm2 = (spmtotres + sum_dati) < spmthresh
gen out_of_spm = spm2 == 0 & spm1 == 1

* See SPM poverty results

tab spm1 [iw=spmwt]
tab spm2 [iw=spmwt]
tab out_of_spm [iw=spmwt]

tab spm1 if age < 18 [iw=spmwt]
tab spm2 if age < 18 [iw=spmwt]
tab out_of_spm if age < 18 [iw=spmwt]
