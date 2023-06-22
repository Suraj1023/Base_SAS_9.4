* concatination ;
data _sets ;
set SASHELP.air SASHELP.airline ;
run;
options obs=5 ;
proc print data=_sets;
run;
options firstobs=283 obs=288;
proc print data=_sets ;
run;

data Animal;
input OBS Common $ Animal $;
length Animal $8 ;
datalines;
1 a Ant           
2 b Bird          
3 c Cat           
4 d Dog           
5 e Eagle          
6 f Frog  
;
run;
data Plant ;
input OBS Common $ Plant $;
datalines;
1 a Apple
2 b Banana
3 c Coconut
4 d Dewberry
5 e Eggplant
6 g Fig
;
run;

* Merge animal and plant dataset;
data merged_1_to_1 ;
MERGE Animal Plant ;
run;
proc print data= merged_1_to_1;
run;

data renameing;
set Animal (rename=(common=com));
run;


data in_ (keep=Age Height) ;
merge sashelp.CLass (in= Age) 
sashelp.classfit(in=Height);
if Age > 12 and Height >50 then output;
run;


data analysis;
merge patients (in=inpatients) allvoids (in=inallvoids);
if inpatients=1 and inallvoids=1 then output;
run;
proc print data=sashelp.classfit ;
run;
*  in operator is use to show the origen of merging ;
DATA CAFE(KEEP=NAME PLACE CNUM);
length NAME $10 Place $10;
   INPUT NAME $ ;
   PLACE = 'CAFE   ';
   DATALINES;
ANDERSON 
COOPER
DIXON 
FREDERIC
FREDERIC
PALMER
RANDALL
RANDALL
SMITH
SMITH 
SMITH
;
RUN;

DATA VENDING (KEEP=NAME PLACE VNUM);
length NAME $10 Place $10;
   INPUT NAME $ ;
   PLACE = 'VENDING ';
   DATALINES;
CARTER
DANIELS
GARY
GARY
HODGE
PALMER
RANDALL
RANDALL
SMITH
SMITH
SPENCER
SPENCER
SPENCER
SPENCER
;
RUN;

DATA SNACK (KEEP=NAME PLACE SNUM);
length NAME $10 Place $10;
   INPUT NAME $ ;
   PLACE = 'SNACK   ';
   DATALINES;
BARRETT
COOPER
DANIELS
DIXON
DIXON
FREDERIC
GARY
HODGE
HODGE
PALMER
RANDALL
RANDALL
SMITH
SMITH
SMITH
SMITH
SPENCER
SPENCER
;
RUN;

DATA ;
   MERGE CAFE(IN=A)  VENDING(IN=B) SNACK(in=C) ;
   BY NAME;
   CIN=A;VIN=B;SIN=C;
   if CIN=1 AND VIN=1 ;
RUN;

PROC PRINT;
     TITLE 'MERGED DATA';
RUN;

