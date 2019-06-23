
/*Common SAS interview questions
*******************************
********************************
*********************************/

/*2.1 This exercise illustrates how to use proc freq to check frequency*/

/*
The eye and hair color of children from two different regions of Europe are recorded in the data set Color. 
Instead of recording one observation per child, 
the data are recorded as cell counts, 
where the variable Count contains the number of children exhibiting each of the 15 eye 
and hair color combinations. The data set does not include missing combinations.

The following DATA step statements create the SAS data set Color, run it first:*/

data Color;
   input Region Eyes $ Hair $ Count @@;
   label Eyes  ='Eye Color'
         Hair  ='Hair Color'
         Region='Geographic Region';
   datalines;
1 blue  fair   23  1 blue  red     7  1 blue  medium 24
1 blue  dark   11  1 green fair   19  1 green red     7
1 green medium 18  1 green dark   14  1 brown fair   34
1 brown red     5  1 brown medium 41  1 brown dark   40 
1 brown black   3  2 blue  fair   46  2 blue  red    21
2 blue  medium 44  2 blue  dark   40  2 blue  black   6
2 green fair   50  2 green red    31  2 green medium 37
2 green dark   23  2 brown fair   56  2 brown red    42
2 brown medium 53  2 brown dark   54  2 brown black  13
;

/*Hint:
The WEIGHT statement names a numeric variable that provides a weight for each 
observation in the input data set. The WEIGHT statement is most commonly used 
to input cell count data. See the section Inputting Frequency Counts for more 
information. If you use a WEIGHT statement, PROC FREQ assumes that an observation 
represents n observations, where n is the value of variable*/

/*write script to generate 
a frequency table for Eyes, 
a frequency table for Hair, 
and a crosstabulation table for Eyes by Hair.*/






/*2.2 This example illustrates how to use proc univariate to analyze the variable and 
create a histogram. */

/*
A semiconductor manufacturer produces printed circuit boards that are sampled 
to determine the thickness of their copper plating. 
The following statements create a data set named Trans, 
which contains the plating thicknesses (Thick) of 100 boards:*/

/*run the script below to create the dataset first*/
data Trans;
   input Thick @@;
   label Thick = 'Plating Thickness (mils)';
   datalines;
3.468 3.428 3.509 3.516 3.461 3.492 3.478 3.556 3.482 3.512
3.490 3.467 3.498 3.519 3.504 3.469 3.497 3.495 3.518 3.523
3.458 3.478 3.443 3.500 3.449 3.525 3.461 3.489 3.514 3.470
3.561 3.506 3.444 3.479 3.524 3.531 3.501 3.495 3.443 3.458
3.481 3.497 3.461 3.513 3.528 3.496 3.533 3.450 3.516 3.476
3.512 3.550 3.441 3.541 3.569 3.531 3.468 3.564 3.522 3.520
3.505 3.523 3.475 3.470 3.457 3.536 3.528 3.477 3.536 3.491
3.510 3.461 3.431 3.502 3.491 3.506 3.439 3.513 3.496 3.539
3.469 3.481 3.515 3.535 3.460 3.575 3.488 3.515 3.484 3.482
3.517 3.483 3.467 3.467 3.502 3.471 3.516 3.474 3.500 3.466
;
/*use Proc Univariate to analyze the variable and plot histogram*/

proc univariate data=trans;
var thick;
histogram thick;
run;



/*2.3 Proc GLM
PROC GLM analyzes data within the framework of general linear models. 
PROC GLM handles models relating one or several continuous dependent variables to one or several independent variables. 
The independent variables can be either classification variables, which divide the observations into discrete groups, or continuous variables. 
Thus, the GLM procedure can be used for many different analyses, including the following:

-- simple regression
-- multiple regression
-- analysis of variance (ANOVA), especially for unbalanced data
-- analysis of covariance
-- response surface models
-- weighted regression
-- polynomial regression
-- partial correlation
-- multivariate analysis of variance (MANOVA)
-- repeated measures analysis of variance*/

/*
A car is tested for gas mileage at various speeds to determine at what speed the car achieves the highest gas mileage. 
A quadratic model is fit to the experimental data.*/

   title 'Gasoline Mileage Experiment';
   data mileage;
      input mph mpg @@;
      datalines;
   20 15.4
   30 20.2
   40 25.7
   50 26.2  50 26.6  50 27.4
   55   .
   60 24.8
   ;

   proc glm;
      model mpg=mph mph*mph / p clm;
   run;

/*2.4  First.variable and Last.variable in SAS */
/*
FIRST.variable and LAST.variable are variables 
that SAS creates for each BY variable. 
SAS sets FIRST.variable=1 when it is processing the first observation in a BY group, 
and sets LAST.variable=1 when it is processing the last observation in a BY group. 
These assignments enable you to take different actions, 
based on whether processing is starting for a new BY group or ending for a BY group*/

/*let us look at example first*/

data testfile;
   input x $ y $ 9-17 z $ 19-26; 
   datalines; 
apple   banana    coconut
apple   banana    coconut 
apricot blueberry citron
; 
run;

proc sort data=testfile;
by x y z;
run;

data testfile2;
set testfile;
by x y z;
a1=first.x;
a2=last.x;
b1=first.y;
b2=last.y;
c1=first.z;
c2=last.z;
run;

data by_data;
input prov$ cty$ mth income @@;
cards;
JS c1 1 100 JS c1 2 110
JS c1 3 101 JS c2 1 200
JS c2 2 210 JS c2 3 201
SH c1 1 500 SH c1 2 510
SH c1 3 501 SH c2 1 400
SH c2 2 410 SH c2 3 4201
;
run;

proc sort data=by_data;
by prov cty mth;
run;

data fst_lst;
set by_data;
by prov cty mth;
fp=first.prov;
lp=last.prov;
fc=first.cty;
lc=last.cty;
fm=first.mth;
lm=last.mth;
run;

/*get the accumulative income for each city under each prov*/
data fst_lst;
set by_data;
by prov cty;
fp=first.prov;
lc=last.cty;
if first.cty then accu_for_city=income;
else accu_for_city+income;
run;

/*how do I only show the accumulative number for each city under each prov to my boss by
using a clear report view?*/




/*now it is your turn
sort the data by prov and mth, and look at first/last.prov and mth to see how it is different
from the previous example*/




