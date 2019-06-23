libname sasadv '/folders/myfolders/sasadv';
/* Lecture 10 */
/*******************************************
*******************************************
*******************************************
**********************
*********************/


/*10.1 Except
从staffchanges中, 找到新加入的员工*/
/*Sasuser.staffmaster lists information for all existing employees*/
/*Sasuser.staffchanges list information for all new employees and existing employees who have had a change in salary of job code*/
/*Use firstname, lastname*/
proc sql;
select firstname, lastname from Sasadv.staffchanges
except
select firstname, lastname from Sasadv.staffmaster;
quit;

/*10.2 Intersect*/

proc sql;
select firstname, lastname
from sasadv.staffchanges
intersect
select firstname, lastname
from sasadv.staffmaster
;
quit;

/*10.3 union*/

proc sql;
select firstname, lastname
from sasadv.staffchanges
union
select firstname, lastname
from sasadv.staffmaster
;
quit;


/*10.4 outer union*/
/*without corr*/
proc sql;
select firstname, lastname
from sasadv.staffchanges
outer union
select firstname, lastname
from sasadv.staffmaster
;
quit;

/*with corr*/
proc sql;
select firstname, lastname
from sasadv.staffchanges
outer union corr
select firstname, lastname
from sasadv.staffmaster
;
quit;


/*practice: 从staffchanges中, 找到新加入的员工
based on real example: use what you have learned from Lecture7 to solve this*/
/*Hint: use WHERE, NOT IN, DISTINCT, SUBQUERY*/
proc sql;
select firstname, lastname
from sasadv.staffchanges
where 
firstname not in (select distinct firstname from sasadv.staffmaster)
or lastname not in (select distinct lastname from sasadv.staffmaster);




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
libname sasadv '/folders/myfolders/sasadv';
data sasadv.staffchanges;
   input EmpID $ 1-4 LastName $ 9-23 FirstName $ 25-39
         City $ 41-55 State $ 57-58 PhoneNumber $ 65-76;
datalines;
1639    CARTER          KAREN           STAMFORD        CT      203/781-8839
1065    CHAPMAN         NEIL            NEW YORK        NY      718/384-5618
1561    SANDERS         RAYMOND         NEW YORK        NY      212/588-6615
1221    WALTERS         DIANE           NEW YORK        NY      718/384-1918
1447    BRIDESTON       AMY             NEW YORK        NY      718/384-1213
1998    POWELL          JIM             NEW YORK        NY      718/384-8642
;
run;
data sasadv.staffmaster;
   input EmpID $ 1-4 LastName $ 9-23 FirstName $ 25-39
         City $ 41-55 State $ 58-59 PhoneNumber $ 66-77;
