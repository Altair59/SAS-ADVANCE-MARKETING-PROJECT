
/*Common SAS interview questions
*******************************
********************************
*********************************/


/*2.0 - Generate a cumulative total per BY-group using DATA step code*/

data one;
input x y;
datalines;
1 3
1 6
2 7
2 8
2 9
2 5
3 3
3 5
4 10
4 4
4 9
4 15
4 3
;
run;

data 

/* Initialize the TOTAL variable back to zero at the beginning of each  */
/* BY-Group. Sum the variable while the BY-Group remains the same       */
/* and produce a total for the BY-Group on the last observation of the  */
/* BY-Group. Output the last observation for each BY-Group.             */



/* use SQL */
proc sql;

quit;


/*2.1 Proc Import - used to import file into SAS*/

/*
PROC IMPORT 
DATAFILE="filename" | TABLE="tablename" 
OUT=<libref.>SAS data-set <(SAS data-set-options)> 
<DBMS=identifier><REPLACE> ;
<data-source-statement(s);>
*/

/*import a csv from Excel*/

libname pmlr '/folders/myfolders/project';

proc import datafile='/folders/myfolders/sasproject/b.csv'
out = pmlr.base_pop
dbms=csv
replace;
run;



/*2.2 Proc Export - used to export file*/

/*
PROC EXPORT DATA=<libref.>SAS data-set <(SAS data-set-options)> 
OUTFILE="filename" | OUTTABLE="tablename" 
<DBMS=identifier> <REPLACE><LABEL>;
<data-source-statement(s);>

*/
proc export data=sashelp.air
outfile='/folders/myfolders/project/new_air.csv'
dbms=csv
replace;
run;



/*2.2 Proc SQL*/
/*2.2.1 - Creating a Table and Inserting Data into It */
	
proc sql;
   create table paylist
       (IdNum char(4),
        Gender char(1),
        Jobcode char(3),
        Salary num,
        Birth num informat=date7.
                  format=date7.,
        Hired num informat=date7.
                  format=date7.);
quit;
	
proc sql;
insert into paylist
    values('1639','F','TA1',42260,'26JUN70'd,'28JAN91'd)
    values('1065','M','ME3',38090,'26JAN54'd,'07JAN92'd)
    values('1400','M','ME1',29769.'05NOV67'd,'16OCT90'd)
    values('1561','M',null,36514,'30NOV63'd,'07OCT87'd)
    values('1221','F','FA3',.,'22SEP63'd,'04OCT94'd);
quit;
	
proc sql;
select *
   from paylist;
quit;



/*2.2.2 -Updating Data in a PROC SQL Table*/


data Employees;
   input IdNum $4. +2 LName $11. FName $11. JobCode $3.
          +1 Salary 5. +1 Phone $12.;
   datalines;
1876  CHIN       JACK       TA1 42400 212/588-5634
1114  GREENWALD  JANICE     ME3 38000 212/588-1092
1556  PENNINGTON MICHAEL    ME1 29860 718/383-5681
1354  PARKER     MARY       FA3 65800 914/455-2337
1130  WOOD       DEBORAH    PT2 36514 212/587-0013
;

proc sql;
   title 'Employees Table';
   select * from Employees;
quit;

proc sql;



quit;

proc sql;
   title 'Employees Table';
   select * from Employees;
quit;


/*2.2.3 -Join tables*/


/*now it is your turn to practice*/

/*background:
the 2 csv Excel files are the marketing campaign datasets. b.csv has all the customers we sent offer;
d.csv is the result after we sent offer

we need to know the response rate, approval rate*/


/*import d.csv from local and name it as decision*/
proc import datafile='/folders/myfolders/sasproject/d.csv'
out=pmlr.decision
dbms=csv
replace;
run;

proc contents data=pmlr.decision;
run;







/*explore the 2 dataseets by using proc contents*/
proc contents data=pmlr.base_pop;
run;

proc contents data=pmlr.decision;
run;


/*join base population which was imported from b.csv with decision table to know how many accounts
get approval/decision, and how many responder
hint for join: account_number=acct_decision_id;*/

proc sql;
create table summary_report as 
select base.*, decision.decision_status, decision.desicion_date
from pmlr.base_pop as base
left join
pmlr.decision as decision
on
base.account_number=decision.acct_decision_id;
quit;


/*what is the total number of repsonder and response rate*/

proc sql;

quit;


/*create a table has number of responders by day*/
proc sql;
create  table response_day as




quit;

/*use data step to get the cumulative response rate by date by using first.variable, last.variable
recall what you have learn from last class*/
proc sort data=response_day;
by decision_date;
run;


data response_day2;
set response_day;



run;


/*export this reponse table to csv*/
proc export data=response_day2



run;



