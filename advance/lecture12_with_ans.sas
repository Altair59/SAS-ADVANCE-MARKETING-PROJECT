libname sasadv '/folders/myfolders/sasadv';
data sasadv.courses;
   input Course_Code $ 1-4 Course_Title $ 6-30 Days 32 Fee 34-37;
   format fee dollar5. days 1.;
   label course_code = 'Course Code'
         course_title = 'Description'
         days = 'Course Length'
         fee = 'Course Fee';
   datalines;
C001 Basic Telecommunications  3  795
C002 Structured Query Language 4 1150
C003 Local Area Networks       3  650
C004 Database Design           2  375
C005 Artificial Intelligence   2  400
C006 Computer Aided Design     5 1600
;
run;

data sasadv.schedule;
   input Course_Number 1-2 Course_Code $ 4-7 Location $ 9-15
         @17 Begin_Date date9. Teacher $ 27-47;
   format course_number 2. begin_date date9. location 15.;
   label course_code = 'Course Code'
         course_number = 'Course Number'
         begin_date = 'Begin'
         location = 'Location'
         teacher = 'Instructor';
   datalines;
 1 C001 Seattle 23OCT2000 Hallis, Dr. George
 2 C002 Dallas  04DEC2000 Wickam, Dr. Alice
 3 C003 Boston  08JAN2001 Forest, Mr. Peter
 4 C004 Seattle 22JAN2001 Tally, Ms. Julia
 5 C005 Dallas  26FEB2001 Hallis, Dr. George
 6 C006 Boston  02APR2001 Berthan, Ms. Judy
 7 C001 Dallas  21MAY2001 Hallis, Dr. George
 8 C002 Boston  11JUN2001 Wickam, Dr. Alice
 9 C003 Seattle 16JUL2001 Forest, Mr. Peter
10 C004 Dallas  13AUG2001 Tally, Ms. Julia
11 C005 Boston  17SEP2001 Tally, Ms. Julia
12 C006 Seattle 01OCT2001 Berthan, Ms. Judy
13 C001 Boston  12NOV2001 Hallis, Dr. George
14 C002 Seattle 03DEC2001 Wickam, Dr. Alice
15 C003 Dallas  07JAN2002 Forest, Mr. Peter
16 C004 Boston  21JAN2002 Tally, Ms. Julia
17 C005 Seattle 25FEB2002 Hallis, Dr. George
18 C006 Dallas  25MAR2002 Berthan, Ms. Judy
;
run;

/* Lecture 12 */
/*******************************************
*******************************************
*******************************************
**********************
*********************/

/* Create a Macro Variable During DATA Step Execution  */
%let crsid='C001';
data sss;
	set sasadv.courses;
	where course_code=&crsid;
	call symput('title', trim(course_title));
run;

%put &title;


/* Forward Re-scan Rule Example */

/* Q63 - 33: */
  %let Thing1=gift;     
  %let Thing2=surprise; 
  %let Gift1=book;      
  %let Gift2=jewelry;   
  %let Surprise1=dinner;
  %let Surprise2=movie; 
 
  %let Pick=2;
  %let Choice=surprise; 
 
/*
  Desired %PUT Results in LOG:  
  My favorite surprise is a movie
*/
 
/*
What is the correct %PUT statement that generates the desired results?    
A. %put My favorite &Thing&Pick is a &&Choice&Pick;
B. %put My favorite &&Thing&pick is a &&&Choice&Pick;
C. %put My favorite &Choice&pick is a &&Thing&Pick;
D. %put My favorite &&Choice&pick is a &&&Thing&Pick;
*/

%put My favorite &Thing&Pick is a &&Choice&Pick;
%put My favorite &&Thing&pick is a &&&Choice&Pick;
%put My favorite &Choice&pick is a &&Thing&Pick;
%put My favorite &&Choice&pick is a &&&Thing&Pick;
/* Create Macro Variables During Proc SQL Step Execution */
PROC SQL NOPRINT;
	select distinct teacher into :sites separated by '%'
		from sasadv.schedule;
Quit;

%PUT &sites;

/* Create Macro Program */
%macro printdsn (dsn=sashelp.class, vars=sex age);
	proc print data=&dsn;
		var &vars;
	title “Listing of %upcase(&dsn) data set”;
	run;
%mend;

%printdsn();

/*practice: use dsn=sashelp.shoes, vars=region product*/
%printdsn (dsn=sashelp.shoes, vars=region sales);


/*使用位置参数*/
%macro printdsn (dsn, vars);
	proc print data=&dsn;
		var &vars;
	title “Listing of %upcase(&dsn) data set”;
	run;
%mend;
%printdsn (sashelp.shoes, region sales);


/*Understand symbol table*/
%let dsn=sasuser.Courses;

%macro printdsn;
	%local dsn;
	%let dsn=sasuser.register;
	%put The value of DSN inside Printdsn is &dsn;
%mend;

%printdsn;

%put &dsn;

