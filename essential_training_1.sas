*L1 task1 ;
* load the shoses data create netsales (sale - return);
* print mean & sum accroding to region;
data sales ;
set sashelp.shoes;
net_sales = sales-returns ;
run;
proc means data=sales mean sum maxdec=1 ;
var net_sales;
class region;
run;
/* Report created for budget 
 presentation; revised October 15. */
%let path= '/home/u58028466/Essential_training';
libname dfg &path;
libname dfg clear ;
options validvarname= V7;
libname NP  xlsx '/home/u58028466/Essential_training/DATA/np_info.xlsx';

proc contents data=NP.parks ;
run;
options validvarname= V7;
proc print data=np.parks;
run;
libname NP clear;

* impot tab file;
proc import datafile='/home/u58028466/Essential_training/DATA/storm_damage.tab'
dbms=tab out= strom_summary replace;
run;
proc print data=strom_summary;
run;
proc import datafile='/home/u58028466/Essential_training/DATA/eu_sport_trade.xlsx'
dbms=xlsx out=eu_spot replace ;
run;
proc contents data= eu_spot ;
run;

proc import datafile='/home/u58028466/Essential_training/DATA/np_traffic.csv'
dbms=csv out=np_traffic replace ;
guessingrows=max; 
run;
proc contents data=np_traffic ;run;

proc print data=np_traffic (obs=37 firstobs=30);
run;
proc import datafile='/home/u58028466/Essential_training/DATA/np_traffic.dat'
dbms=dlm
out=np replace ;
delimiter='|';
guessingrows=max ;
run;

*np_summary ;
libname essent '/home/u58028466/Essential_training/DATA';
proc print data=essent.np_summary ;
var Reg Type ParkName DayVisits TentCampers RVCampers ;
run;
proc means data=essent.np_summary ;
var DayVisits TentCampers RVCampers ;
run;
proc univariate data=essent.np_summary ;
var DayVisits TentCampers RVCampers ;
run;
proc freq data=essent.np_Summary;
tables Reg Type ;
run;
proc univariate data=essent.np_summary ;
var Acres ;
run ;
proc print data=essent.np_summary (obs=6 firstobs= 6) ;
var parkname;
proc print data=essent.np_summary (obs=78 firstobs= 78) ;
var parkname;
run;
ods select extremeobs;
proc univariate data=Essent.eu_occ nextrobs=20;
var camp ;
run;

ods trace on ;
proc univariate data=essent.eu_occ;
    var camp;
run;
ods trace off;


* WHERE ;
%LET Basincode = 'SP' ;
proc means data=essent.storm_summary ;
var MaxWindMPH MinPressure;
where Basin =&Basincode;
run;

proc freq data=essent.storm_summary ;
tables type ;
WHere basin = &Basincode ;
run;
proc print data=essent.np_summary ;
var type parkname ;
where Parkname LIKE '%Preserve%'; 
run;

proc print data=essent.eu_occ ;
where missing(Hotel) & missing(ShortStay) & missing(Camp) ;
run;

options obs=5 ;
proc freq data=essent.storm_summary ;
tables startdate ;
format startdate MONname12. ;
run;
proc freq data=essent.storm_summary ;
tables startdate ;
format startdate ddmmmyy. ;
run;

proc sort data=essent.storm_summary out=stom_sort ;
by descending MaxWindMPH ;
where Basin in ('NA' 'na');
run;
proc print data=stom_sort ;
var Basin  MaxWindMPH ;
run;

proc sort data=essent.np_largeparks out=data 
nodupkey dupout=dup ;
by _ALL_ ;
run;

proc sort data=essent.eu_occ out=eu(keep= geo country) 
nodupkey dupout=dup(keep= geo country) ;
by geo country ;
run;

* L4 ;
data strom_cat5 ;
set essent.storm_summary ;
where  (MaxWindMPH ge 156) AND (StartDate ge '01JAN2000'd) ;
keep Season Basin Name Type  MaxWindMPH ;
run;

data eu_occ_2016 ;
set essent.eu_occ ;
where yearmon LIKE '2016%' ;
format Hotel ShortStay Camp comma17. ;
drop Geo;
run;

data fox;
set essent.np_species ;
where (Category ='Mammal') and 
(LOWCASE(Common_Names) LIKE '%fox%'and LOWCASE(Common_Names) not LIKE '%squirrel%' ) ;
drop Category Record_Status Occurrence Nativeness ;
run;
proc sort data=fox out=sort ;
by Common_Names ; 
run;

data mammal ;
set essent.np_species;
Where lowcase(Category)  = 'mammal' ;
DROP Abundance Seasonality Conservation_Status;
run;

proc freq data= mammal ;
tables Record_Status ;
run;
%let cate = bird;
data &cate ;
set essent.np_species;
Where lowcase(Category)  = "&cate" ;
DROP Abundance Seasonality Conservation_Status;
run;

proc freq data= &cate;
tables Record_Status ;
run;

data strom ;
set essent.storm_summary ;
drop Hem_EW Hem_NS Lat Lon;
Strom_length = -(StartDate -EndDate)+1 ;
run;

