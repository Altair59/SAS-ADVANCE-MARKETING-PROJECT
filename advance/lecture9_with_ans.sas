libname sasadv '/folders/myfolders/sasadv';

/* 9.1 Inner Join */
/*******************************************
*******************************************
*******************************************
*******************************************/
/*sasadv.staffmaster: EmpID, LastName, FirstName, City, State, PhoneNumber*/
/*sasadv.payrollmaster: EmpID, Gender, JobCode, Salary, DateOfBirth, DateOfHire*/

/*EmpID is the common column!*/

/*use where*/
proc sql;
select a.*, b.* from 
sasadv.payrollmaster as a,
sasadv.staffmaster as b
where a.EmpID=b.EmpID;
quit;

/*I want to know, how many records in both tables*/
proc sql;
select count(*)from
(select a.*, b.* from 
sasadv.payrollmaster as a,
sasadv.staffmaster as b
where a.EmpID=b.EmpID);
quit;

/* 9.2 Inner Join with a different syntax*/
/*******************************************
*******************************************
*******************************************
*******************************************/
/*use join*/
proc sql;
select a.*, b.* 
	from 
sasadv.payrollmaster as a
JOIN
sasadv.staffmaster as b
ON
a.EmpID=b.EmpID;
quit;


/* 9.3 Left Join*/
/*******************************************
*******************************************
*******************************************
*******************************************/
proc sql;
select a.*, b.* from sasadv.staffmaster as a 
LEFT JOIN 
sasadv.payrollmaster as b
ON a.EmpID=b.EmpID;
quit;

/*I want to know my colleague JEFF LI's salary :)*/
proc sql;
select a.*, b.* from sasadv.staffmaster as a 
LEFT JOIN 
sasadv.payrollmaster as b
ON a.EmpID=b.EmpID
WHERE lastname='LI' and firstname='JEFF';
quit;

/* 9.4 Right Join*/
/*******************************************
*******************************************
*******************************************
*******************************************/
proc sql;
select a.*, b.* from 
sasadv.staffmaster as a 
RIGHT JOIN 
sasadv.payrollmaster as b
ON a.EmpID=b.EmpID;
quit;


/* 9.5 FULL Join*/
/*******************************************
*******************************************
*******************************************
*******************************************/
proc sql;
select a.*, b.* from 
sasadv.staffmaster as a 
FULL JOIN 
sasadv.payrollmaster as b
ON a.EmpID=b.EmpID;
quit;

/* 9.6 Only select the columns you need and Use COALESCE Function to overlay columns*/
/*******************************************
*******************************************
*******************************************
*******************************************/
/*i only need EmpID, LastName, FirstName, Salary, dateofbirth*/

proc sql;
select 
coalesce(a.EmpID, b.EmpID) as EmpID,
a.LastName, a.FirstName, b.Salary, b.dateofbirth 
from sasadv.staffmaster as a 
FULL JOIN 
sasadv.payrollmaster as b
ON a.EmpID=b.EmpID;
quit;

/*Homework practice*/
/*******************************************
*******************************************
*******************************************
*******************************************/

/*Use sasadv.staffmaster as left table(base table), I want to know dateofbirth for each employee in staffmaster*/
proc sql;
select 
a.*, b.dateofbirth
from sasadv.staffmaster as a 
Left JOIN 
sasadv.payrollmaster as b
ON a.EmpID=b.EmpID;
quit;

/*Use sasadv.payrollmaster as left table(base table), I want to know the names of employees with salary > 70,000*/
proc sql;
select 
a.*, b.LastName,b.FirstName
from sasadv.payrollmaster as a 
left JOIN 
sasadv.staffmaster as b
ON a.EmpID=b.EmpID
where salary > 70000;
quit;

/*Find employees in both table and only select EmpID,Gender, JobCode, Salary,LastName, FirstName, City, State*/
proc sql;
select 
a.EmpID,a.Gender, a.JobCode, a.Salary, 
b.LastName, 
b.FirstName, 
b.City, 
b.State
from sasadv.payrollmaster as a 
JOIN 
sasadv.staffmaster as b
ON a.EmpID=b.EmpID;
quit;

/*For these employees in both table, I want to know the average sales by gender*/
/*Hint: you can save the result from above example into a temporary table, and then select gender, mean(salary) from the table - do not 
forget Group by */
proc sql;
select 
a.Gender, mean(Salary) 
from sasadv.payrollmaster as a 
JOIN 
sasadv.staffmaster as b
ON a.EmpID=b.EmpID
group by 1;
quit;

/*Let us make it more difficult:
For these employees in both table and live in New York city, I want to know the average sales by gender*/
proc sql;
select 
a.Gender, mean(Salary) 
from sasadv.payrollmaster as a 
JOIN 
sasadv.staffmaster as b
ON a.EmpID=b.EmpID
WHERE CITY='NEW YORK'
group by 1;
quit;  










