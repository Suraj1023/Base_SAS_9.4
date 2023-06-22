proc format lib=trAIL;
	value $ Education 'SSC'=1 'HSC'=2 'Graduation'=3 'Postgraduation'=4 'Phd'=5;
run;

proc format lib=TrAIl fmtlib;
run;

*Displaying a List of Your Formats;

proc format lib=trAIl;
	value cgpa 0-<3.5='fail' 3.5-<7.5='B' 7.5-<8.5='A' 8.5-<10.0=other;
run;

proc format lib=TrAIl fmtlib;
run;


proc format ;
value $gender 
'M' = 'MALE'
'F' = 'FEMALE' ;
RUN;
proc print data= SASHELP.CLASS ;
var Sex Age Height Weight ;
format Sex $gender.;
run;

proc format ;
value cgpa
3 -<6 = 'A'
6 -<8 = 'B'
8-<10 = 'C';
value placement 
5-<10 ='Yes'
0-<5 = 'No';
run;
data TRAIL.student;
	input cgpa placement;
	format cgpa cgpa. ;
	datalines;
6.89 3.26
5.12 1.98
7.82 3.25
7.42 3.67
6.94 3.57
7.89 2.99	
6.73 2.6
6.75 2.48
6.09 2.31
8.31 3.51
5.32 1.86
6.61 2.6
8.94 3.65
6.93 2.89
7.73 3.42
;
run;
proc print data=TRAIL.STUDENT ;
format cgpa cgpa. placement placement.;
run;
proc format ;
value $bucket
'MILK' = 1111
'BREAD' =22222;
run;
data txt_file;
	infile "/home/u58028466/2023/MILK,BREAD,BISCUIT.txt" dlm=',';
	input A $ B $C $;
run;
proc print data=txt_file ;
	format A $bucket. B $bucket. C $bucket. ;
run;
