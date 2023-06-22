* QUE 1;
proc sort data=SASHELP.shoes 
out=soterdshoes;
by  descending product sales ;
run;
options firstobs= 130 obs=130;
proc print data=soterdshoes(keep=product Region);
options firstobs= 148 obs=148;
proc print data=soterdshoes(keep=product Region);
run;
* Q 2;
data shoerange(keep=SalesRange sales);
set SASHELP.shoes;
length SalesRange $6.;
if Sales < 100000 then SalesRange = 'Lower';
else if 100000 <= Sales <= 200000 then SalesRange ='Middle';
else SalesRange = 'Upper';
run;
proc print data=shoerange;
run;
proc freq data=shoerange;
table SalesRange;
run;
proc means data=shoerange mean ;
var Sales;
where SalesRange ='Middle' ;
run;
* Q 3;
data work.lowchol work.highchol work.misschol;
set sashelp.heart;
if cholesterol < 200 AND not MISSING(cholesterol) THEN output work.lowchol;
if cholesterol > 200 THEN output work.highchol ;
if MISSING(cholesterol) THEN  output work.misschol;
run;
*Q5;
proc Contents data=work.highchol;
run;
*Q6;
proc contents  data=work.lowchol;
run;



