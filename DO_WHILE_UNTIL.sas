*do statement;
data stocks_changes;
set sashelp.stocks(drop= adjclose);
if open = close then 
do;
	status ='nochange';
	if high > low then fluctuation = 'high';
	else fluctuation = 'low';
end;
else status = 'change';
do;
	if high > low then fluctuation = 'high';
	else fluctuation = 'low';
end;
if open > close then benefit ='Profit';
else benefit = 'Loss';
run;
proc print data=stocks_changes;
var fluctuation status open close;
*where status ='nochange' ;
run;
proc contents data=stocks_changes;
run;
* Processing Iterative DO Loops ;
data iteration;
set STOCKS_CHANGES;
do i = 1 to _N_ ;
month = month(date);
day= day(date);
year = year(date);
grow_pre=((close - open)/open)*100;
where stock = 'Microsoft' OR stock = 'Intel';
*format grow_pre percent8. ;
end;
run;
proc print data=iteration;
var open close grow_pre Stock day month;
where grow_pre > 30 ;
run;
proc sql;
SELECT DISTINCT(YEAR(DATE)) from stocks_changes;
run;

* The DO UNTIL statement evaluates the condition at the bottom of the loop; 
* The DO WHILE statement evaluates the condition at the top of the loop;
data fgh ;
set stocks_changes;
i = 0;
do while (year(date) =2000);
year =year(date);
i+1;
output;
end;
run;
proc print data=fgh ;
var month year grow_pre ;
run;
proc print data=stocks_changes;
run;

data data_bin;
k = 0; 
do j = 1 to 5 by 0.5 while(k < 20);   
k = j**2;
output; 
end; 
run;






