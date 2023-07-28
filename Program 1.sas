libname df '/home/u63489749/new_lib' ;
data class(drop=sex) ;
set SASHELP.class ;
where SEX  ="M" ;
run;
title1 "jhgjf";
proc print data=SASHELP.class(keep= age sex) ;
run;title1;
title2 "jhgugjf";
proc print data=SASHELP.class ;
run;title2 ;
title3 " lkhikfv" ;
proc print data=class ;
run;title3;

data select ;
set SASHELP.CLASS(keep=name age sex rename =
(name=student_name age= student_age)) ;
label sex='gender of the students',
student_age = 'age of the students' ;
where student_age > 12 ;
run;
options firstobs=5 obs=8;
proc print data=select label ;
run;
* -----------------------------------------------------------------;
data uf_data;
	format form_date DATE9. ;
	input form_date;
	datalines;
0
1
-365
365
;
run;
data informat_;
informat a ddmmyy10. b mmddyy10. c ddmmyy10. d ddmmyy10. e date9. f ddmmyy8. ;
input a b c d e f;
datalines;
28/07/2023 12-23-2003 23.12.2003 23:12:2003 22DEC2003 22122003
;
proc print data=informat_ ;
format a b c d e f DATE9. ;
run;

data gj ;
set informat_(keep=a b c d) ;
format a b c d e f DATE9. ;
run;
proc print data=gj(keep=a b) ;
run;

*-----------------------------------;
proc format lib= df;
* char to num ;
	value $ Education 
	'SSC'=1 'HSC'=2 
	'Graduation'=3 
	'Postgraduation'=4 
	'Phd'=5;
* number to char ;
	value cgpa 
	0-<3.5='fail' 
	3.5-<7.5='B' 
	7.5-<8.5='A'
	8.5-<10.0=other;
run;
proc format lib=df fmtlib ;
run;

data wrqw ;
infile "/home/u63489749/unit_1/txt_file.txt" dlm=',';
input a b $ c $ d ;
run;



proc import datafile='/home/u63489749/unit_1/txt_file.txt'
dbms=dlm out= fg replace ;
run;








