// Load Data
use "C:\Users\hilmi\Desktop\Quanti\data.dta"

preserve

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
/* label values education_level edu_label */

// b. Urban vs Rural
gen is_urban = .
replace is_urban = 1 if rlondon == 1 | rneu == 1 | rnwu == 1 | ryorksu == 1 | remidu == 1 | rwmidu == 1 | reu == 1 | rseu == 1 | rswu == 1 | rwalesu == 1 | rscotu == 1
replace is_urban = 0 if rner == 1 | rnwr == 1 | ryorksr == 1 | remidr == 1 | rwmidr == 1 | rer == 1 | rser == 1 | rswr == 1 | rwalesr == 1 | rscotr == 1
// label define urb_label 1 "Urban" 2 "Rural"
/* label values is_urban urb_label */

// c. Employment Status
replace empee = 1 if selfemp == 1

// Descriptive Statistics
summarize A005 Satis Worth Happy Anxious childs disios education_level is_urban


// Frequencies for Categorical Variables
tabulate married
tabulate cohab
tabulate education_level
tabulate is_urban

// Histograms for Wellbeing Variables
// for married
histogram Satis if married == 1, bin(10) percent normal title("Histogram of Satisfaction")
histogram Worth if married == 1, bin(10) percent normal title("Histogram of Worthwhile Feeling")
histogram Happy if married == 1, bin(10) percent normal title("Histogram of Happiness")
histogram Anxious if married == 1, bin(10) percent normal title("Histogram of Anxiety")

// for cohab
histogram Satis if married == 0, bin(10) percent normal title("Histogram of Satisfaction")
histogram Worth if married == 0, bin(10) percent normal title("Histogram of Worthwhile Feeling")
histogram Happy if married == 0, bin(10) percent normal title("Histogram of Happiness")
histogram Anxious if married == 0, bin(10) percent normal title("Histogram of Anxiety")

// Bar Graphs for Categorical Variables
graph bar (mean) Satis, over(married) title("Mean Satisfaction by Marital Status")
graph bar (mean) Worth, over(married) title("Mean Satisfaction by Marital Status")
graph bar (mean) Happy, over(married) title("Mean Satisfaction by Marital Status")
graph bar (mean) Anxious, over(married) title("Mean Satisfaction by Marital Status")

// age for married
histogram A005 if married == 1
histogram A005 if married == 0

// dispos
summarize disios if married == 1
summarize disios if married == 0

// number of childs
tabulate childs if married == 1
tabulate childs if married == 0

// employment status
graph pie if married == 1, over (empee) plabel(_all percent)
graph pie if married == 0, over (empee) plabel(_all percent)

// level of education
graph pie if married == 1, over (education_level) plabel(_all percent)
graph pie if married == 0, over (education_level) plabel(_all percent)

// urban and rural
graph pie if married == 1, over (is_urban) plabel(_all percent)
graph pie if married == 0, over (is_urban) plabel(_all percent)

// t-test for Cohabitation vs Marriage
ttest Satis, by(married)
ttest Worth, by(married)
ttest Happy, by(married)
ttest Anxious, by(married)

// Multivariate analysis nya BELUM YAKIN hwehae sorry i'll do it
correlate Satis Worth Happy Anxious A005 married disios childs empee education_level is_urban

// Basic Comparison (Married vs. Cohabitation)
reg Satis married cohab A005 disios childs empee education_level is_urban
reg Worth married cohab A005 disios childs empee education_level is_urban
reg Happy married cohab A005 disios childs empee education_level is_urban
reg Anxious married cohab A005 disios childs empee education_level is_urban

// Socioeconomic Control Variables
reg Satis married cohab A005 disios childs empee education_level is_urban
reg Worth married cohab A005 disios childs empee education_level is_urban
reg Happy married cohab A005 disios childs empee education_level is_urban
reg Anxious married cohab A005 disios childs empee education_level is_urban 