proc print data=strom;
where season =1980 And Name = 'AGATHA';
run;

data strom ;
set essent.storm_range ;
avd_wind = mean(of Wind1-Wind4);
wind_range =range(of Wind1-Wind4);
run;
proc print data=strom (obs=1);
var avd_wind wind_range ;
run;

data df;
string = "This is a sentence";
Letter= upcase(substr(scan(string,4," "),4,1));
run;

data P ;
set essent.storm_summary ;
WHERE Basin LIKE '_P';
run;
data P(keep=basin);
set essent.storm_summary ;
where SUBSTR(BASIN,2,1) =  "P";
run;


data camp ;
set essent.np_summary ;
sqmiles =Acres * 0.0015625;
camer = sum(OtherCamping, TentCampers, RVCampers,BackcountryCampers );
format sqmiles camer comma6.;
keep sqmiles camer parkname;
run;
proc print data=camp ;
where propcase(parkname) ='Cape Krusenstern National Monument';;
run;

data scan_ ;
set essent.np_summary ;
Park_type = scan(Parkname,-1,' ');
keep Reg Type Parkname Park_type ;
run;
proc print data=scan_ (obs=4 firstobs=4);
var Park_type ;
run;

data date ;
set essent.eu_occ ;
year = substr(YearMon,1,4);
Month = substr(YearMon,6,2);
ReportDay = MDY(Month,1,year);
total = sum(Hotel,ShortStay,Camp);
country = upcase(substr(country,1,3));
format hotel shortstay camp total comma18. ReportDay monyy7.;
keep Country Hotel shortstay camp ReportDay total ;
run;
proc print data=date(obs=5) ;
run;

data filter(keep= Minpressure pressure_group) ;
set essent.storm_summary ;
if not missing(Minpressure) AND Minpressure le 920 then pressure_group = 1 ;
else if Minpressure gt 920 then pressure_group = 0;
run;
proc freq data=filter ;
tables pressure_group ;
run;

data char ;
set essent.storm_summary ;
keep Basin Season Name MaxWindMPH Ocean;
Basin  = Upcase(Basin) ;
ocean_code = substr(Basin, 2,1);
length ocean $ 9. ;
if ocean_code = 'I' then Ocean ='India';
else if ocean_code = 'A' then Ocean = "Atlantic";
else Ocean = "Pacific" ;
run;
proc print data=char(obs=5) ;
run;
proc freq data=char  ;
tables Ocean*Basin  ;
run;

data condition ;
set essent.np_summary ;
if type = 'NM' then Park_type= 'Monument';
else if type = 'NP' then Park_type = 'Park';
else if type in('NPRE', 'PRE', 'PRESERVE') then Park_type ='Preserve';
else if type = 'NS' then park_type = 'Seashore';
else if type in('RVR'  'RIVERWAYS') then Park_type = ' 	River';
run;

proc freq data=condition ;
tables park_type type ;
run;

data parks momentum ;
set essent.np_summary ;
format camper comma17.  ;
length park_type $ 9. ;
keep Reg ParkName DayVisits OtherLodging Camper Park_Type;
camper = sum(BackcountryCampers,OtherCamping,RVCampers,TentCampers); 
if type = 'NP' then DO ;
park_type = 'park' ;
output parks ;
end;
if type = 'NM' then DO ;
Park_type = 'Moment';
output momentum ;
end;
run;

data parks momentum ;
set essent.np_summary ;
format camper comma17.  ;
length park_type $ 9. ;
keep Reg ParkName DayVisits OtherLodging Camper Park_Type;
camper = sum(BackcountryCampers,OtherCamping,RVCampers,TentCampers); 
where type in("NP","NM");
select (type);
	When ("NP") DO ;
	park_type = "Park";
	output parks;end;
	otherwise DO ;
	park_type = 'Moment';
	output momentum;
	end;
end ;
run;
data mo ;
months = month();
run ;
title1 "Storm Analysis";
title2 'Summary Statistics for MaxWind and MinPressure';
proc means data=essent.storm_final;
	var MaxWindMPH MinPressure;
run;title2;
title3 'Frequency Report for Basin';
proc freq data=essent.storm_final;
	tables BasinName;
run;title3;

data cars_update;
    set sashelp.cars;
	keep Make Model MSRP Invoice AvgMPG;
	AvgMPG=mean(MPG_Highway, MPG_City);
	label MSRP="Manufacturer Suggested Retail Price"
          AvgMPG="Average Miles per Gallon"
          invoice ="Invoice price" ;
run;

proc means data=cars_update min mean max;
    var MSRP Invoice AVgMPG  ;
run;

proc print data=cars_update label;
    var Make Model MSRP Invoice AvgMPG;
run;
ods graphics on;
title 'Frequency plot ';
proc freq data=essent.storm_final nlevels order=freq ;
tables StartDate / nocum plots=freqplot;
format startDate monname. ;
run;
ods graphics ;

proc freq data=essent.np_species order= freq;
tables Category / nocum;
run;
ods graphics on;
proc freq data=essent.np_species order=freq;
where (Species_ID Like 'EVER%' )AND (Category ^= 'Vascular Plant');
tables Category / nocum plots=freqplot ;
run;