datalines;
1447    BR              AMY             NEW YORK         NY      718/384-1213
1919    ADAMS           GERALD          STAMFORD         CT      203/781-1255
1653    ALEXANDER       SUSAN           BRIDGEPORT       CT      203/675-7715
1400    APPLE           TROY            NEW YORK         NY      212/586-0808
1350    ARTHUR          BARBARA         NEW YORK         NY      718/383-1549
1401    AVERY           JERRY           PATERSON         NJ      201/732-8787
1499    BAREFOOT        JOSEPH          PRINCETON        NJ      201/812-5665
1101    BAUCOM          WALTER          NEW YORK         NY      212/586-8060
1333    BLAIR           JUSTIN          STAMFORD         CT      203/781-1777
1402    BLALOCK         RALPH           NEW YORK         NY      718/384-2849
1479    BOSTIC          MARIE           NEW YORK         NY      718/384-8816
1403    BOWDEN          EARL            BRIDGEPORT       CT      203/675-3434
1739    BOYCE           JONATHAN        NEW YORK         NY      212/587-1247
1658    BRADLEY         JEREMY          NEW YORK         NY      212/587-3622
1428    BRADY           CHRISTINE       STAMFORD         CT      203/781-1212
1782    BROWN           JASON           STAMFORD         CT      203/781-0019
1244    BRYANT          LEONARD         NEW YORK         NY      718/383-3334
1383    BURNETTE        THOMAS          NEW YORK         NY      718/384-3569
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
1777    LUFKIN          ROY             NEW YORK         NY      718/383-4413
1663    MARKS           JOHN            NEW YORK         NY      212/587-7742
1106    MARSHBURN       JASPER          STAMFORD         CT      203/781-1457
1103    MCDANIEL        RONDA           NEW YORK         NY      212/586-0013
1477    MEYERS          PRESTON         BRIDGEPORT       CT      203/675-8125
1476    MONROE          JOYCE           STAMFORD         CT      203/781-2837
1379    MORGAN          ALFRED          STAMFORD         CT      203/781-2216
1104    MORGAN          CHRISTOPHER     NEW YORK         NY      718/383-9740
1009    MORGAN          GEORGE          NEW YORK         NY      212/586-7753
1412    MURPHEY         JOHN            PRINCETON        NJ      201/812-4414
1115    MURPHY          ALICE           NEW YORK         NY      718/384-1982
1128    NELSON          FELICIA         BRIDGEPORT       CT      203/675-1166
1442    NEWKIRK         SANDRA          PRINCETON        NJ      201/812-3331
1417    NEWKIRK         WILLIAM         PATERSON         NJ      201/732-6611
1478    NEWTON          JAMES           NEW YORK         NY      212/587-5549
1673    NICHOLLS        HENRY           STAMFORD         CT      203/781-7770
1839    NORRIS          DIANE           NEW YORK         NY      718/384-1767
1347    O'NEAL          BRYAN           NEW YORK         NY      718/384-0230
1423    OSWALD          LESLIE          MT. VERNON       NY      914/468-9171
1200    OVERMAN         MICHELLE        STAMFORD         CT      203/781-1835
1970    PARKER          ANNE            NEW YORK         NY      718/383-3895
1521    PARKER          JAY             NEW YORK         NY      212/587-7603
1354    PARKER          MARY            WHITE PLAINS     NY      914/455-2337
1424    PATTERSON       RENEE           NEW YORK         NY      212/587-8991
1132    PEARCE          CAROL           NEW YORK         NY      718/384-1986
1845    PEARSON         JAMES           NEW YORK         NY      718/384-2311
1556    PENNINGTON      MICHAEL         NEW YORK         NY      718/383-5681
1413    PETERS          RANDALL         PRINCETON        NJ      201/812-2478
1123    PETERSON        SUZANNE         NEW YORK         NY      718/383-0077
1907    PHELPS          WILLIAM         STAMFORD         CT      203/781-1118
1436    PORTER          SUSAN           NEW YORK         NY      718/383-5777
1385    RAYNOR          MILTON          BRIDGEPORT       CT      203/675-2846
1432    REED            MARILYN         MT. VERNON       NY      914/468-5454
1111    RHODES          JEREMY          PRINCETON        NJ      201/812-1837
1116    RICHARDS        CASEY           NEW YORK         NY      212/587-1224
1352    RIVERS          SIMON           NEW YORK         NY      718/383-3345
1555    RODRIGUEZ       JULIA           BRIDGEPORT       CT      203/675-2401
1038    RODRIGUEZ       MARIA           BRIDGEPORT       CT      203/675-2048
1420    ROUSE           JEREMY          PATERSON         NJ      201/732-9834
1561    SANDERS         RAYMOND         NEW YORK         NY      212/588-6615
1434    SANDERSON       EDITH           STAMFORD         CT      203/781-1333
1414    SANDERSON       NATHAN          BRIDGEPORT       CT      203/675-1715
1112    SAYERS          RANDY           NEW YORK         NY      718/384-4895
1390    SMART           JONATHAN        NEW YORK         NY      718/383-1141
1332    STEPHENSON      ADAM            BRIDGEPORT       CT      203/675-1497
1890    STEPHENSON      ROBERT          NEW YORK         NY      718/384-9874
1429    THOMPSON        ALICE           STAMFORD         CT      203/781-3857
1107    THOMPSON        WAYNE           NEW YORK         NY      718/384-3785
1908    TRENTON         MELISSA         NEW YORK         NY      212/586-6262
1830    TRIPP           KATHY           BRIDGEPORT       CT      203/675-2479
1882    TUCKER          ALAN            NEW YORK         NY      718/384-0216
1050    TUTTLE          THOMAS          WHITE PLAINS     NY      914/455-2119
1425    UNDERWOOD       JENNY           STAMFORD         CT      203/781-0978
1928    UPCHURCH        LARRY           WHITE PLAINS     NY      914/455-5009
1480    UPDIKE          THERESA         NEW YORK         NY      212/587-8729
1100    VANDEUSEN       RICHARD         NEW YORK         NY      212/586-2531
1995    VARNER          ELIZABETH       NEW YORK         NY      718/384-7113
1135    VEGA            ANNA            NEW YORK         NY      718/384-5913
1415    VEGA            FRANKLIN        NEW YORK         NY      718/384-2823
1076    VENTER          RANDALL         NEW YORK         NY      718/383-2321
1426    VICK            THERESA         PRINCETON        NJ      201/812-2424
1564    WALTERS         ANNE            NEW YORK         NY      212/587-3257
1221    WALTERS         DIANE           NEW YORK         NY      718/384-1918
1133    WANG            CHIN            NEW YORK         NY      212/587-1956
1435    WARD            ELAINE          NEW YORK         NY      718/383-4987
1418    WATSON          BERNARD         NEW YORK         NY      718/383-1298
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
run;*/