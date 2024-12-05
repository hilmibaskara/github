// Load Data
use "C:\Users\hilmi\Desktop\Quanti\data.dta"

// Drop unwanted rows based on marital status
drop if single == 1 | widow == 1 | separd == 1

// Keep Selecteed Variables
keep A005 Satis Worth Happy Anxious married cohab disios childs selfemp empee inactiv unemp rlondon rneu rner rnwu rnwr ryorksu ryorksr remidu remidr rwmidu rwmidr reu rer rseu rser rswu rswr rwalesu rwalesr rscotu rscotr lhed alev onc_btec gcsepass gcsefail othqual noqual unkqual

// Data Cleansing
// a. Data types
destring Satis, replace force
destring Worth, replace force
destring Happy, replace force
destring Anxious, replace force

// b. Handling missing value
drop if missing(Satis) | missing(Worth) | missing(Happy) | missing(Anxious)

// c. Exclude outlier

// Data Formatting
// a. Education Data
gen education_level = .
replace education_level = 3 if lhed == 1 | alev == 1 | onc_btec == 1
replace education_level = 2 if gcsepass == 1 | gcsefail == 1 | othqual == 1
replace education_level = 1 if noqual == 1

// label define edu_label 1 "High Education" 2 "Low Education" 3 "No Education"
label values education_level edu_label

// b. Urban vs Rural
gen is_urban = .
replace is_urban = 1 if rlondon == 1 | rneu == 1 | rnwu == 1 | ryorksu == 1 | remidu == 1 | rwmidu == 1 | reu == 1 | rseu == 1 | rswu == 1 | rwalesu == 1 | rscotu == 1
replace is_urban = 0 if rner == 1 | rnwr == 1 | ryorksr == 1 | remidr == 1 | rwmidr == 1 | rer == 1 | rser == 1 | rswr == 1 | rwalesr == 1 | rscotr == 1
// label define urb_label 1 "Urban" 2 "Rural"
label values is_urban urb_label

summarize Satis Worth Happy Anxious childs education_level urban_rural