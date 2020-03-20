*Aaina Sharma
*homework 2
use "\\files\users\aainas\Desktop\Econ 758\HW 3\Star13.dta" , clear

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
gen attritionk = (csize1 -csizek)/csizek
gen attrition1 = (csize2 -csize1)/csize1
gen attrition2 = (csize3 -csize2)/csize2


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

gen enterk=0 if stark==2|star1==1|star1==2|star2==1|star2==2|star3==1|star3==2
replace enterk=1 if stark==1

gen enter1=0 if stark==1|stark==2|star1==2|star2==1|star2==2|star3==1|star3==2
replace enter1=1 if star1==1

gen enter2=0 if stark==1|stark==2|star1==1|star1==2|star2==2|star3==1|star3==2
replace enter2=1 if star2==1

gen enter3=0 if stark==1|stark==2|star1==1|star1==2|star2==1|star2==2|star3==2
replace enter3=1 if star3==1

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







