*Aaina Sharma   & Randall Chicola
*homework  3
use "C:\Users\Randall\Desktop\ECON 758\HW 3\Star13.dta" , clear

********************************************************************
*Recoding missing variables and creating additional variables
********************************************************************

********************************************************************
*a
********************************************************************
replace sex=. if sex==9
replace race=. if race==9
replace sesk=. if sesk==9
replace ses1=. if ses1==9 
replace ses2=. if ses2==9
replace ses3=. if ses3==9
replace yob=. if yob==9999
replace schidk=. if schidk==999
replace schid1=. if schid1==999
replace schid2=. if schid2==999
replace schid3=. if schid3==999

********************************************************************
*bi. create free lunch dummy
********************************************************************
gen freelunchk=0 if sesk==2
replace freelunchk=1 if sesk==1

gen freelunch1=0 if ses1==2
replace freelunch1=1 if ses1==1

gen freelunch2=0 if ses2==2
replace freelunch2=1 if ses2==1

gen freelunch3=0 if ses3==2 
replace freelunch3=1 if ses3==1

********************************************************************
*bii. attrition rate
********************************************************************
*use star variables. For attrition_i we want student who participates in in STAR in i, i+1, i+2 ...etc future periods to equal 1
*We replace =0 if the student left STAR in any future periods
gen attritionk=. 
replace attritionk=0 if stark==1 & star1==1 & star2==1 & star3==1
replace attritionk=1 if stark==1 & ( star1==2 | star2==2 | star3==2)


*If student joined in kindergarten, they don't meet the conditionality for "entering in 1st" 
gen attrition1 = . 
*If student did not join in kindergarten AND were participating in grades 1,2 &3 
replace attrition1 = 0 if stark==2 & star1==1 & star2==1 &  star3==1
*If student did not join in kinder, joined in 1st, but left after
replace attrition1 = 1 if stark==2 & star1==1 & (star2==2 | star3==2)

gen attrition2 = . 
*If student did not join in kindergarten or 1st AND were participating in grades 1,2 &3 
replace attrition2 = 0 if stark==2 & star1==2 & star2==1 &  star3==1
*If student did not join in kinder, joined in 1st, but left after
replace attrition2 = 1 if stark==2 & star1==2 & star2==1 & star3==2

********************************************************************
*biii. class type
********************************************************************
*kindergarten
gen smallk=0 if ctypek==2|ctypek==3
replace smallk=1 if ctypek==1

gen regulark=0 if ctypek==1|ctypek==3
replace regulark=1 if ctypek==2

gen regular_aidek=0 if ctypek==1|ctypek==2
replace regular_aidek=1 if ctypek==3

*1st grade
gen small1=0 if ctype1==2|ctype1==3
replace small1=1 if ctype1==1

gen regular1=0 if ctype1==1|ctype1==3
replace regular1=1 if ctype1==2

gen regular_aide1=0 if ctype1==1|ctype1==2
replace regular_aide1=1 if ctype1==3

*2nd grade
gen small2=0 if ctype2==2|ctype2==3
replace small2=1 if ctype2==1

gen regular2=0 if ctype2==1|ctype2==3
replace regular2=1 if ctype2==2

gen regular_aide2=0 if ctype2==1|ctype2==2
replace regular_aide2=1 if ctype2==3

*3rd grade 
gen small3=0 if ctype3==2|ctype3==3
replace small3=1 if ctype3==1

gen regular3=0 if ctype3==1|ctype3==3
replace regular3=1 if ctype3==2

gen regular_aide3=0 if ctype3==1|ctype3==2
replace regular_aide3=1 if ctype3==3

********************************************************************
*biv. enter STAR program
********************************************************************

*If they were in program in kinder, since it is earliest that can be entered.
*Necc/Suff condition is if they were in Star that earliest year that is possible.
gen enterk = .
replace enterk = 1 if stark==1 
replace enterk = 0 if stark==2

gen enter1=.
*Here to have entered in first grade, you must be have been in the star program in 1st, but also NOT have been in kinder 
replace enter1 = 1 if star1==1 & stark==2
*You can't have entered in prior years, in this case only kinder is prior to 1st
replace enter1 = 0 if stark==1 
*Need to exclude those who haven't joined at all.
*replace enter1 = 0 if (stark==2 & star1==2) & (star2==1 | star3==1)

