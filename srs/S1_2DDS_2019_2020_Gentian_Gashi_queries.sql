prompt     BreezeCo Queries Script	
prompt     Created 10/10/2019
prompt     Author: Gentian Gashi
--
SET LINESIZE 200;
/*-----------------------------------------------------------
Task 1.3.1 Code DONE
-----------------------------------------------------------*/
SELECT Cast(u."Username" AS VARCHAR2(20)) AS "Username", 
       Cast(u."LastName" AS VARCHAR2(15)) AS "LastName", 
       u."JoinDate", 
       c."CountryName" 
FROM   BR_USER u 
       join BR_COUNTRY c 
         ON u."CountryId" = c."CountryId" 
WHERE  u."JoinDate" > DATE '2017-01-01' 
ORDER  BY u."JoinDate" ASC; 
/*-----------------------------------------------------------
Task 1.3.2 Code DONE
----------------------------------------------------------- */
SELECT Cast(a."AppName" AS VARCHAR2(30)) AS "AppName", 
       ac."CategoryName", 
       Count(*)                          AS "num_users" 
FROM   BR_APP a 
       join BR_APPCATEGORY ac 
         ON a."AppCategoryId" = ac."AppCategoryId" 
       join BR_APPUSER au 
         ON a."AppId" = au."AppId" 
GROUP  BY a."AppName", 
          ac."CategoryName" 
ORDER  BY "num_users" DESC; 
/*-----------------------------------------------------------
Task 1.3.3 Code DONE
-----------------------------------------------------------*/
SELECT Cast("AppName" AS VARCHAR2(30))           AS "AppName", 
       "ApprovedForRelease", 
       ( Trunc(SYSDATE) - Trunc("LastUpdated") ) AS "DaySinceUpdated" 
FROM   BR_APP 
WHERE  "ApprovedForRelease" = 'Y'; 
/*-----------------------------------------------------------
Task 1.3.4 Code DONE
-----------------------------------------------------------*/
SELECT DISTINCT
   u."UserId",
   Cast(u."Username" AS VARCHAR2(20)) AS "Username",
   Cast(u."FirstName" AS VARCHAR2(15)) AS "FirstName",
   Cast(u."LastName" AS VARCHAR2(15)) AS "LastName",
   Cast(u."Email" AS VARCHAR2(30)) AS "Email",
   u."Gender",
   u."JoinDate",
   Trunc(u."DateOfBirth") AS "DateOfBirth",
   u."CountryId" 
FROM
   BR_USER u 
   inner join
      BR_APPUSER au 
      ON u."UserId" = au."UserId" 
   inner join
      BR_APP a 
      ON au."AppId" = a."AppId" 
   inner join
      BR_APPCATEGORY ac 
      ON ac."AppCategoryId" = a."AppCategoryId" 
WHERE
   "DateOfBirth" < Add_months(SYSDATE, - 13 * 12) 
   AND ac."CategoryName" = 'Social' 
ORDER BY
   "DateOfBirth" ASC;
