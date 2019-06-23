/* 7.1 practice step by step */
/*******************************************
*******************************************
*******************************************
*******************************************/


/* use the CARS dataset in SASHELP library */
/*eveytime before running any SQL, use proc contents to explore the data first */

proc contents data = sashelp.cars;
run;

/*1,2.SELECT FROM: make, model, type, origin, MSRP, invoice*/

proc sql;
select make, model, type, origin, MSRP, invoice
		from sashelp.cars;
quit;

/*3.WHERE: only select BMW make */

proc sql;
select make, model, type, origin, MSRP, invoice
		from sashelp.cars
		where make = 'BMW';
quit;


/*4.ORDER BY: only select BMW and order by MSRP in descending order */

proc sql;
select make, model, type, origin, MSRP, invoice
		from sashelp.cars
		where make = 'BMW'
		order by MSRP DESC;  /*Orders the data in descending order, by default is ascending order */;
quit;

/*5.Create new column: price_gap = MSRP - Invoice (no space when name a new column)*/

proc sql;
select make, model, type, origin, MSRP, invoice, MSRP-Invoice as price_gap
		from sashelp.cars
		where make = 'BMW'
		order by MSRP DESC;  /*Orders the data in descending order, by default is ascending order */;
quit;


/*practice: SELECT MAKE,MODEL,TYPE, MSRP FROM sashelp.cars WHERE MAKE=Audi ORDER BY MSRP*/

proc sql;
select make, model, type, msrp from sashelp.cars
where make='Audi'
order by msrp;
quit;


/*6.Select all columns*/

proc sql;
select *
		from sashelp.cars;
quit;

/*7.Limit the number of rows, very useful when exploring the data. e.g. only output 100 records*/
proc sql  outobs=100;
select *
		from sashelp.cars;
quit;

/*8. Eliminate duplicate rows by using distinct*/
proc sql;
select distinct make
		from sashelp.cars;
quit;

/*DISTINCT applies to all columns listed in the SELECT clause*/
/*practice: output distinct type under each make*/
proc sql;
select distinct make, type /*can we put the distinct in the second column?*/
		from sashelp.cars;
quit;


/* 7.2 Summarize Groups of data */
/*******************************************
*******************************************
*******************************************
*******************************************/

proc contents data=sashelp.shoes;
run;

/*to see sum of sales by region*/

proc sql;
select region, sum(sales) as total_sales from sashelp.shoes
group by region;
quit;

/*only show region with sales > 5 million*/

proc sql;
select region, sum(sales) as total_sales from sashelp.shoes
group by region
having total_sales > 5000000;
quit;

/*practice: to see averagae of sales by region, by product*/
proc sql;
select region, product, mean(sales) as mean_sales from sashelp.shoes
group by region, product
order by  region;
quit;



/* 7.3 Create output tables */
/*******************************************
*******************************************
*******************************************
*******************************************/

/*create a temporary table called mean_sales_by_product based on previous example*/
proc sql;
create table mean_sales_by_product as
select region, product, mean(sales) as mean_sales from sashelp.shoes
group by region, product
order by mean_sales;
quit;

/*create a permenant table*/
/*libname first to define a permenant directory*/

libname sasadv '/folders/myfolders/sasadv';

/*practice: create a table called mean_sales_by_product under sasadv library*/
proc sql;
create table sasadv.mean_sales_by_product as
select region, product, mean(sales) as mean_sales from sashelp.shoes
group by region, product
order by mean_sales;
quit;





/*Homework*/ 
/*******************************************
*******************************************
*******************************************
*******************************************/

/*use data sashelp.fish*/

/*to select all from the dataset*/
proc sql;
select * from sashelp.fish;
quit;

/*only select columns: species, weight, height, width from the dataset
and only look at species = 'Perch'*/

proc sql;
select species, weight, height, width from sashelp.fish
where species='Perch';
quit;


/*To show:
number of records as no_record, average weight as avg_w, average heigt as avg_h by species, but excluding 'Whitefish', order by average weight*/
proc sql;
select species, count(*) as no_record, mean(weight) as avg_w, mean(height) as avg_h from sashelp.fish 
where species ne 'Whitefish'
group by 1
order by avg_w
;
quit;

/*save the result to a permenant table called fish under sasadv library which is your local folder*/
libname sasadv '/folders/myfolders/sasadv';
proc sql;
create table sasadv.fish as
select species, count(*) as no_record, mean(weight) as avg_w, mean(height) as avg_h from sashelp.fish 
where species ne 'Whitefish'
group by 1
order by avg_w
;
quit;


