*Creating basic reports ;
PROC PRINT DATA=SASHELP.GAS NOOBS ;
id Fuel;
var EqRatio CpRatio;
where (CpRatio = 15 AND EqRatio ge 1) AND 
Fuel contains 'Ethanol';
RUN;

* Sorting Data ;
proc sort data=SASHELP.baseball out= top_players;
by nHome descending nOuts;
run;
proc print data=top_players noobs;
ID Position;
var Name nHome nOuts Salary ;
where (nHome > 30 AND nOuts <100 );
run;

* Generating Column Totals ;
proc sort data=SASHELP.RETAIL out= total_sale ;
by month ;
run;
proc print data= total_sale noobs ;
id month ;
var SALES YEAR;
sum SALES ;
by Month ;
pageby month;
run;

* Assigning Descriptive Labels temporarily;
title1 'temporary label in proc statement';
proc print data= SASHELP.CLASS label;
var name Sex height weight;
label 
name = 'name_of_student'
Weight= "height_in_cm's"
Height ="weight_in_kg";
run;
title1;
* Assigning Descriptive Labels permanently;
data student_info;
set SASHELP.CLASS;
label 
name = 'name_of_student'
Weight= "height_in_cm's"
Height ="weight_in_kg";
run;
proc print data=student_info label;
run;