/* code below is to create the dataset, just in case
*******************************************
*******************************************
*******************************************
*******************************************
*******************************************
*******************************************
*******************************************
********************************************/

/*
data sasadv.payrollmaster;
   informat DateOfBirth DateOfHire date9.;
   input EmpID $ 1-4 Gender $ 11 JobCode $ 19-21
         @28 Salary dollar8. @40 DateOfBirth date9.
         @53 DateOfHire date9.;
   format salary dollar9. dateofbirth dateofhire date9.;
datalines;
1919      M       TA2       $48,126    16SEP1968    07JUN1995
1653      F       ME2       $49,151    19OCT1972    12AUG1998
1400      M       ME1       $41,677    08NOV1975    19OCT1998
1350      F       FA3       $46,040    04SEP1973    01AUG1998
1409      M       ME3       $58,171    22APR1958    26OCT1999
1408      M       TA2       $47,793    02APR1968    17OCT1995
1121      M       ME1       $40,757    29SEP1979    10DEC2009
1991      F       TA1       $38,703    11MAY1980    16DEC2009
1102      M       TA2       $48,359    04OCT1967    18APR1997
1356      M       ME2       $51,617    30SEP1965    25FEB1995
1545      M       PT1       $92,582    15AUG1967    01JUN2001
1292      F       ME2       $51,367    01NOV1972    06JUL2012
1440      F       ME2       $50,060    30SEP1970    12APR2003
1368      M       FA2       $38,931    15JUN1969    07NOV2004
1369      M       TA2       $47,187    01JAN1970    16MAR2001
1411      M       FA2       $38,171    31MAY1969    05DEC2000
1113      F       FA1       $31,314    18JAN1976    20OCT2010
1704      M       BCK       $35,651    02SEP1974    01JUL2007
1900      M       ME2       $49,147    28MAY1970    30OCT2001
1126      F       TA3       $57,259    31MAY1971    25NOV1999
1677      M       BCK       $36,410    08NOV1971    31MAR2003
1441      F       FA2       $38,021    23NOV1977    26MAR2006
1421      M       TA2       $46,417    11JAN1967    03MAR2003
1119      M       TA1       $37,694    23JUN1970    10SEP2007
1834      M       BCK       $37,654    11FEB1980    06JUL2010
1777      M       PT3      $153,482    26SEP1959    25JUN1998
1663      M       BCK       $37,033    14JAN1975    14AUG2002
1106      M       PT2      $125,485    10NOV1965    20AUG1996
1103      F       FA1       $33,233    19FEB1976    27JUL2012
1477      M       FA2       $39,992    25MAR1972    11MAR2009
1476      F       TA2       $48,724    02JUN1974    20MAR2005
1379      M       ME3       $59,170    12AUG1969    14JUN2006
1104      M       SCP       $25,124    28APR1971    13JUN2009
1009      M       TA1       $40,432    05MAR1967    30MAR2001
1412      M       ME1       $38,919    22JUN1964    08DEC2000
1123      F       TA1       $39,770    04NOV1980    09DEC2003
1907      M       TA2       $46,661    19NOV1968    09JUL1997
1436      F       TA2       $48,265    15JUN1972    15MAR2010
1385      M       ME3       $61,460    20JAN1970    04APR2006
1432      F       ME2       $49,458    07NOV1969    14FEB2005
1036      F       TA3       $55,149    23MAY1973    27OCT2003
1130      F       FA1       $33,482    19MAY1979    09JUN2009
1127      F       TA2       $46,215    13NOV1972    10DEC2006
1433      F       FA3       $46,175    11JUL1974    20JAN2004
1431      F       FA3       $46,522    13JUN1972    09APR2005
1122      F       FA2       $39,138    04MAY1971    01DEC2007
1105      M       ME2       $48,727    04MAR1970    16AUG1988
;
run;


data sasadv.staffmaster;
   input EmpID $ 1-4 LastName $ 9-23 FirstName $ 25-39
         City $ 41-55 State $ 58-59 PhoneNumber $ 66-77;
datalines;
1919    ADAMS           GERALD          STAMFORD         CT      203/781-1255
1653    ALEXANDER       SUSAN           BRIDGEPORT       CT      203/675-7715
1400    APPLE           TROY            NEW YORK         NY      212/586-0808
1350    ARTHUR          BARBARA         NEW YORK         NY      718/383-1549
1574    CAHILL          MARSHALL        NEW YORK         NY      718/383-2338
1789    CARAWAY         DAVIS           NEW YORK         NY      212/587-9000
1404    CARTER          DONALD          NEW YORK         NY      718/384-2946
1437    CARTER          DOROTHY         BRIDGEPORT       CT      203/675-4117
1639    CARTER          KAREN           STAMFORD         CT      203/781-8839
1269    CASTON          FRANKLIN        STAMFORD         CT      203/781-3335
1065    CHAPMAN         NEIL            NEW YORK         NY      718/384-5618
1876    CHIN            JACK            NEW YORK         NY      212/588-5634
1037    CHOW            JANE            STAMFORD         CT      203/781-8868
1129    COOK            BRENDA          NEW YORK         NY      718/383-2313
1988    COOPER          ANTHONY         NEW YORK         NY      212/587-1228
1405    DAVIDSON        JASON           PATERSON         NJ      201/732-2323
1430    DEAN            SANDRA          BRIDGEPORT       CT      203/675-1647
1983    DEAN            SHARON          NEW YORK         NY      718/384-1647
1134    DELGADO         MARIA           STAMFORD         CT      203/781-1528
1118    DENNIS          ROGER           NEW YORK         NY      718/383-1122
1438    DONALDSON       KAREN           STAMFORD         CT      203/781-2229
1125    DUNLAP          DONNA           NEW YORK         NY      718/383-2094
1475    EATON           ALICIA          NEW YORK         NY      718/383-2828
1117    EDGERTON        JOSHUA          NEW YORK         NY      212/588-1239
1935    FERNANDEZ       KATRINA         BRIDGEPORT       CT      203/675-2962
1124    FIELDS          DIANA           WHITE PLAINS     NY      914/455-2998
1422    FLETCHER        MARIE           PRINCETON        NJ      201/812-0902
1616    FLOWERS         ANNETTE         NEW YORK         NY      718/384-3329
1406    FOSTER          GERALD          BRIDGEPORT       CT      203/675-6363
1120    GARCIA          JACK            NEW YORK         NY      718/384-4930
1094    GOMEZ           ALAN            BRIDGEPORT       CT      203/675-7181
1389    GORDON          LEVI            NEW YORK         NY      718/384-9326
1905    GRAHAM          ALVIN           NEW YORK         NY      212/586-8815
1407    GRANT           DANIEL          MT. VERNON       NY      914/468-1616
1114    GREEN           JANICE          NEW YORK         NY      212/588-1092
1410    HARRIS          CHARLES         STAMFORD         CT      203/781-0937
1439    HARRISON        FELICIA         BRIDGEPORT       CT      203/675-4987
1409    HARTFORD        RAYMOND         STAMFORD         CT      203/781-9697
1408    HENDERSON       WILLIAM         PRINCETON        NJ      201/812-4789
1121    HERNANDEZ       MICHAEL         NEW YORK         NY      718/384-3313
1991    HOWARD          GRETCHEN        BRIDGEPORT       CT      203/675-0007
1102    HOWARD          LEONARD         WHITE PLAINS     NY      914/455-0976
1356    HOWARD          MICHAEL         NEW YORK         NY      212/586-8411
1545    HUNTER          CLYDE           STAMFORD         CT      203/781-1119
1292    HUNTER          HELEN           BRIDGEPORT       CT      203/675-4830
1440    JACKSON         LAURA           STAMFORD         CT      203/781-0088
1368    JEPSEN          RONALD          STAMFORD         CT      203/781-8413
1369    JOHNSON         ANTHONY         NEW YORK         NY      212/587-5385
1411    JOHNSON         JACKSON         PATERSON         NJ      201/732-3678
1113    JONES           LESLIE          NEW YORK         NY      718/383-3003
1704    JONES           NATHAN          NEW YORK         NY      718/384-0049
1900    KING            WILLIAM         NEW YORK         NY      718/383-3698
1126    KIRBY           ANNE            NEW YORK         NY      212/586-1229
1677    KRAMER          JACKSON         BRIDGEPORT       CT      203/675-7432
1441    LAWRENCE        KATHY           PRINCETON        NJ      201/812-3337
1421    LEE             RUSSELL         MT. VERNON       NY      914/468-9143
1119    LI              JEFF            NEW YORK         NY      212/586-2344
1834    LONG            RUSSELL         NEW YORK         NY      718/384-0040
1017    WELCH           DARIUS          NEW YORK         NY      212/586-5535
1443    WELLS           AGNES           STAMFORD         CT      203/781-5546
1131    WELLS           NADINE          NEW YORK         NY      718/383-1045
1427    WHALEY          CAROLYN         MT. VERNON       NY      914/468-4528
1036    WONG            LESLIE          NEW YORK         NY      212/587-2570
1130    WOOD            DEBORAH         NEW YORK         NY      212/587-0013
1127    WOOD            SANDRA          NEW YORK         NY      212/587-2881
1433    YANCEY          ROBIN           PRINCETON        NJ      201/812-1874
1431    YOUNG           DEBORAH         STAMFORD         CT      203/781-2987
1122    YOUNG           JOANN           NEW YORK         NY      718/384-2021
1105    YOUNG           LAWRENCE        NEW YORK         NY      718/384-0008
;
run;
*/