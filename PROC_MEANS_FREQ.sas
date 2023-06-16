* proc MEANS ;
data fish;
set sashelp.fish;
run;
proc print data=fish noobs;
run;
proc means data=fish min mean median max STD STDERR
 SKEW KURT  LCLM UCLM maxdec=2 ;
var Height Weight ;
class Species;
run;

proc means data=fish NOPRINT ;
var Height Weight ;
class Species;
output out=fish_discriptive
mean = Avg_height Avg_Weight
min = min_Height min_Weight
std = std_Height std_Weight
Q1 = first_qr_height first_qr_weight
median= second_qr_height second_qr_weight
Q3 = thrid_qr_height thrid_qr_weight
;
run;
proc print data=fish_discriptive noobs;
ID Species ;
var Avg_height min_height std_height 
first_qr_height second_qr_height thrid_qr_height
;
run;

* PROC FREQ ;
data freq ;
set sashelp.Heart;
run;
proc freq data=freq ;
table Sex Status;
run;
* cross tab ;
proc freq data=freq  ;
tables Sex*Status / CUMCOL list;
run;

