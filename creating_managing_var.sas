data sale_profit ;
Set SASHELP.Shoes (Keep= Region product  inventory Sales returns);
profit =inventory - (sales - returns);
total_sales = sales - returns ;
format profit dollar10. total_sales dollar10. ;
length Status $6;
if profit < 0 then Status ='Loss';
else status = 'Profit';
run;

* Print data according to Product type and give total sales;
proc sort data=sale_profit out=products;
by  Product ;
run;
proc print data=product noobs;
id Product;
var Status ;
sum inventory total_sales profit;
by product ;
run;
proc means data=product min max;
var  inventory total_sales;
by product ;
run;

* proc transpose ;
proc sort data= Sashelp.CLASS out=transpose ;
by Age ;
run;
proc transpose data= transpose out=trans prefix=student ;
var Sex Height Weight ;
by Age;
run;
proc print data=trans noobs;
id Age ;
by Age;
run;

* use macro variable ;
%Let height = 60;
%Let weight =100 ;
%Let Sex = 'M';
title1 'proc print statement' ;
proc print data=SAShelp.CLASS;
where height > &height AND weight > &weight
 AND Sex =&sex;
run;
title1;
title2 'roc report statement';
PROC REPORT DATA=SASHELP.CLASS;
WHERE SEX=&SEX;
RUN;
title2;

* RETAIN & delete statement;
data retain_delete (drop=name height weight age);
set sashelp.class;
if SEX =&sex then Delete ;
length condition $6 ;
if height < &height and weight<&weight 
then condition = 'weak';
else condition = 'strong';
retain height_  50;
cum_height= height_ + height;
run;
proc print data=retain_delete;
run;
proc freq data=retain_delete;
table condition;
run;





 