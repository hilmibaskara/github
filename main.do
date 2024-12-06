// Load Data
use "C:\Users\hilmi\Desktop\Quanti\data.dta"

// Drop unwanted rows based on marital status
drop if single == 1 | widow == 1 | separd == 1 | unkqual == 1

// Keep Selecteed Variables
keep pserial A005 Satis Worth Happy Anxious married cohab disios childs selfemp empee inactiv edgvttr unemp rlondon rneu rner rnwu rnwr ryorksu ryorksr remidu remidr rwmidu rwmidr reu rer rseu rser rswu rswr rwalesu rwalesr rscotu rscotr deg lhed alev onc_btec gcsepass gcsefail othqual noqual

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
replace education_level = 3 if deg == 1
replace education_level = 2 if lhed == 1 | alev == 1 | onc_btec == 1
replace education_level = 1 if gcsepass == 1 | gcsefail == 1 | othqual == 1
replace education_level = 0 if noqual == 1

// label define edu_label 1 "High Education" 2 "Low Education" 3 "No Education"
label values education_level edu_label

// b. Urban vs Rural
gen is_urban = .
replace is_urban = 1 if rlondon == 1 | rneu == 1 | rnwu == 1 | ryorksu == 1 | remidu == 1 | rwmidu == 1 | reu == 1 | rseu == 1 | rswu == 1 | rwalesu == 1 | rscotu == 1
replace is_urban = 0 if rner == 1 | rnwr == 1 | ryorksr == 1 | remidr == 1 | rwmidr == 1 | rer == 1 | rser == 1 | rswr == 1 | rwalesr == 1 | rscotr == 1
// label define urb_label 1 "Urban" 2 "Rural"
label values is_urban urb_label

summarize Satis Worth Happy Anxious childs education_level is_urban

// Frequencies for Categorical Variables
tabulate married
tabulate cohab
tabulate education_level
tabulate is_urban

// Histograms for Wellbeing Variables
histogram Satis, bin(10) percent normal title("Histogram of Satisfaction")
histogram Worth, bin(10) percent normal title("Histogram of Worthwhile Feeling")
histogram Happy, bin(10) percent normal title("Histogram of Happiness")
histogram Anxious, bin(10) percent normal title("Histogram of Anxiety")

// Bar Graphs for Categorical Variables
graph bar (mean) Satis, over(married) title("Mean Satisfaction by Marital Status")
graph bar (mean) Satis, over(cohab) title("Mean Satisfaction by Cohabitation Status")
graph bar (mean) Satis, over(education_level) title("Mean Satisfaction by Education Level")
graph bar (mean) Satis, over(is_urban) title("Mean Satisfaction by Urban/Rural")

// t-test for Cohabitation vs Marriage
ttest Satis, by(married)
ttest Satis, by(cohab)

// Additional Wellbeing Metrics
ttest Worth, by(married)
ttest Worth, by(cohab)
ttest Happy, by(married)
ttest Happy, by(cohab)
ttest Anxious, by(married)
ttest Anxious, by(cohab)

// Regression Models for Wellbeing Outcomes
regress Satis married cohab education_level is_urban childs
regress Worth married cohab education_level is_urban childs
regress Happy married cohab education_level is_urban childs
regress Anxious married cohab education_level is_urban childs

// Adjusted Models Including Interaction Terms
regress Satis married##cohab education_level is_urban childs
regress Worth married##cohab education_level is_urban childs
