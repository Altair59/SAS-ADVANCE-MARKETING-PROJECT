/* The case is about a car insurance marketing campaign.
for this project, we will learn how to conduct typical marketing
analytics to evaluate marketing effort*/

/* import the data first */

libname ibm '/folders/myfolders/sasproject';

FILENAME REFFILE '/folders/myfolders/sasproject/Marketing_IBM.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=car_insurance;
RUN;

/*
Step One - check the key KPI for this marketing campaign:
*/

/*Q1. what is the total response rate?*/



/*Customer Segmentation analysis:
When we are reporting and tracking the progress of marketing efforts, 
we typically would want to dive deeper into the data and 
break down the customer base into multiple segments 
and compute KPIs for individual segments*/

/* Q2. Analyze how these response varies by different Educations? 
       get the response rate by each education group*/
/*       first converte the response into numberic by creating res_flag */
data car_insurance;
set car_insurance;
if response='Yes' then res_flag=1;
else res_flag=0;
run;



/* Q3. Analyze how these response varies by different Sales_Channel*/



/* Q4. Get response rate by sales channel and vehicle size */



/* Q5: Let's segment our customer base by Customer Lifetime Value
 */
	/*we are going to define those customers with 
	a Customer Lifetime Value higher than the median as 
	high-CLV customers
	and those with a CLV below the median as low-CLV customers*/


/* Q6: Let's Get response rate by clv_seg
 */