gen enter2=.
*To have entered 2nd grade you must not have been in kinder or 1st and have been in the star program in 2nd
replace enter2 = 1 if star2==1 & stark==2 & star1==2
*You can't have entered in second if you entered previously in star in kinder or 1st 
replace enter2= 0 if stark==1 | star1==1
*Exclude those who don't join until 3rd. grade
*replace enter2= 0 if stark==2 & star1==2 & star2==2 & star3==1

gen enter3=.
*To have entered 3rd, you must not have participated in star in any prior years until particpating in 3rd.
replace enter3= 1 if stark==2 & star1==2 & star2==2 & star3==1
*Replace with zero if they entered in any prior year.
replace enter3= 0 if stark==1 | star1==1 | star2==1

********************************************************************
*bv. White Asian Dummy
********************************************************************
gen whiteasian=0 if race~=1 | race~=3  
replace whiteasian=1  if race==1 | race==3

*bvi. Create the Girl indicator variable
gen girl =0 if sex==1 
replace girl =1 if sex==2

*Part C
*Age as of Dec. 31 1985
gen age = 1985 - yob

********************************************************************
*Question 1: Summary Statistics
********************************************************************

********************************************************************
*Q1 Part A
********************************************************************
**By Intial Entrance Status
*Kindergarten
eststo enterksmall : estpost summarize freelunchk whiteasian age attritionk csizek girl  if smallk==1
eststo enterkregular : estpost summarize freelunchk whiteasian age attritionk csizek girl  if regulark==1
eststo enterkaide : estpost summarize freelunchk whiteasian age attritionk csizek girl  if regular_aidek==1
*First Grade
eststo enter1small : estpost summarize freelunch1 whiteasian age attrition1 csize1 girl if small1==1
eststo enter1regular : estpost summarize freelunch1 whiteasian age attrition1 csize1 girl if regular1==1
eststo enter1aide : estpost summarize freelunch1 whiteasian age attrition1 csize1 girl if regular_aide1==1
*Second Grade
eststo enter2small : estpost summarize freelunch2 whiteasian age attrition2 csize2 girl if small2==1
eststo enter2regular : estpost summarize freelunch2 whiteasian age attrition2 csize2 girl if regular2==1
eststo enter2aide : estpost summarize freelunch2 whiteasian age attrition2 csize2 girl if regular_aide2==1
*Third Grade  ***No attrition
eststo enter3small : estpost summarize freelunch3 whiteasian age  csize3 girl if small3==1
eststo enter3regular : estpost summarize freelunch3 whiteasian age  csize3 girl if regular3==1
eststo enter3aide : estpost summarize freelunch3 whiteasian age  csize3 girl if regular_aide3==1

*Create Table 1 Kindergarten
esttab enterksmall enterkregular enterkaide using Table1k.rtf, rtf cell(mean)  title("Summary Statistics") mtitle("Small" "Regular" "Regular/Aide") replace
*Create Table 1 First Grade
esttab enter1small enter1regular enter1aide using Table1first.rtf, rtf cell(mean)  title("Summary Statistics") mtitle("Small" "Regular" "Regular/Aide") replace
*Create Table 1 Second Grade
esttab enter2small enter2regular enter2aide using Table1second.rtf, rtf cell(mean)  title("Summary Statistics") mtitle("Small" "Regular" "Regular/Aide") replace
*Create Table 1 Third Grade
esttab enter3small enter3regular enter3aide using Table1third.rtf, rtf cell(mean)  title("Summary Statistics") mtitle("Small" "Regular" "Regular/Aide") replace

********************************************************************
*Q1 Part B
********************************************************************
*Percentile Ranks 

*Kindergarten Perc. Avg Rank
gen testk = ((mathk_p + readk_p)/2) if mathk_p ~=. | readk_p~=.
replace testk = mathk_p if readk_p==. 
replace testk = readk_p if mathk_p==.

*First Perc. Avg Rank
gen test1 = ((math1_p + read1_p)/2) if math1_p ~=. | read1_p~=.
replace test1 = math1_p if read1_p==. 
replace test1 = read1_p if math1_p==.

*Second Perc. Avg Rank
gen test2 = ((math2_p + read2_p)/2) if math2_p ~=. | read2_p~=.
replace test2 = math2_p if read2_p==. 
replace test2 = read2_p if math2_p==.

*Third Perc. Avg Rank
gen test3 = ((math3_p + read3_p)/2) if math3_p ~=. | read3_p~=.
replace test3 = math3_p if read3_p==. 
replace test3 = read3_p if math3_p==.


