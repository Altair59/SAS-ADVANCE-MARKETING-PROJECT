/* 11 Macro Variables/
/*******************************************
*******************************************
*******************************************
**********************
*********************/

%let name= Ed Norton ;

%let name2=‘ Ed Norton ‘;

%let title=“Joan’s Report”;

%let start=;

%let total=0;

%let sum=4+5;

%put &sysdate;
%put &name;
%put &name2;
%put &title;
%put &start;
%put &total;
%put &sum;


/* %upcase */
%let name=ken;
%put %upcase(&name);

/* %substr */
%put %substr(&sysdate9,1);
%put %substr(&sysdate9,1,5);

/* %sysfunc */
%let current=%sysfunc(today(),weekdate.);
%put &current;

/*practice*/
/*use define 2 macro variables, region=Canada, sales=1000000
use these 2 variables to select Canada region and sales > 700000
from sashelp.shoes*/

%let reg='Canada';
%let sal=700000;
proc sql;
select * from sashelp.shoes
where region=&reg and sales>&sal;
quit;
