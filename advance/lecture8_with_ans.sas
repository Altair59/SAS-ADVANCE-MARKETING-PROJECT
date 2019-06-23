/* 8.1 Subset rows by using conditional operators */
/*******************************************
*******************************************
*******************************************
*******************************************/

/* Use data sashelp.shoes */

/* BETWEEN-AND: sales between 100,000 and 300,000 */
proc sql;
	select * from sashelp.shoes
		where sales between 100000 and 300000
		order by sales;
quit;


/*IN/NOT IN: region in Canada and Asia*/
proc sql;
	select * from sashelp.shoes
		where region in ('Canada','Asia')
		order by region;
quit;

/*IS MISSING OR IS NULL: find records with salary is missing in sashelp.baseball*/
proc sql;
	select * from sashelp.BASEBALL
		where salary is MISSING;
quit;


/*practice*/
/*identify all players who are in team Toronto/Montreal/New York and have salary > 500*/
options nolabel;
proc sql;
	select * from sashelp.BASEBALL
		where team in ('Toronto', 'Montreal', 'New York') and salary > 500;
quit;

/* 8.2 and 8.3 
Subset rows by using calculated values
Specify column Formats and Labels */
/*******************************************
*******************************************
*******************************************
*******************************************/

/*using sashelp.shoes, calcualte net_sales = sales - returns and only output records with net_sales > 100000*/

proc sql;
	select *, sales - returns as net_sales label='Total Net Sales' format=dollar12.0 from sashelp.shoes
	 where calculated net_sales > 100000;
quit;



/* 8.4 Summarize and group data */
/*******************************************
*******************************************
*******************************************
*******************************************/

/* Example by using sashelp.air */

/*without group by */
Proc sql;
      select date, 
                  avg(air) as AvgAir
       from sashelp.air;

/*with group by*/
Proc sql;
      select date, 
                  avg(air) as AvgAir
       from sashelp.air
       group by date;


/* 8.5 Select groups by using HAVING clause */
/*******************************************
*******************************************
*******************************************
*******************************************/
Proc sql;
      select date, 
                  avg(air) as AvgAir
       from sashelp.air
       group by date
       having avg(air) > 200;
quit;

/* practice */
/*Use data sashelp.shoes to find product with total sales > 5 million*/
proc sql;
	 select product, sum(sales) format=dollar12.0 from 
	 sashelp.shoes
	 group by 1
	 having sum(sales) > 5000000;
	 
/* 8.6 Count value by using the COUNT Summary function */
/*******************************************
*******************************************
*******************************************
*******************************************/

/*use region column as an example, from sashelp.shoes*/
proc sql;
	select count(*), count(region), count(distinct region) from sashelp.shoes
		;
quit;

/*how many total records under each region*/
proc sql;
select region, count(*) as no_record from sashelp.shoes
		group by 1;
quit;

/* practice */
/*how many distinct product under each region*/
proc sql;
select region, count(distinct product) as no_product from sashelp.shoes
		group by 1;
quit;


	 
/* 8.7 Subset data by using Subqueries */
/*******************************************
*******************************************
*******************************************
*******************************************/
/* noncorrelated */
proc sql;
select product, avg(sales) from sashelp.shoes group by product
having avg(sales) > (select avg(sales) from sashelp.shoes);
quit;
	 
	