**By Initial Entrance Status
*Kindergarten
eststo enterksmall : estpost summarize freelunchk whiteasian age attritionk csizek girl testk if smallk==1
eststo enterkregular : estpost summarize freelunchk whiteasian age attritionk csizek girl testk if regulark==1
eststo enterkaide : estpost summarize freelunchk whiteasian age attritionk csizek girl testk if regular_aidek==1
*First Grade
eststo enter1small : estpost summarize freelunch1 whiteasian age attrition1 csize1 girl test1 if small1==1
eststo enter1regular : estpost summarize freelunch1 whiteasian age attrition1 csize1 girl test1 if regular1==1
eststo enter1aide : estpost summarize freelunch1 whiteasian age attrition1 csize1 girl test1 if regular_aide1==1
*Second Grade
eststo enter2small : estpost summarize freelunch2 whiteasian age attrition2 csize2 girl test2 if small2==1
eststo enter2regular : estpost summarize freelunch2 whiteasian age attrition2 csize2 girl test2 if regular2==1
eststo enter2aide : estpost summarize freelunch2 whiteasian age attrition2 csize2 girl test2 if regular_aide2==1
*Third Grade  ***No attrition
eststo enter3small : estpost summarize freelunch3 whiteasian age  csize3 girl test3 if small3==1
eststo enter3regular : estpost summarize freelunch3 whiteasian age  csize3 girl test3 if regular3==1
eststo enter3aide : estpost summarize freelunch3 whiteasian age  csize3 girl test3 if regular_aide3==1

*Create Table 1 Kindergarten
esttab enterksmall enterkregular enterkaide using Table1k.rtf, rtf cell(mean)  title("Summary Statistics") mtitle("Small" "Regular" "Regular/Aide") replace
*Create Table 1 First Grade
esttab enter1small enter1regular enter1aide using Table1first.rtf, rtf cell(mean)  title("Summary Statistics") mtitle("Small" "Regular" "Regular/Aide") replace
*Create Table 1 Second Grade
esttab enter2small enter2regular enter2aide using Table1second.rtf, rtf cell(mean)  title("Summary Statistics") mtitle("Small" "Regular" "Regular/Aide") replace
*Create Table 1 Third Grade
esttab enter3small enter3regular enter3aide using Table1third.rtf, rtf cell(mean)  title("Summary Statistics") mtitle("Small" "Regular" "Regular/Aide") replace

****************************************************************************************
*Question 2: Random Assignments
****************************************************************************************


*2a in word doc
****************************************************************************************
*2b   Between Treatment Groups 
****************************************************************************************
*Kindergarten
reg freelunchk smallk regulark
test smallk regulark
estadd scalar freelunchk_F = r(p)

reg whiteasian smallk regulark
test smallk regulark
estadd scalar whiteasiank_F = r(p)

reg age smallk regulark
test smallk regulark
estadd scalar agek_F = r(p)

reg attritionk smallk regulark
test smallk regulark
estadd scalar attritionk_F = r(p)

reg csizek smallk regulark
test smallk regulark
estadd scalar csizek_F = r(p)

reg girl smallk regulark
test smallk regulark
estadd scalar girlk_F = r(p)

reg testk smallk regulark
test smallk regulark
estadd scalar testk_F = r(p)

*First Grade
reg freelunch1 small1 regular1
test small1 regular1
estadd scalar freelunch1_F = r(p)

reg whiteasian small1 regular1
test small1 regular1
estadd scalar whiteasian1_F = r(p)

reg age small1 regular1
test small1 regular1
estadd scalar age1_F = r(p)

reg attrition1 small1 regular1
test small1 regular1
estadd scalar attritionk_F = r(p)

reg csize1 small1 regular1
test small1 regular1
estadd scalar csize1_F = r(p)

reg girl small1 regular1
test small1 regular1
estadd scalar girl1_F = r(p)

reg test1 small1 regular1
test small1 regular1
estadd scalar test1_F = r(p)

*Second Grade
reg freelunch2 small2 regular2
test small2 regular2
estadd scalar freelunch2_F = r(p)

reg whiteasian small2 regular2
test small2 regular2
estadd scalar whiteasian2_F = r(p)

reg age small2 regular2
test small2 regular2
estadd scalar age2_F = r(p)

reg attrition2 small2 regular2
test small2 regular2
estadd scalar attrition2_F = r(p)

reg csize2 small2 regular2
test small2 regular2
estadd scalar csize2_F = r(p)

