*Aaina Sharma
*homework 2
use "C:\Users\Aaina\Documents\Grad School-Econ\4th Semester\Econ 758\HW3\Star13 (1).dta", clear

********************************************************************
*Recoding missing variables and creating additional variables
********************************************************************
*a
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

*bi. create free lunch dummy

gen freelunchk=0 if sesk==2
replace freelunchk=1 if sesk==1

gen freelunch1=0 if ses1==2
replace freelunch1=1 if ses1==1

gen freelunch2=0 if ses2==2
replace freelunch2=1 if ses2==1

gen freelunch3=0 if ses3==2 
replace freelunch3=1 if ses3==1

*bii. attrition rate
*gen attritionk = (csize1 -csizek)/csizek
*gen attrition1 = (csize2 -csize1)/csize1
*gen attrition2 = (csize3 -csize2)/csize2

*gen attritionk=0 if stark==1
*replace attritionk=1 if star1==2|star2==2|star3==2
*replace attritionk=. if star1==1 & star2==2
*replace attritionk=. if star1==1 & star3==2
*replace attritionk=. if star2==1 & star3==2
*replace attritionk=. if star2==1 & stark==2
*replace attritionk=. if star1==2 & star2==2 & star3==1

*gen attrition1=0 if stark==2&star1==1
*replace attrition1=1 if star2==2|star3==2
*replace attrition1=. if stark==1 & star2==2
*replace attrition1=. if stark==1 & star3==2
*replace attrition1=. if star2==1 & star3==2
*replace attrition1=. if stark==2 & star2==2 & star3==1

*gen attrition2=0 if stark==2&star1==2&star2==1
*replace attrition2=1 if star2==1 & star3==2
*replace attrition2=. if stark==1 & star3==2
*replace attrition2=. if star1==1 & star3==2
*replace attrition2=. if star2==1 & star3==2


gen attritionk=.
replace attritionk=0 if stark==1&star1==1&star2==1&star3==1
replace attritionk=1 if stark==1&(star1==2|star2==2|star3==2)

gen attrition1=.
replace attrition1=0 if stark==2&star1==1&star2==1&star3==1
replace attrition1=1 if stark==2 & star1==1 &(star2==2|star3==2)

gen attrition2=.
replace attrition2=0 if stark==2&star1==2&star2==1&star3==1
replace attrition2=1 if stark==2 & star1==2 & star2==1 & star3==2

*biii. class type
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

*biv. enter STAR program
*kindergarten
gen enterk=.
replace enterk=1 if stark==1
replace enterk=0 if stark==2

*1st grade
gen enter1=.
replace enter1=1 if stark==2&star1==1
replace enter1=0 if stark==1

*2nd grade
gen enter2=.
replace enter2=1 if stark==2&star1==2&star2==1
replace enter2=0 if stark==1|star1==1

*3rd grade
gen enter3=.
replace enter3=1 if stark==2&star1==2&star2==2&star3==1
replace enter3=0 if stark==1|star1==1|star2==1

*gen enterk=0 if stark==2|star1==1|star1==2|star2==1|star2==2|star3==1|star3==2
*replace enterk=1 if stark==1

*gen enter1=0 if stark==1|stark==2|star1==2|star2==1|star2==2|star3==1|star3==2
*replace enter1=1 if star1==1

*gen enter2=0 if stark==1|stark==2|star1==1|star1==2|star2==2|star3==1|star3==2
*replace enter2=1 if star2==1

*gen enter3=0 if stark==1|stark==2|star1==1|star1==2|star2==1|star2==2|star3==2
*replace enter3=1 if star3==1

*bv. White Asian Dummy

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

**********
*Part A
**********
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

**********
*Part B
**********

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

**By Intial Entrance Status
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

*b
*global kinder "freelunchk whiteasian age attritionk csizek girl testk"
*global first "freelunch1 whiteasian age attrititon1 csize1 girl test1"
*global second "freelunch2 whiteasian age attrititon2 csize1 girl test2"
*global third "freelunch3 whiteasian age csize3 girl test3"

*kindergarten

