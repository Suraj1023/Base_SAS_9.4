* Importing an Excel File with an XLSX Extension ;
proc import DATAFILE='/home/u58028466/2023/PowerBIData.xlsx' 
out = actual
DBMS=XLSX
replace;
SHEET = Actual;
run;
proc contents data=actual varnum ;
run;
proc print data= actual;
run;

* Importing a Comma-Delimited File with a CSV Extension;
proc import datafile='/home/u58028466/2023/movie_metadata.csv'
out= movie
DBMS=csv
replace;
GETNAMES=NO;
RUN;
proc print data=movie;
run;

* Importing a Tab-Delimited File ;
proc import datafile='/home/u58028466/2023/student.txt'
out=student
DBMS=tab
replace;
delimiter='09'x;
run;
proc print data=student ;
run;

* Importing a Comma-Delimited File with a TXT Extension;

proc import datafile='/home/u58028466/2023/MILK,BREAD,BISCUIT.txt'
out=basket
replace;
getnames=NO;
delimiter=',';
run;
options obs=3;
proc print data=basket ;
run;

* Using the SET Statement to Specify Imported Data ;
proc import datafile='/home/u58028466/2023/student.txt'
out=student
DBMS=tab
replace;
run;
proc print data=student ;
run;
data top_student ;
set student ;
where cgpa >8 AND package >4 ;
run;
proc print data=top_student ;
title1 "top_student's recive high package";
run;
title1;
* Specifying DROP= and KEEP= Data Set Options;
data class(KEEP=Sex height) ;
set sashelp.class(DROP= name age);
where Sex = 'M' AND height>60;
run;
proc print data=class ;
run;
* Secifying DROP= and KEEP= Data proc Options;
proc print data=SASHELP.CLASS(DROP=name age);
var sex height ;
where Sex='M' AND height >60;
run;

* Reading Microsoft Excel Data with the XLSX Engine;
libname YUI XLSX '/home/u58028466/2023/XLSX_FILE.XLSX';
data YUI.class;
SET SASHELP.CLASS;
RUN;
PROC CONTENTS DATA=YUI._ALL_   varnum;
RUN;

* DATA statement contains two data set names;
data A B;
set sashelp.class(keep= Sex name);
output A ;
run;
proc print data=A;
run;
proc print data=B;
run;
* to read Single Observation;
data single_obs;
set sashelp.class(keep= Sex name);
if _n_ = 5 then
output single_obs;
run;
proc print data=single_obs;
run;