reg girl small2 regular2
test small2 regular2
estadd scalar girl2_F = r(p)

reg test2 small2 regular2
test small2 regular2
estadd scalar test2_F = r(p)


*Third Grade
reg freelunch3 small3 regular3
test small3 regular3
estadd scalar freelunch3_F = r(p)

reg whiteasian small3 regular3
test small3 regular3
estadd scalar whiteasian3_F = r(p)

reg age small3 regular3
test small3 regular3
estadd scalar age3_F = r(p)

*reg attrition3 small3 regular3
*test small3 regular3
*estadd scalar attrition3_F = r(p)

reg csize3 small3 regular3
test small3 regular3
estadd scalar csize3_F = r(p)

reg girl small3 regular3
test small3 regular3
estadd scalar girl3_F = r(p)

reg test3 small3 regular3
test small3 regular3
estadd scalar test3_F = r(p)


****************************************************************************************
*2c  Within School Effects (same as 2b, but adds i.schidk   school IDs)
****************************************************************************************

*Kindergarten
reg freelunchk smallk regulark i.schidk
test smallk regulark
estadd scalar freelunchk_F = r(p)

reg whiteasian smallk regulark i.schidk
test smallk regulark
estadd scalar whiteasiank_F = r(p)

reg age smallk regulark i.schidk
test smallk regulark
estadd scalar agek_F = r(p)

reg attritionk smallk regulark i.schidk
test smallk regulark
estadd scalar attritionk_F = r(p)

reg csizek smallk regulark i.schidk
test smallk regulark
estadd scalar csizek_F = r(p)

reg girl smallk regulark i.schidk
test smallk regulark
estadd scalar girlk_F = r(p)

reg testk smallk regulark i.schidk
test smallk regulark
estadd scalar testk_F = r(p)


*First Grade
reg freelunch1 small1 regular1 i.schid1
test small1 regular1
estadd scalar freelunch1_F = r(p)

reg whiteasian small1 regular1 i.schid1
test small1 regular1
estadd scalar whiteasian1_F = r(p)

reg age small1 regular1 i.schid1
test small1 regular1
estadd scalar age1_F = r(p)

reg attrition1 small1 regular1 i.schid1
test small1 regular1
estadd scalar attritionk_F = r(p)

reg csize1 small1 regular1 i.schid1
test small1 regular1
estadd scalar csize1_F = r(p)

reg girl small1 regular1 i.schid1
test small1 regular1
estadd scalar girl1_F = r(p)

reg test1 small1 regular1 i.schid1
test small1 regular1
estadd scalar test1_F = r(p)

*Second Grade
reg freelunch2 small2 regular2 i.schid2
test small2 regular2
estadd scalar freelunch2_F = r(p)

reg whiteasian small2 regular2 i.schid2
test small2 regular2
estadd scalar whiteasian2_F = r(p)

reg age small2 regular2 i.schid2
test small2 regular2
estadd scalar age2_F = r(p)

reg attrition2 small2 regular2 i.schid2
test small2 regular2
estadd scalar attrition2_F = r(p)

reg csize2 small2 regular2 i.schid2
test small2 regular2
estadd scalar csize2_F = r(p)

reg girl small2 regular2 i.schid2
test small2 regular2
estadd scalar girl2_F = r(p)

reg test2 small2 regular2 i.schid2
test small2 regular2
estadd scalar test2_F = r(p)


*Third Grade
reg freelunch3 small3 regular3 i.schid3
test small3 regular3
estadd scalar freelunch3_F = r(p)

reg whiteasian small3 regular3 i.schid3
test small3 regular3
estadd scalar whiteasian3_F = r(p)

reg age small3 regular3 i.schid3
test small3 regular3
estadd scalar age3_F = r(p)

*reg attrition3 small3 regular3 i.schid3
*test small3 regular3
*estadd scalar attrition3_F = r(p)

reg csize3 small3 regular3 i.schid3
test small3 regular3
estadd scalar csize3_F = r(p)

reg girl small3 regular3 i.schid3
test small3 regular3
estadd scalar girl3_F = r(p)

reg test3 small3 regular3 i.schid3
test small3 regular3
estadd scalar test3_F = r(p)


********************************************************************************
*Question 3: OLS estimates  of class size effects
********************************************************************************
*Q3 Part A

*Kindergarten
*Col1
reg testk smallk regular_aidek
eststo OLS1_k
*Col2
reg testk smallk regular_aidek i.schidk
eststo OLS2_k
*Col3
reg testk smallk regular_aidek whiteasian girl freelunchk i.schidk
eststo OLS3_k

