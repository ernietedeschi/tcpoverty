# tcpoverty
Code for Analysis of Poverty Using Tax-Calculator

These files lay out steps for analyzing the effect to the US Census Bureau's Supplemental Poverty Measure (SPM) of a reform run using the open source [Tax-Calculator](https://github.com/PSLmodels/Tax-Calculator) tax microsimulation model.

For more information, consult the March 2019 presentation to the Policy Simulation Library (PSL) meeting, **`psl_presentation_v2.pdf`**

The files assume that you have created an extract of the CPS ASEC for a single year at the University of Minnesota's [IPUMS](http://ipums.org) service. See the files or the presentation for the IPUMS variables needed.

The files are named in order of sequence:

1. **`tcpov1_make_asec.do`**: Stata do file for turning an IPUMS CPS ASEC extract in Stata format into csv format. *If your IPUMS extract is already in csv format, this step is unnecessary.*
2. **`tcpov2a_make_taxsim27.R`**: R file based heavily on prior code from Sam Portnow. This converts the IPUMS CPS ASEC extract in csv format into a file that is grouped by tax units.
3. **`tcpov2b_make_tc_file.do`**: Just a placeholder file telling you to run Tax-Calculator's built-in TAXSIM27 script on the file produced in the prior step.
4. **`tcpov3_run_reform.do`**: Placeholder file telling you to run both a baseline and reform sim in Tax-Calculator's CLI using the file produced in the prior step as the database file.
5. **`tcpov4_merge_back.do`**: Stata do file for merging Tax-Calculator results back into the CPS ASEC and tabulating poverty impacts.
