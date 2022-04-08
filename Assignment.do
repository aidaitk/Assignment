*7. Read .csv data in Stata
import delimited using "/Users/aidai/Documents/CEU/Coding for Economists/dc-economics-v2/data/derived/gdp-wide.csv", clear

* 15. Install a Stata package
ssc install outreg2

* 10. Prepare a sample for analysis by filtering observations and variables and creating transformations of variables. Demonstrate all three
use "/Users/aidai/Documents/CEU/Coding for Economists/nls.dta", clear
keep ed76 lwage76 black daded momed kww smsa76 nearc4 age76 momdad14 sinmom14 step14 iq reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 reg669

lab var ed76 "Education level in 1976"
lab var lwage76 "Log wage in 1976"
lab var black "Black (1 = yes)"
lab var daded "Father Education"
lab var momed "Mother Education"
lab var kww "KWW score"
lab var smsa76 "Metropolitan area in 1976 (1 = yes)"
lab var nearc4 "Living near 4 year college"
lab var age76 "Age in 1976"
lab var momdad14 "Living with both parents at age 14 (1 = yes)"
lab var sinmom14 "Living with single mom at age 14 (1 = yes)"
lab var step14 "Living with step parent at age 14 (1 = yes)"
lab var iq "Normed IQ score"

* 11. Save data in Stata
save "/Users/aidai/Documents/CEU/Coding for Economists/nls.dta", replace

* 5. Automate repeating tasks using Stata "for" loops
gen region = "1" if reg661 == 1
forvalues i = 2/9 {
replace region = region + "`i'" if reg66`i' ==1 
}

codebook region
tabulate region, generate(regionfe)

* 6. Break up work into smaller components using Stata .do files
gen exper=age76-ed76-6
gen exper2=exper^2

lab var exper "Experience"
lab var exper2 "Experience squared"

* 8. Fix common data quality errors in Stata (for example, string vs number, missing value).
egen mean_iq=mean(iq)
replace iq=mean_iq if iq==.

* 12. Run ordinary least squares regression in Stata
reg ed76 nearc4 exper exper2 regionfe* black daded momed momdad14 sinmom14 step14 smsa76

* 13. Create a graph (of any type) in Stata
twoway (scatter lwage76 ed76), ytitle(lwage76) xtitle(ed76) title(Education and wage)

* 14. Save regression tables and graphs as files. Demonstrate both */
outreg2 using wage, excel replace ctitle("Wage") label
graph export wage, as(pdf)

* 9. Aggregate, reshape, and combine data for analysis in Stata
collapse lwage76 exper, by(black)