*First Grade 
*Col1
reg test1 small1 regular_aide1
eststo OLS1_1
*Col2
reg test1 small1 regular_aide1 i.schid1
eststo OLS2_1
*Col3
reg test1 small1 regular_aide1 whiteasian girl freelunch1 i.schid1
eststo OLS3_1

*Second Grade 
*Col1
reg test2 small2 regular_aide2
eststo OLS1_2
*Col2
reg test2 small2 regular_aide2 i.schid2
eststo OLS2_2
*Col3
reg test2 small2 regular_aide2 whiteasian girl freelunch2 i.schid2
eststo OLS3_2

*Second Grade 
*Col1
reg test3 small3 regular_aide3
eststo OLS1_3
*Col2
reg test3 small3 regular_aide3 i.schid3
eststo OLS2_3
*Col3
reg test3 small3 regular_aide3 whiteasian girl freelunch3 i.schid3
eststo OLS3_3

*Create Table 1 Kindergarten
esttab OLS1_k OLS2_k OLS3_k using Table2k.rtf, rtf  se title("OLS actual Class Size")  replace
*Create Table 1 First Grade
esttab OLS1_1 OLS2_1 OLS3_1 using Table2_1.rtf, rtf  se title("OLS actual Class Size")  replace
*Create Table 1 Second Grade
esttab OLS1_2 OLS2_2 OLS3_2 using Table2_2.rtf, rtf  se title("OLS actual Class Size")  replace
*Create Table 1 Third Grade
esttab OLS1_3 OLS2_3 OLS3_3 using Table2_3.rtf, rtf  se title("OLS actual Class Size")  replace


*Q 3 Parts B,C, & D in word doc

********************************************************************************
*Question 4: Instrumental variable regression
********************************************************************************

****************************************************************************************
*Q4 Part A
****************************************************************************************

*****Kinder to 1st
groups smallk  regulark regular_aidek small1 regular1 regular_aide1
*******1st to 2nd
groups small1  regular1 regular_aide1 small2 regular2 regular_aide2
*****2nd to 3rd
groups small2  regular2 regular_aide2 small3 regular3 regular_aide3


****************************************************************************************
*Q4 Part B  
****************************************************************************************
*Create Initial Assignment Dummy Variables

*Kinder Dummy Variants
gen kinder_small = .
replace kinder_small = 1 if enterk==1 & smallk==1
replace kinder_small = 0 if enterk==1 & smallk==0

gen kinder_reg = .
replace kinder_reg = 1 if enterk==1 & regulark==1
replace kinder_reg = 0 if enterk==1 & regulark==0

gen kinder_aide = .
replace kinder_aide = 1 if enterk==1 & regular_aidek==1
replace kinder_aide= 0 if enterk==1 & regular_aidek==0

*First Grade Dummy Variants
gen first_small = .
replace first_small = 1 if enter1==1 & small1==1
replace first_small = 0 if enter1==1 & small1==0

gen first_reg = .
replace first_reg = 1 if enter1==1 & regular1==1
replace first_reg = 0 if enter1==1 & regular1==0

gen first_aide = .
replace first_aide = 1 if enter1==1 & regular_aide1==1
replace first_aide= 0 if enter1==1 & regular_aide1==0

*Second Grade Dummy Variants
gen second_small = .
replace second_small = 1 if enter2==1 & small2==1
replace second_small = 0 if enter2==1 & small2==0

gen second_reg = .
replace second_reg = 1 if enter2==1 & regular2==1
replace second_reg = 0 if enter2==1 & regular2==0

gen second_aide = .
replace second_aide = 1 if enter2==1 & regular_aide2==1
replace second_aide= 0 if enter2==1 & regular_aide2==0

*Third Grade Dummy Variants
gen third_small = .
replace third_small = 1 if enter3==1 & small3==1
replace third_small = 0 if enter3==1 & small3==0

gen third_reg = .
replace third_reg = 1 if enter3==1 & regular3==1
replace third_reg = 0 if enter3==1 & regular3==0

gen third_aide = .
replace third_aide = 1 if enter3==1 & regular_aide3==1
replace third_aide= 0 if enter3==1 & regular_aide3==0

****************************************************************************************
*Question 4 Part C
****************************************************************************************
ivreg testk (smallk regular_aidek = kinder_small kinder_aide)