foreach y in freelunchk whiteasian age attritionk csizek girl testk {

reg `y' smallk regulark
test smallk regulark
estadd scalar `y'_p =r(p)
estadd scalar `y'_F=r(F)
}

*first 

foreach y in freelunch1 whiteasian age attrition1 csize1 girl test1 {
reg `y' small1 regular1
test small1 regular1
estadd scalar `y'_p =r(p)
estadd scalar `y'_F=r(F)
}

*second

foreach y in freelunch2 whiteasian age attrition2 csize2 girl test2 {

reg `y' small2 regular2
test small2 regular2
estadd scalar `y'_p =r(p)
estadd scalar `y'_F=r(F)
}

*third

foreach y in freelunch3 whiteasian age csize3 girl test3{
reg `y' small3 regular3
test small3 regular3
estadd scalar `y'_p =r(p)
estadd scalar `y'_F=r(F) 
}






*c. within school effects
*Kindergarten

foreach y in freelunchk whiteasian age attritionk csizek girl testk {

reg `y' smallk regulark i.schidk
test smallk regulark
estadd scalar `y'_p = r(p)
estadd scalar `y'_F = r(F)
}


*First

foreach y in freelunch1 whiteasian age attrition1 csize1 girl test1 {

reg `y' small1 regular1 i.schid1
test small1 regular1
estadd scalar `y'_p =r(p)
estadd scalar `y'_F=r(F)
}



*Second

foreach y in freelunch2 whiteasian age attrition2 csize2 girl test2 {

reg `y' small2 regular2 i.schid2
test small2 regular2
estadd scalar `y'_p =r(p)
estadd scalar `y'_F=r(F)
}



*Third

foreach y in freelunch3 whiteasian age csize3 girl test3 {
reg `y' small3 regular3 i.schid3
test small3 regular3
estadd scalar `y'_p =r(p)
estadd scalar `y'_F=r(F)
}
********************************************************************************
*Question 3: OLS estimates  of class size effects
********************************************************************************

*a Kindergarten
reg testk smallk regular_aidek
est store OLS1K

reg testk smallk regular_aidek i.schidk
est store OLS2K

reg testk smallk regular_aidek whiteasian girl freelunchk i.schidk
est store OLS3K

esttab OLS1K OLS2K OLS3K using Table2Kindergarten.rtf, rtf se star(* 0.10 ** 0.05 *** 0.01) title("OLS: Actual Class Size") scalars(N r2 F) replace


*a First Grade
reg test1 small1 regular_aide1
est store OLS1First

reg test1 small1 regular_aide1 i.schid1
est store OLS2First

reg test1 small1 regular_aide1 whiteasian girl freelunch1 i.schid1
est store OLS3First


esttab OLS1First OLS2First OLS3First using Table2First.rtf, rtf se star(* 0.10 ** 0.05 *** 0.01) title("OLS: Actual Class Size") scalars(N r2 F) replace


*a Second Grade

reg test2 small2 regular_aide2
est store OLS1Second

reg test2 small2 regular_aide2 i.schid2
est store OLS2Second

reg test2 small2 regular_aide2 whiteasian girl freelunch2 i.schid2
est store OLS3Second

esttab OLS1Second OLS2Second OLS3Second using Table2Second.rtf, rtf se star(* 0.10 ** 0.05 *** 0.01) title("OLS: Actual Class Size") scalars(N r2 F) replace

*a Third Grade

reg test3 small3 regular_aide3
est store OLS1Third

reg test3 small3 regular_aide3 i.schid3
est store OLS2Third

reg test3 small3 regular_aide3 whiteasian girl freelunch3 i.schid3
est store OLS3Third

esttab OLS1Third OLS2Third OLS3Third using Table2Third.rtf, rtf se star(* 0.10 ** 0.05 *** 0.01) title("OLS: Actual Class Size") scalars(N r2 F) replace

********************************************************************************
*Question 4: Instrumental variable regression
********************************************************************************

*a

groups smallk regulark regular_aidek small1 regular1 regular_aide1

groups small1 regular1 regular_aide1 small2 regular2 regular_aide2

groups small2 regular2 regular_aide2 small3 regular3 regular_aide3


