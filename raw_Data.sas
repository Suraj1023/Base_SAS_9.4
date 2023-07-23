/*
 1----Instream Data --------------
Instream data is a method of entering data into SAS by typing it directly 
into the SAS program instead of reading it from an external file.
it s a convenient and efficient way to enter small amounts of data into SAS for analysis.
*/;
data salary;
input lname $ id sex $ salary age;
cards;
Smith      1028 M     .       .
Williams   1337 F    3500    49
Brun       1829 .   14800    56
Agassi     1553 F   11800    65
Vernon     1626 M  129000    60
  ;
proc print data=salary;
run;
/* 
2---Entering data for more than one case on the same line----------
@@ symbol tells SAS to hold the current input line and read the next input line as well

*/
data test;
   input x y group $ @@;
   datalines;
1  2 A   3 12 A   15 22 B   17 29 B   11 44 C   13 29 C	  
7 21 D  11 29 D   16 19 E   25 27 E   41 12 F   17 19 F
;
proc print data=test;
run;
/*  
-----Reading data from external files-----
infile "" dlm= dsd missover  for tab('09'X)
*/
data class;
infile datalines missover ;
input lname :$12. sex $ age height sbp;      
datalines;
Warren F 29 68 139
Kalbfleisch F 35 64 120
Pierce M . . 112
Walker F 22 56 133
Rogers M 45 68 145
Baldwin M 47 72 128
Mims F 48 67 152
Lambini F 36 . 120
Gossert M . 73 139
;
run;
*------------------------------------------------------------------------------------;
/* 
@ : 
+n <+1>: move the pointer one column to the right
/ move the pointer to the next line
*/ 
data scores; * formated input ;
   input name $12. +4 score1 comma5. +6 score2 comma5.;
   datalines;
Riley           1,132      1,187
Henderson       1,015      1,102
;
data e1 ;
input fname @1 $ lname @7 $ age sex $ income eduaction $ @@ ;
datalines ;
Joe   Smith      20 M  35000  BS Jane  Doe        24 F  50000  MS Matt  Brown      30 M  65500  HS Mike  Johnson    55 M  85000  PhD 

;run;

data new; 
infile datalines;    
input fname :$ 1-6   lname $10. /         
age $ 1-3 sex $ +1 income : 15.  education $5.;    
datalines; 
Joe   Smith      
20 M  35000  	BS 
Jane  Doe        
24 F  50000  	MS 
Matt  Brown      
30 M  65500  	HS 
Mike Johnson
55 M  85000 	PhD
;
proc contents data=new ;
run;

DATA temp1;
  input subj 1-4 gender 6 height 8-9 weight 11-13;
  DATALINES;
1024 1 65 125
1167 1 68 140
1168 2 68 190
1201 2 72 190
1302 1 63 115
  ;
RUN;

DATA temp1; 
  input subj  gender  height weight ;
  DATALINES;
1024 1 65 125
1167 1 68 140
1168 2 68 190
1201 2 72 190
1302 1 63 115
  ;
RUN;

DATA temp;
  input subj 1-4 name $ 6-23  gender 25  height 27-28 weight 30-32 ;
  CARDS;
1024 Alice Smith        1 65 125
1167 Maryann White      1 68 140
1168 Thomas Jones       2 68 190
1201 Benedictine Arnold 2 68 190
1302 Felicia Ho         1 63 115
  ;
RUN;
/* 
& allows the user to read character values that contain embedded blanks with list input
:  allows the user to use list input but also to specify an informat after a variable 
name, whether character or numeric
~ -  which enables the user to read and retain single quotation marks, 
double quotation marks, and delimiters within character values
This can be useful when reading in data that contains special characters 
*/

data scores;
   infile datalines dsd;
   input Name : $9. Score1-Score3 Team ~ $25. Div $;
   datalines;
Smith,12,22,46,'Green Hornets, Atlanta',AAA 
Mitchel,23,19,25,'High Volts, Portland',AAA 
Jones,09,17,54,'Vulcans, Las Vegas',AA 
; 

data work.cities;
*length city $12;
input city &   $30.;
datalines;
New York * 7City
Los 	Angeles 
Chicago 
San _Francisco 
;
run;

data games;
   input name=$30. score1= score2=;
   datalines;
name=rileyguhus fvuygu bfgb regeg score1=1132 score2=1187
;