proc freq data=essent.np_codelookup order=freq nlevels;
tables Type*Region/ norow nocol;
where Propcase(type) ^= '%Other%' ; 
run;
proc freq data=essent.np_codelookup order=freq nlevels;
tables Type*Region/  nocol crosslist
plots=freqplot(groupby=row orient=horizontal scale= percent);
where Type in ('National Historic Site', 'National Monument', 'National Park');
run;

proc sql ;
select distinct(Species_ID) from essent.np_species ;
run;



title1 'Counts of Selected Park Types by Park Region';
proc sgplot data=essent.np_codelookup;
    where Type in ('National Historic Site', 'National Monument', 'National Park');
    hbar region / group=type;
    keylegend / opaque across=1 position=bottomright location=inside;
    xaxis grid;
run;

proc sgplot data=essent.np_codelookup ;
where Type in ('National Historic Site', 'National Monument', 'National Park');
hbar region / group =type;
keylegend /across=1 position = Bottomright location = inside ;
xaxis grid ;
yaxis grid ;
run;


proc means data=essent.storm_final mean median max;
	var MaxWindMPH;
	class BasinName;
	*ways 1;
	output out=wind_stats;
run;
proc print data=wind_stats(obs=5) ;
run;
proc means data=essent.storm_final mean median max;
	var MaxWindMPH;
	class BasinName;
	ways 1;
	output out=wind_stats ;
run;
proc print data=wind_stats(obs=5) ;
run;
proc means data=essent.storm_final mean median max;
	var MaxWindMPH;
	class BasinName;
	ways 1;
	output out=wind_stats mean=AvgWind max=MaxWind;
run;
proc print data=wind_stats(obs=5) ;
run;

proc print data=wind_stats;
 run;

proc means data=essent.np_westweather mean min max Maxdec=2 ;
var Precip Snow TempMin TempMax ;
class Year Name ;
run ;

proc means data=essent.np_westweather noprint;
where Precip ^= 0 ;
class YEAR NAME ;
output out=rainstats N=RainDays sum=TotalRain ;
ways 2 ;
run;
proc print data=rainstats NOOBS ;
var year name RainDays TotalRain ;

run;
libname xlout xlsx "&out_file/xlsxout.xlsx";
PROC MEANS DATA=ESSENT.NP_MULTIYR NOPRINT;
VAR VISITORS ;
CLASS REGION YEAR ;
WAYS 2 ;
OUTPUT OUT= xlout.TOP3(DROP= _FREQ_ _TYPE_)
SUM= TOTALVISITORS 
IDGROUP (MAX(VISITORS)OUT[4](VISITORS PARKNAME)= ) ;
RUN;
libname xlout clear ;

PROC PRINT DATA=TOP3;
RUN;

%LET out_file = /home/u58028466/Essential_training/output_file ;
proc export data=essent.storm_final outfile="&out_file/strom.csv" 
dbms=csv replace ;
run;


ods excel file= "&out_file/strom_final.xlsx"  options(sheet_name = 'strom summary') ; 
ods noproctitle ;
proc means data=essent.storm_final mean max median maxdec=1 ;
class Basinname ;
var MinPressure ;
run;
ods excel options(sheet_name =' scatter-plot');
proc sgscatter data=essent.storm_summary ;
plot minpressure*maxwindmph;
run;
ods excel close;
ods proctitle ;

proc template ;
list styles ;
run;

ods pdf file= "&out_file/strom_pdf.pdf"  style=Journal startpage=no pdftoc=1; 
ods proclabel 'strom mean';
proc means data=essent.storm_final mean max median maxdec=1 ;
class Basinname ;
var MinPressure ;
run;
ods proclabel 'strom distribution';
title1 'minpressure*maxwindmph';
proc sgscatter data=essent.storm_summary ;
plot minpressure*maxwindmph;
run;
ods pdf close;


ods powerpoint file= "&out_file/strom_powerpoint.pptx"  style=BarrettsBlue; 
ods noproctitle ;
proc means data=essent.storm_final mean max median maxdec=1 ;
class Basinname ;
var MinPressure ;
run;

proc sgscatter data=essent.storm_summary ;
plot minpressure*maxwindmph;
run;
ods powerpoint close;
ods proctitle ;

ods excel file="&out_file/class.xlsx";
   proc print data=sashelp.class ;
   run;
   ods excel close;

libname mylib xlsx "&out_file/class_.xlsx";
   data mylib.class_list;
       set sashelp.class;
   run; 

proc print data=essent.storm_damage (obs=5) ;
run;

proc sql;
SELECT event,COST format= comma18. ,YEAR(Date) AS Season FROM essent.storm_damage 
where cost > 25000000000
order by cost desc ;
run;

proc print data=essent.storm_summary (obs=5);
proc print data=essent.storm_basincodes (obs=5);
run;


proc sql ;
create table strom  as
select Season , name ,A.Basin ,basinname,MinPressure,MaxWindMPH from essent.storm_summary AS B inner join  
essent.storm_basincodes as A
on A.Basin = B.Basin 
order by Season desc, Name;
run;

 