*b
*kindergarten
gen kinder_small=.
replace kinder_small=1 if enterk==1 & smallk==1
replace kinder_small=0 if enterk==1 & (smallk==0|regulark==1|regular_aidek==1)

gen kinder_regular=.
replace kinder_regular=1 if enterk==1 &regulark==1
replace kinder_regular=0 if enterk==1 & (regulark==0|smallk==1|regular_aidek==1)

gen kinder_aide=.
replace kinder_aide=1 if enterk==1 & regular_aidek==1
replace kinder_aide=0 if enterk==1 & (regular_aidek==0|regulark==1|smallk==1)

*First Grade
gen first_small=.
replace first_small=1 if enter1==1 & small1==1
replace first_small=0 if enter1==1 & (small1==0|regular1==1|regular_aide1==1)

gen first_regular=.
replace first_regular=1 if enter1==1 & regular1==1
replace first_regular=0 if enter1==1 & (regular1==0|regular_aide1==1|small1==1)

gen first_aide=.
replace first_aide=1 if enter1==1 & regular_aide1==1
replace first_aide=0 if enter1==1 & (regular_aide1==0|regular1==1|small1==1)

*Second Grade
gen second_small=.
replace second_small=1 if enter2==1 & small2==1
replace second_small=0 if enter2==1 & (small2==0|regular2==1|regular_aide2==1)

gen second_regular=.
replace second_regular=1 if enter2==1 &regular2==1
replace second_regular=0 if enter2==1 & (regular2==0|regular_aide2==1|small2==1)

gen second_aide=.
replace second_aide=1 if enter2==1 & regular_aide2==1
replace second_aide=0 if enter2==1 & (regular_aide2==0|regular2==1|small2==1)

*Third Grade
gen third_small=.
replace third_small=1 if enter3==1 & small3==1
replace third_small=0 if enter3==1 & (small3==0|regular3==1|regular_aide3==1)

gen third_regular=.
replace third_regular=1 if enter3==1 &regular3==1
replace third_regular=0 if enter3==1 & (regular3==0|regular_aide3==1|small3==1)

gen third_aide=.
replace third_aide=1 if enter3==1 & regular_aide3==1
replace third_aide=0 if enter3==1 & (regular_aide3==0|small3==1|regular3==1)

*c
*Class size when transition from kindergarten to first grade
reg small1 kinder_small kinder_aide
test kinder_small kinder_aide

reg regular1 kinder_small kinder_aide
test kinder_small kinder_aide

reg regular_aide1 kinder_small kinder_aide
test kinder_small kinder_aide

*Actual class size for second grade
reg small2 kinder_small kinder_aide
test kinder_small kinder_aide

reg regular2 kinder_small kinder_aide
test kinder_small kinder_aide

reg regular_aide2 kinder_small kinder_aide
test kinder_small kinder_aide

reg small2 first_small first_aide
test first_small first_aide

reg regular2 first_small first_aide
test first_small first_aide

reg regular_aide2 first_small first_aide
test first_small first_aide

*Actual class size for third grade
reg small3 kinder_small kinder_aide
test kinder_small kinder_aide

reg regular3 kinder_small kinder_aide
test kinder_small kinder_aide

reg regular_aide3 kinder_small kinder_aide
test kinder_small kinder_aide

reg small3 first_small first_aide
test first_small first_aide

reg regular3 first_small first_aide
test first_small first_aide

reg regular_aide3 first_small first_aide
test first_small first_aide

reg small3 second_small second_aide
test second_small second_aide

reg regular3 second_small second_aide
test second_small second_aide

reg regular_aide3 second_small second_aide
test second_small second_aide

*e
*Kindergarten
ivreg testk (smallk regular_aidek=kinder_small kinder_aide)
eststo kinder_IV

ivreg test1 (small1 regular_aide1=kinder_small kinder_aide first_small first_aide)
eststo first_IV

ivreg test2 (small2 regular_aide2=second_small second_aide)
eststo second_IV

ivreg test3 (small3 regular_aide3=third_small third_aide)
eststo third_IV

esttab kinder_IV first_IV second_IV third_IV using Table4.rtf, rtf se star(* 0.10 ** 0.05 *** 0.01) title("IV: Initial Class Size") scalars(N r2 F) replace