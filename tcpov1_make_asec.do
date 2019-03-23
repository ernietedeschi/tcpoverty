* TCPOVERTY: STEP 1
* MAKE CPS ASEC
* Ernie Tedeschi
* Last Updated: 21 March 2019

set more off
clear all
pause on

* SETTINGS

local wd "~/Documents/data/cpsasec"									// Working directory
local asec asecmaster.dta											// <--- This is your CPS ASEC extract file. 
																	// If you're downloading from IPUMS, just put
																	// the extract filename here.

local output "~/Documents/data/cpsasec/make taxsim/dtadata.csv"		// Output file to be read into Step 2a in R

* END SETTINGS
******************************************************************************
						
cd `wd'


use year serial relate depstat pernum sex age statefip schlcoll proptax momloc ///
poploc sploc eitcred fedretir fedtax statetax adjginc capgain taxinc fedtaxac ///
fica caploss stataxac incdivid incint incrent incother incalim  incasist incss ///
incwelfr incwkcom incvet incchild incunemp inceduc  gotveduc gotvothe  gotvpens ///
gotvsurv incssi incwage incbus incfarm incsurv incdisab incretir spmfamunit spmtotres spmthresh spmwt ///
if year == 2018 using `asec'

export delimited using `output', nolabel replace

           
           
           
           
