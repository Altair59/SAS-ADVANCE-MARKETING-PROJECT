

libname pmlr '/folders/myfolders/sasproject';
/*use proc contents to explore the data pmlr.pva_raw_data*/

/*create a temporary dataset pva by copying pmlr.pva_raw_data and drop the column Control_number*/



%let ex_inputs= MONTHS_SINCE_ORIGIN 
DONOR_AGE IN_HOUSE INCOME_GROUP PUBLISHED_PHONE
MOR_HIT_RATE WEALTH_RATING MEDIAN_HOME_VALUE
MEDIAN_HOUSEHOLD_INCOME PCT_OWNER_OCCUPIED
PER_CAPITA_INCOME PCT_MALE_MILITARY 
PCT_MALE_VETERANS PCT_VIETNAM_VETERANS 
PCT_WWII_VETERANS PEP_STAR RECENT_STAR_STATUS
FREQUENCY_STATUS_97NK RECENT_RESPONSE_PROP
RECENT_AVG_GIFT_AMT RECENT_CARD_RESPONSE_PROP
RECENT_AVG_CARD_GIFT_AMT RECENT_RESPONSE_COUNT
RECENT_CARD_RESPONSE_COUNT LIFETIME_CARD_PROM 
LIFETIME_PROM LIFETIME_GIFT_AMOUNT
LIFETIME_GIFT_COUNT LIFETIME_AVG_GIFT_AMT 
LIFETIME_GIFT_RANGE LIFETIME_MAX_GIFT_AMT
LIFETIME_MIN_GIFT_AMT LAST_GIFT_AMT
CARD_PROM_12 NUMBER_PROM_12 MONTHS_SINCE_LAST_GIFT
MONTHS_SINCE_FIRST_GIFT;

/*Check the mean, minimum, maximum, and count of missing for each numeric input*/

proc means data=pva n nmiss mean std min max;

run;

/*check frequency for character variables*/
proc freq data=pva;

run;

/*The current model consists of PEP_STAR, RECENT_AVG_GIFT_AMT, 
and FREQUENCY_STATUS_97NK. Fit this model to the data. 
Use the SCORE statement to append the predicted probability to the data. */
proc logistic data=pva des;
   model target_b=PEP_STAR RECENT_AVG_GIFT_AMT
                  FREQUENCY_STATUS_97NK;
   score data=PMLR.PVA_RAW_DATA 
         out=scopva;
run;
/* Investigate the minimum, maximum, and average predicted probability of response
 based on this model */
proc means data=scopva min mean max;
   var p_1;
run;

/*How many individuals in the sample have a predicted response rate 
greater than 0.025? 0.05? 0.075? 
How many responders? */




/*how to use proc sql to solve this question (sum() ,count() 
and where filter)*/



/*Create missing value indicators for inputs that have missing values.*/
/*
missing columns are: DONOR_AGE INCOME_GROUP WEALTH_RATING;
*/


/*Impute missing value to a new dataset pva1*/



/*
Split the imputed data set into training and test data sets. 
Use 70% of the data for each data
set role. Stratify on the target variable.*/



/* use proc means to check whether train is 70% and 30% for test, and response rate is the same*/





/*create macro variable which has all the independent variables we need*/

%let ex_screened=
LIFETIME_CARD_PROM       LIFETIME_MIN_GIFT_AMT   PER_CAPITA_INCOME
mi_INCOME_GROUP   
RECENT_RESPONSE_COUNT    PCT_MALE_MILITARY
DONOR_AGE                PCT_VIETNAM_VETERANS    MOR_HIT_RATE
PCT_OWNER_OCCUPIED       PCT_MALE_VETERANS       PUBLISHED_PHONE
WEALTH_RATING MONTHS_SINCE_LAST_GIFT   RECENT_STAR_STATUS      LIFETIME_GIFT_RANGE
INCOME_GROUP             IN_HOUSE  
RECENT_AVG_GIFT_AMT     PCT_WWII_VETERANS
LIFETIME_GIFT_AMOUNT     PEP_STAR                mi_DONOR_AGE
RECENT_AVG_CARD_GIFT_AMT RECENT_CARD_RESPONSE_PROP
;

/*Use the Spearman correlation coefficients to screen the inputs with the
least evidence of a relationship with the target*/



/*
Fit a logistic regression model with the FAST BACKWARD method. Use the macro variable
ex_screened to represent all independent variables*/



/*
Fit a logistic regression model with the FAST Stepwise method. Use the macro variable
ex_screened to represent all independent variables*/



/*let's assume the final variable you select are:
MONTHS_SINCE_LAST_GIFT: months since most recent donation
INCOME_GROUP: income bracket, from 1 to 7
RECENT_AVG_GIFT_AMT: average donation amount
PEP_STAR: flag to identify consecutive donors
RECENT_CARD_RESPONSE_PROP: proportion of responses to promotions
*/






