---1. PROBLEM = WRITE A QUERY TO SELECT THE ROWS THAT HAVE "A" IN ANY ONE OF THE COLUMNS WITHOUT USING 'OR' KEYWORDS.

CREATE TABLE PROB1
(
S_NO INT,
COL1 VARCHAR2(10),
COL2 VARCHAR2(10),
COL3 VARCHAR2(10),
COL4 VARCHAR2(10),
COL5 VARCHAR2(10)
);

INSERT INTO PROB1 VALUES('1','A','B','C','D','E');

INSERT INTO PROB1 VALUES('2','','A','B','C','D');

INSERT INTO PROB1 VALUES('3','E','','','','A');

INSERT INTO PROB1 VALUES('4','','A','E','','D');

INSERT INTO PROB1 VALUES('5','E','D','C','B','');


SELECT * FROM PROB1
WHERE COL1='A' 
      OR COL2='A' 
      OR COL3='A' 
      OR COL4='A'
      OR COL5='A';
---OR

SELECT * FROM PROB1 WHERE COL1='A' UNION ALL
SELECT * FROM PROB1 WHERE COL2='A' UNION ALL
SELECT * FROM PROB1 WHERE COL3='A' UNION ALL
SELECT * FROM PROB1 WHERE COL4='A' UNION ALL
SELECT * FROM PROB1 WHERE COL5='A';
---OR

SELECT * FROM PROB1 
WHERE 'A' IN (COL1,COL2,COL3,COL4,COL5);

SELECT * FROM PROB1;



------------------------------------------------------------------------------------------------------------------------------------------
---2.WRITE 'SQL' STATEMENT TO SELECT EMPLOYEES GETTING SALARY GREATER THAN AVERAGE SALARY OF THE DEPARTMENT THAT ARE WORKING IN.

--SOLUTION:2.1
---STEP 1:
SELECT department_id,TRUNC(AVG(salary)) avg_sal
                FROM hr.employees
                GROUP BY department_id;

---STEP 2 FINAL SOLUTION:
SELECT * 
FROM hr.employees a,(SELECT department_id,TRUNC(AVG(salary)) avg_sal
                FROM hr.employees
                GROUP BY department_id) b
                WHERE a.department_id=b.department_id
                AND a.salary > b.avg_sal;


--SOLUTION:2.2
SELECT * FROM hr.employees a
WHERE a.salary > (SELECT AVG(salary) FROM hr.employees b WHERE a.department_id= b.department_id);


--SOLUTION:2.3
--USING ANALYTICAL FUNCTION.
--STEP:1
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,SALARY,JOB_ID,DEPARTMENT_ID,
    TRUNC(AVG(salary) OVER(PARTITION BY DEPARTMENT_ID)) AVG_SAL
        FROM hr.employees;
        

--STEP:2 FINAL SOLUTION.
SELECT * FROM (
                SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,SALARY,JOB_ID,DEPARTMENT_ID,
                    TRUNC(AVG(salary) OVER(PARTITION BY DEPARTMENT_ID)) AVG_SAL
                         FROM hr.employees)
                            WHERE salary > AVG_SAL;



-----------------------------------------------------------------------------------------------------------------------------------------------
---3. WRITE SQL STATEMET TO SELECT DATA FROM "TAB1" THAT ARE NOT EXISTS IN "TAB2" WITHOUT USING "NOT" KEYWORD.

CREATE TABLE TAB1
(
C1 VARCHAR2(20)
);

INSERT ALL
INTO TAB1 VALUES('A')
INTO TAB1 VALUES('B')
INTO TAB1 VALUES('C')
INTO TAB1 VALUES('D')
INTO TAB1 VALUES('E')
SELECT * FROM DUAL;


CREATE TABLE TAB2
(
C1 VARCHAR2(20)
);

INSERT ALL
INTO TAB2 VALUES('A')
INTO TAB2 VALUES('C')
INTO TAB2 VALUES('E')
INTO TAB2 VALUES('G')
SELECT * FROM DUAL;



SELECT * FROM TAB1
MINUS
SELECT * FROM TAB2;
---OR

SELECT* FROM TAB1 WHERE C1 NOT IN (SELECT * FROM TAB2);
---OR

SELECT * FROM TAB1 WHERE NOT EXISTS (SELECT 1 FROM TAB2 WHERE TAB2.C1=TAB1.C1);
--OR

SELECT * FROM TAB1
WHERE 1 >(SELECT COUNT(*) FROM TAB2 WHERE TAB1.C1=TAB2.C1);
--OR

SELECT * FROM TAB1
LEFT OUTER JOIN TAB2 
ON TAB1.C1=TAB2.C1
WHERE TAB2.C1 IS NULL;
--OR

SELECT TAB1.C1,TAB2.C1
FROM TAB1
FULL OUTER JOIN TAB2
ON TAB1.C1=TAB2.C1
WHERE TAB2.C1 IS NULL;
--OR

SELECT C1 FROM TAB1
WHERE (SELECT COUNT(1) FROM TAB2 WHERE TAB2.C1=TAB1.C1) =0;

----------------------------------------------------------------------------------------------------------------------------------------------------------------

---4.WRITE SQL QUERY TO FIND OUT.
   --1.NUMBER OF MATCHES "PLAYED" BY EACH TEAM.
   --2.NUMBER OF MATCHES "WON" BY EACH TEAM.
   --3.NUMBER OF MATCHES "LOST" BY EACH TEAM.
CREATE TABLE cricket
(
MATCH_NO INT,
TEAM_A VARCHAR2(20),
TEAM_B VARCHAR2(20),
WINNER VARCHAR2(20)
);

INSERT ALL
INTO CRICKET VALUES(1,'WESTINDIES','SRILANKA','WESTINDIES')
INTO CRICKET VALUES(2,'INDIA','SRILANKA','INDIA')
INTO CRICKET VALUES(3,'AUSTRALIA','SRILANKA','AUSTRALIA')
INTO CRICKET VALUES(4,'WESTINDIES','SRILANKA','SRILANKA')
INTO CRICKET VALUES(5,'AUSTRALIA','INDIA','AUSTRALIA')
INTO CRICKET VALUES(6,'WESTINDIES','SRILANKA','WESTINDIES')
INTO CRICKET VALUES(7,'INDIA','WESTINDIES','WESTINDIES')
INTO CRICKET VALUES(8,'WESTINDIES','AUSTRALIA','AUSTRALIA')
INTO CRICKET VALUES(9,'WESTINDIES','INDIA','INDIA')
INTO CRICKET VALUES(10,'AUSTRALIA','WESTINDIES','WESTINDIES')
INTO CRICKET VALUES(11,'WESTINDIES','SRILANKA','WESTINDIES')
INTO CRICKET VALUES(12,'INDIA','AUSTRALIA','INDIA')
INTO CRICKET VALUES(13,'SRILANKA','NEWZZELAND','NEWZZELAND')
INTO CRICKET VALUES(14,'NEWZZELAND','INDIA','INDIA')
SELECT * FROM DUAL;


WITH MATCHES_PLAYED AS(
                        SELECT TEAM_NAME, COUNT(*) CNT FROM(
                                                            SELECT TEAM_A TEAM_NAME FROM CRICKET
                                                            UNION ALL
                                                            SELECT TEAM_B FROM CRICKET)
                                                            GROUP BY TEAM_NAME),

        MATCHES_WON AS(SELECT WINNER, COUNT(*) CNT
                        FROM CRICKET
                        GROUP BY WINNER)
SELECT TEAM_NAME, 
                MATCHES_PLAYED.CNT TOTAL_MATCHES, 
                NVL(MATCHES_WON.CNT,0) MATCHES_WON, 
                MATCHES_PLAYED.CNT - NVL(MATCHES_WON.CNT,0) MATCHES_LOST
                FROM MATCHES_PLAYED 
                FULL OUTER JOIN MATCHES_WON
                  ON  MATCHES_PLAYED.TEAM_NAME= MATCHES_WON.WINNER ;


WITH DT AS (
                SELECT TEAM_A TEAM_NAME, (CASE WHEN TEAM_A=WINNER THEN 1 ELSE 0 END) MATCHES_WON1
                FROM CRICKET
                UNION ALL
                SELECT TEAM_B TEAM_NAME, (CASE WHEN TEAM_B=WINNER THEN 1 ELSE 0 END) MATCHES_WON1
                FROM CRICKET)
SELECT TEAM_NAME,COUNT(*) MATCHES_PLAYED, SUM(MATCHES_WON1) MATCHES_WON, (COUNT(*)-SUM(MATCHES_WON1)) MATCHES_LOST FROM DT
GROUP BY TEAM_NAME;


------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- 5. WRITE A QUERY TO PRINT THE GIVEN INPUT STRING "WELLCOME" AS GIVEN BELOW OUTPUTS.

SELECT ROWNUM, 
            SUBSTR(S,ROWNUM,1) OUTPUT1,
            SUBSTR(S,ROWNUM*-1,1) OUTPUT2,
            SUBSTR(S,1,ROWNUM) OUTPUT3,
            SUBSTR(S,ROWNUM) OUTPUT4,
            RPAD(' ',ROWNUM,' ')||SUBSTR(S,ROWNUM) OUTPUT5,
            RPAD(' ',LENGTH(S)+1-ROWNUM,' ')||SUBSTR(S,1,ROWNUM) OUTPUT6
FROM DUAL,(SELECT 'WELCOME' S FROM DUAL)
CONNECT BY LEVEL <= LENGTH(S);

-------------------------------------------------------------------------------------------------------------------------------------------------------------

--- 6.WRITE A SQL QUERY TO EXTRACT "FIRST_NAME", "MIDDLE_NAME", "LAST_NAME" & "DOMAIN_NAME" FROM GIVEN EMAIL ID.

WITH D AS (SELECT 'SIVA.K.ACADEMY@GMAIL.COM' M 
FROM DUAL),
DS AS (SELECT SUBSTR(M,1,INSTR(M,'@')-1) N,
        SUBSTR(M,INSTR(M,'@')+1) D
FROM D)
SELECT SUBSTR(N,1,INSTR(N,'.',1,1)-1) FIRST_NME,
        SUBSTR(N,INSTR(N,'.',1,1)+1,INSTR(N,'.',1,2)-INSTR(N,'.',1,1)-1) MIDDLE_NME,
        SUBSTR(N,INSTR(N,'.',1,2)+1) LAST_NME ,   
        D DOMAIN_NAME
FROM DS;


WITH D AS (SELECT 'SIVA.K.ACADEMY@GMAIL.COM' M 
FROM DUAL),
DS AS (SELECT SUBSTR(M,1,INSTR(M,'@',1,1)-1) N,
        SUBSTR(M,INSTR(M,'@')+1) D
FROM D)
SELECT SUBSTR(N,1,INSTR(N,'.',1,1)-1) FIRST_NME,
        SUBSTR(N,INSTR(N,'.',1,1)+1,1) MIDDLE_NME,
        SUBSTR(N,INSTR(N,'.',1,2)+1) LAST_NME ,   
        D DOMAIN_NAME
FROM DS
;





---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---7.WRITE A SQL TO COMPUTE THE "GROUP_SALARY" OF ALL THE EMPLOYEES.(GROUP SALARY = SUM OF SALARY OF ALL EMPLOYEES REPORTING UNDER HIM INCLUDING HIS OWN SALARY).

CREATE TABLE EMP7
(
EMPNO INT,
ENAME VARCHAR2(20),
MGR NUMBER(10),
SAL NUMBER(10)
);


INSERT ALL
INTO EMP7 VALUES(7839,'KING','',1000)
INTO EMP7 VALUES(7698,'BLAKE','7839',700)
INTO EMP7 VALUES(7782,'CLARK','7839',500)
INTO EMP7 VALUES(7566,'JONES','7839',800)
INTO EMP7 VALUES(7788,'SCOTT','7566',200)
INTO EMP7 VALUES(7902,'FORD','7566',100)
INTO EMP7 VALUES(7369,'SMITH','7902',75)
INTO EMP7 VALUES(7499,'ALLEN','7698',100)
INTO EMP7 VALUES(7521,'WARD','7698',200)
INTO EMP7 VALUES(7654,'MARTIN','7698',150)
INTO EMP7 VALUES(7844,'TURNER','7698',150)
INTO EMP7 VALUES(7876,'ADAMS','7788',50)
INTO EMP7 VALUES(7900,'JAMES','7698',100)
INTO EMP7 VALUES(7934,'MILLER','7782',300)
SELECT * FROM DUAL;

--- STEP.1
SELECT EMPNO,ENAME,MGR,SAL,SYS_CONNECT_BY_PATH(ENAME, '--->')
FROM EMP7
START WITH ENAME='JONES'
CONNECT BY PRIOR EMPNO=MGR;

SELECT EMPNO,ENAME,MGR,SAL,SYS_CONNECT_BY_PATH(ENAME, '--->')
FROM EMP7
START WITH ENAME='KING'
CONNECT BY PRIOR EMPNO=MGR;


SELECT EMPNO,ENAME,MGR,SAL,SYS_CONNECT_BY_PATH(ENAME, '--->')
FROM EMP7
START WITH ENAME='BLAKE'
CONNECT BY PRIOR EMPNO=MGR;

---STEP.2
SELECT SUM(SAL)
FROM EMP7
START WITH ENAME='BLAKE'
CONNECT BY PRIOR EMPNO=MGR;---IT SUM OF ALL SLARY CONNECTED WITH "BLAKE" INCLUDING HIM ALSO.


SELECT SUM(SAL)
FROM EMP7
START WITH ENAME='KING'
CONNECT BY PRIOR EMPNO=MGR;---IT SUM OF ALL SLARY CONNECTED WITH "KING" INCLUDING HIM ALSO.


---FINAL ANS IS.

SELECT EMPNO, ENAME, MGR, SAL,
(SELECT SUM(SAL)
FROM EMP7
START WITH ENAME=A.ENAME
CONNECT BY PRIOR EMPNO=MGR) GROUP_SALARY
FROM EMP7 A;


------------------------------------------------------------------------------------------------------------------------------------------------------------------

----8. WRITE A QUERY TO PRINT THE RESULT STATUS CONTAINING "YEAR WISE","DEPT WISE" NUMBER OF STUDENTS PASSED(P)/ FAILED(F).
CREATE TABLE student (
    sno     NUMBER,
    name   VARCHAR2(30),
    mark   NUMBER,
    result varchar2(1),
 dept   varchar2(5),
 year     number
);

BEGIN
    FOR i IN 1..1000 LOOP
        INSERT INTO student (sno,name,mark,dept,year) 
        VALUES (i,'STUDENT_'|| i,trunc(dbms_random.value(1,100)),trunc(dbms_random.value(1,6)),trunc(dbms_random.value(1,5)));
    END LOOP;
    COMMIT;
END;
/

update student set result='P' 
where mark >=35;
update student set result='F' 
where mark <35;

update student set dept='CSE' where dept='1';
update student set dept='ECE' where dept='2';
update student set dept='EEE' where dept='3';
update student set dept='MECH' where dept='4';
update student set dept='CVE' where dept='5';

---SOLUTION:8.1
--STEP:1

SELECT dept,year,COUNT(result)
FROM student
GROUP BY dept,year
ORDER BY dept, year;

--STEP:2

SELECT dept,year,COUNT(result),
       'P ='|| COUNT(case when result='P' then result else null end) pass_count,
        'F ='|| COUNT(case when result='F' then result else null end) fail_count
FROM student
GROUP BY dept,year
ORDER BY dept, year;

--STEP:3

SELECT dept,year,COUNT(result),
       'P ='|| COUNT(case when result='P' then result else null end) ||
        ',F ='|| COUNT(case when result='F' then result else null end) cnt
FROM student
GROUP BY dept,year
ORDER BY dept, year;

--STEP:4

SELECT dept,year,cnt,
                    case when year =1 then cnt end y_I,
                    case when year =2 then cnt end y_II,
                    case when year =3 then cnt end y_III,
                    case when year =4 then cnt end y_IV
from(
SELECT dept,year,COUNT(result),
       'P ='|| COUNT(case when result='P' then result else null end) ||
        ',F ='|| COUNT(case when result='F' then result else null end) cnt
FROM student
GROUP BY dept,year
ORDER BY dept, year);

--STEP:5 IS FINAL SOLUTION.

SELECT dept,
                    MAX(case when year =1 then cnt end) y_I,
                    MAX(case when year =2 then cnt end) y_II,
                    MAX(case when year =3 then cnt end) y_III,
                    MAX(case when year =4 then cnt end) y_IV
from(
SELECT dept,year,
       'P ='|| COUNT(case when result='P' then result else null end) ||
        ',F ='|| COUNT(case when result='F' then result else null end) cnt
FROM student
GROUP BY dept,year
ORDER BY dept, year)
GROUP BY dept;



---SOLUTION:8.2

select * from (
select dept,
       'YEAR : '||year year,
       'P = '||count(decode(result,'P','P',null)) ||', F = '||count(decode(result,'F','F',null)) R_count
from student
group by dept,year)
PIVOT ( max ( R_count)
            FOR dept
            IN ( 'CSE' CSE,'ECE' ECE,'MECH' MECH,'EEE' EEE,'CVE' CVE)
        )
        order by year;


---SOLUTION:8.3

select * from (
select dept,
       year,
       'P = '||count(decode(result,'P','P',null)) ||', F = '||count(decode(result,'F','F',null)) R_count
from student
group by dept,year)
PIVOT ( max ( R_count)
            FOR year
            IN ( 1 as I,2 II,3 III,4 IV)
        );

---SOLUTION:8.4

select dept, max(case when year=1 then F_count end),
              max(case when year=2 then F_count end),
              max(case when year=3 then F_count end),
              max(case when year=4 then F_count end)
from (
select dept,year,'P = '||count(decode(result,'P','P',null)) ||', F = '||count(decode(result,'F','F',null)) F_count
from student
group by dept,year
order by 1,2)
group by dept;



------------------------------------------------------------------------------------------------------------------------------------------------------------
---- 9.WRITE SQL TO PRINT ALL THE POSSIBLE PATHS FOR THE GIVEN CITIES..
CREATE TABLE city
(
city_id int,
city_name varchar2(20)
);

INSERT ALL
INTO city VALUES(1,'DELHI')
INTO city VALUES(2,'CHENNAI')
INTO city VALUES(3,'MUMBAI')
INTO city VALUES(4,'KOLKATA')
SELECT * FROM DUAL;


---SOLUTION:9.1
--STEP:1
SELECT * 
FROM city a, city b;

--STEP:2 FINAL SOLUTION.
SELECT * 
FROM city a, city b
WHERE a.city_id < b.city_id;  --HERE WE CAN USE ">" ALSO BUT DATA WILL BECOME REVERSE ORDER IF WE USE ">".
--IN WHERE INSTED OF a.city_id AND b.city_id WE CAN ALSO USE a.city_name AND b.city_name.


---SOLUTION:9.2
--STEP:1
SELECT a.city_name,b.city_name
FROM city a, city b;

--STEP:2
SELECT a.city_name,b.city_name
FROM city a, city b
WHERE a.city_name <> b.city_name;

--STEP:3
SELECT a.city_name,b.city_name,
                greatest(a.city_name,b.city_name) city_1,
                least(a.city_name,b.city_name) city_2
FROM city a, city b
WHERE a.city_name <> b.city_name;


--STEP:4 FINAL SOLUTION.
SELECT --a.city_name,b.city_name,
        DISTINCT greatest(a.city_name,b.city_name) city_1,
         least(a.city_name,b.city_name) city_2
FROM city a, city b
WHERE a.city_name <> b.city_name;




----------------------------------------------------------------------------------------------------------------------------------------------------------
---- 10.WRITE SQL TO LIST "NO OF EMPLOYEES" AND "NAME OF EMPLOYEES" REPORTING TO EACH PERSON.

---SOLUTION:10.1
--STEP:1
SELECT empno,ename,mgr
FROM emp7;

SELECT mgr,ename
FROM emp7
ORDER BY mgr;

--STEP:2
SELECT empno,ename,mgr
FROM emp7;

          SELECT mgr, 
            LISTAGG(ename,',') within group (order by MGR) names_of_rep,
             COUNT(*) no_of_rep
             FROM emp7
              GROUP BY mgr;

--STEP:3
SELECT empno,ename,emp7.mgr
FROM emp7,
            (SELECT mgr, 
                LISTAGG(ename,',') within group (order by mgr) names_of_rep,
                    COUNT(*) no_of_rep
                        FROM emp7
                         GROUP BY mgr) r
                             WHERE emp7.empno=r.mgr;

--STEP:4 FINAL SOLUTION.
SELECT empno,ename,names_of_rep,nvl(no_of_rep,0)
FROM emp7,
            (SELECT mgr, 
                 LISTAGG(ename,',') within group (order by mgr) names_of_rep,
                     COUNT(*) no_of_rep
                         FROM emp7
                            GROUP BY mgr) r
                                WHERE emp7.empno=r.mgr(+);

---SOLUTION:10.2
--STEP:1
SELECT empno,ename,mgr
FROM emp7 e;

SELECT LISTAGG(ename,',') within group(order by mgr)
FROM emp7
WHERE mgr=7566;


--STEP:2
SELECT empno,ename,(SELECT LISTAGG(ename,',') within group(order by mgr)
FROM emp7
WHERE mgr=e.empno)
FROM emp7 e;

--STEP:3 FINAL SOLUTION.
SELECT empno,ename,(SELECT LISTAGG(ename,',') within group(order by mgr)
FROM emp7
WHERE mgr=e.empno) names_of_rep,
(SELECT COUNT(*)
FROM emp7
WHERE mgr=e.empno) no_of_rep
FROM emp7 e;


---SOLUTION:10.3
--STEP:1
SELECT m.empno,m.ename,e.ename
FROM emp7 m,emp7 e
WHERE m.empno= e.mgr(+)
ORDER BY m.empno;

--STEP:2
SELECT m.empno,m.ename,
                        LISTAGG(e.ename,',') within group(order by m.empno) names_of_rep,
                       count(e.ename) no_of_rep
                        FROM emp7 m,emp7 e
                        WHERE m.empno= e.mgr(+)
                        GROUP BY m.empno,m.ename
                        ORDER BY m.empno;
                        
                        
--------------------------------------------------------------------------------------------------------------------------------------------------------------
---11.WRITE QUERY TO REPLACE THE "COMMA SEPARATED CODES" WITH IT'S RESPECTIVE DESCRIPTION.
CREATE TABLE service
(
service_code varchar2(60),
service_name varchar2(60)
);

INSERT ALL
INTO service VALUES('A','Service-A')
INTO service VALUES('B','Service-B')
INTO service VALUES('C','Service-C')
INTO service VALUES('D','Service-D')
SELECT * FROM DUAL;

SELECT * FROM service;

CREATE TABLE product_service
(
product_code varchar2(60),
product_desc varchar2(60),
service_order varchar2(60)
);

INSERT ALL
INTO  product_service VALUES('P1','PROD-P1','A,C')
INTO  product_service VALUES('P2','PROD-P2','C,B,D')
INTO  product_service VALUES('P3','PROD-P3','D,A,C,B')
INTO  product_service VALUES('P4','PROD-P4','A,B,C,D')
INTO  product_service VALUES('P5','PROD-P4','D,C,B,A,B')
SELECT * FROM DUAL;

STEP:1.
SELECT * FROM service;

SELECT PRODUCT_CODE, PRODUCT_DESC, SERVICE_ORDER 
FROM product_service,
        lateral(select level from daul connect by level <= regexp_count(SERVICE_ORDER,',')+1);


select * from v$version;




------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----12.WRITE A SQL QUERY TO GENERATE ALL THE DATE RANGE FOR THE TRANSACTION RECORDS GIVEN BELOW.

CREATE TABLE daily_tran_t
(
tran_date DATE,
tran_desc VARCHAR2(20),
tran_amount number(20)
);


INSERT ALL
INTO daily_tran_t VALUES(TO_DATE('05-MAY-19','DD/MON/YYYY'),'Bill Payment',1000)
INTO daily_tran_t VALUES(TO_DATE('07-MAY-19','DD/MON/YYYY'),'Deposit',5000)
INTO daily_tran_t VALUES(TO_DATE('09-MAY-19','DD/MON/YYYY'),'Fees Payment',2500)
INTO daily_tran_t VALUES(TO_DATE('12-MAY-19','DD/MON/YYYY'),'Bonus Receieved',3400)
INTO daily_tran_t VALUES(TO_DATE('13-MAY-19','DD/MON/YYYY'),'Bonus Receieved',3400)
SELECT * FROM DUAL;

SELECT * FROM daily_tran_t;


STEP:1
SELECT MIN(TRAN_DATE), MAX(TRAN_DATE)
FROM daily_tran_t;

STEP:2
SELECT MIN(TRAN_DATE), MAX(TRAN_DATE),
        TRUNC(MIN(TRAN_DATE),'MONTH') first_day,
        LAST_DAY(MAX(TRAN_DATE)) last_day
FROM daily_tran_t;

STEP:3
SELECT TRUNC(MIN(TRAN_DATE),'MONTH') first_day,--REMOVED MAX AND MIN COLUMNS.
        LAST_DAY(MAX(TRAN_DATE)) last_day,
        LAST_DAY(MAX(TRAN_DATE))- TRUNC(MIN(TRAN_DATE),'MONTH')+1 no_of_days --+1 BECAUSE IT GIVES ONLY NUMBER OF DAYS BETWEEN.
FROM daily_tran_t;

STEP:4
WITH d AS (
SELECT TRUNC(MIN(TRAN_DATE),'MONTH') first_day,
        LAST_DAY(MAX(TRAN_DATE))- TRUNC(MIN(TRAN_DATE),'MONTH')+1 no_of_days 
FROM daily_tran_t)
SELECT * FROM d;

STEP:5
WITH d AS (
SELECT TRUNC(MIN(TRAN_DATE),'MONTH') first_day,
        LAST_DAY(MAX(TRAN_DATE))- TRUNC(MIN(TRAN_DATE),'MONTH')+1 no_of_days 
FROM daily_tran_t)
SELECT * 
FROM d
CONNECT BY LEVEL <= no_of_days;

STEP:6
WITH d AS (
SELECT TRUNC(MIN(TRAN_DATE),'MONTH') first_day,
        LAST_DAY(MAX(TRAN_DATE))- TRUNC(MIN(TRAN_DATE),'MONTH')+1 no_of_days 
FROM daily_tran_t)
SELECT first_day + LEVEL 
FROM d
CONNECT BY LEVEL <= no_of_days;

STEP:6
WITH d AS (
SELECT TRUNC(MIN(TRAN_DATE),'MONTH') first_day,
        LAST_DAY(MAX(TRAN_DATE))- TRUNC(MIN(TRAN_DATE),'MONTH')+1 no_of_days 
FROM daily_tran_t)
SELECT first_day + LEVEL -1--TO SHOW STARTING FROM 01-05-19 DATE.
FROM d
CONNECT BY LEVEL <= no_of_days;

STEP:6
WITH d AS (
SELECT TRUNC(MIN(TRAN_DATE),'MONTH') first_day,
        LAST_DAY(MAX(TRAN_DATE))- TRUNC(MIN(TRAN_DATE),'MONTH')+1 no_of_days 
FROM daily_tran_t),
cd AS (SELECT first_day + LEVEL -1 t_date--TO SHOW STARTING FROM 01-05-19 DATE.
FROM d
CONNECT BY LEVEL <= no_of_days)
SELECT *
FROM cd;

STEP:7
WITH d AS (
            SELECT TRUNC(MIN(TRAN_DATE),'MONTH') first_day,
                 LAST_DAY(MAX(TRAN_DATE))- TRUNC(MIN(TRAN_DATE),'MONTH')+1 no_of_days 
                    FROM daily_tran_t),
    cd AS (SELECT first_day + LEVEL -1 t_date--TO SHOW STARTING FROM 01-05-19 DATE.
        FROM d
            CONNECT BY LEVEL <= no_of_days)
SELECT *
FROM cd,daily_tran_t
WHERE cd.t_date=daily_tran_t.tran_date;

STEP:8
WITH d AS (
            SELECT TRUNC(MIN(TRAN_DATE),'MONTH') first_day,
                 LAST_DAY(MAX(TRAN_DATE))- TRUNC(MIN(TRAN_DATE),'MONTH')+1 no_of_days 
                    FROM daily_tran_t),
    cd AS (SELECT first_day + LEVEL -1 t_date--TO SHOW STARTING FROM 01-05-19 DATE.
        FROM d
            CONNECT BY LEVEL <= no_of_days)
SELECT *
FROM cd,daily_tran_t
WHERE cd.t_date=daily_tran_t.tran_date(+)--WE CAN USE LEFT OUTER JOIN OR (+).
ORDER BY cd.t_date;

STEP:9
WITH d AS (
            SELECT TRUNC(MIN(TRAN_DATE),'MONTH') first_day,
                 LAST_DAY(MAX(TRAN_DATE))- TRUNC(MIN(TRAN_DATE),'MONTH')+1 no_of_days 
                    FROM daily_tran_t),
    cd AS (SELECT first_day + LEVEL -1 t_date--TO SHOW STARTING FROM 01-05-19 DATE.
        FROM d
            CONNECT BY LEVEL <= no_of_days)
SELECT t_date,tran_desc,NVL(tran_amount,0) tran_amount
FROM cd,daily_tran_t
WHERE cd.t_date=daily_tran_t.tran_date(+)--WE CAN USE LEFT OUTER JOIN OR (+).
ORDER BY t_date;

--TO CHECK WEATHER IT WORKS PROPERLY OR NOT INSERT ANOTHER RECORD,
INSERT INTO daily_tran_t VALUES(TO_DATE('10/JAN/19','DD/MON/YYYY'),'TEST_DESC',5000);
--RUN ONCE AGAIN ABOVE QUERY SEE RESULT STARTS FROM JANUARY MONTH TO MAY.

--TO CHECK WEATHER IT WORKS PROPERLY OR NOT INSERT ANOTHER RECORD,

INSERT INTO daily_tran_t VALUES(TO_DATE('25/DEC/19','DD/MON/YYYY'),'BILL_PAYMENT',10000);

--RUN ONCE AGAIN ABOVE QUERY SEE RESULT STARTS FROM JANUARY MONTH TO MAY.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------13. WRITE A SQL TO FIND THE NUMBER OF "SATURDAY" AND "SUNDAY" IN CURRENT MONTH
STEP:1 (SOLVED BY CHETHAN)
SELECT SYSDATE, TRUNC(SYSDATE,'MONTH'), LAST_DAY(SYSDATE) FROM DUAL;

STEP:2
SELECT SYSDATE, TRUNC(SYSDATE,'MONTH'), LAST_DAY(SYSDATE),
        TRUNC(LAST_DAY(SYSDATE) - TRUNC(SYSDATE,'MONTH')+1)
FROM DUAL
CONNECT BY LEVEL <= TRUNC(LAST_DAY(SYSDATE) - TRUNC(SYSDATE,'MONTH')+1);

STEP:3
SELECT TRUNC(SYSDATE,'MONTH')+LEVEL
FROM DUAL
CONNECT BY LEVEL <= TRUNC(LAST_DAY(SYSDATE) - TRUNC(SYSDATE,'MONTH')+1);


STEP:4
SELECT TO_CHAR(TRUNC(SYSDATE,'MONTH')+ (LEVEL-1),'DAY') DAYS ,COUNT(*) NO_DAYS  --"-1" TO GET DATE FROM "01-02-22"
FROM DUAL
CONNECT BY LEVEL <= TRUNC(LAST_DAY(SYSDATE) - TRUNC(SYSDATE,'MONTH')+1)
GROUP BY  TO_CHAR(TRUNC(SYSDATE,'MONTH')+ (LEVEL-1),'DAY')
HAVING TO_CHAR(TRUNC(SYSDATE,'MONTH')+ (LEVEL-1),'DAY') IN('SUNDAY   ','SATURDAY ');






----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----14.WRITE A SQL TO FIND THE NUMBER OF "SATURDAY" AND "SUNDAY" IN BETWEEN "12/6/2022" OT "18/12/2022".

with dt as(select 





--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------15. Find the number of rows for INNER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN  table below.

SELECT * FROM tablea;

SELECT * FROM tableb;

SELECT COUNT(*) FROM tablea A
INNER JOIN tableb b
ON A.ID=b.ID;

SELECT COUNT(*) FROM tablea A
LEFT JOIN tableb b
ON A.ID=b.ID;

SELECT COUNT(*) FROM tablea A
RIGHT JOIN tableb b
ON A.ID=b.ID;

SELECT COUNT(*) FROM tablea A
FULL OUTER JOIN tableb b
ON A.ID=b.ID;

--------------------------------------------------------------------------------------------------------------------------------------
---16. FIND THE AVERAGE SALARY UNDER EACH MANAGERS.

CREATE TABLE employee1
(emp_id NUMBER(10),
emp_name VARCHAR2(20),
salary NUMBER(10),
manager_id NUMBER(10)
);


SELECT e1.emp_id,e1.EMP_NAME, AVG(e2.salary)  FROM employee1 e1
INNER JOIN employee1 e2
ON e1.EMP_ID=e2.MANAGER_ID
GROUP BY e1.emp_id,e1.EMP_NAME ;


--------------------------------------------------------------------------------------------------------
---17. Sum of all positive values and negative values.
CREATE TABLE exampe1
(c1 NUMBER(5));

SELECT * FROM exampe1;

SELECT SUM(c1) total_sum FROM (
SELECT c1, CASE WHEN c1>0 THEN 1 ELSE 2 END AS summation  FROM exampe1)
WHERE summation = 1
UNION ALL
SELECT SUM(c1) negative_sum FROM (
SELECT c1, CASE WHEN c1>0 THEN 1 ELSE 2 END AS summation  FROM exampe1)
WHERE summation=2;

----OR

SELECT SUM(c1) FROM (
SELECT c1, CASE WHEN c1>0 THEN 1 ELSE 2 END AS summation  FROM exampe1)
GROUP BY summation;

-----------------------------------------------------------------------------------------------------
---18.Find the employees whose salary increases every year
CREATE TABLE example1
( employee_id NUMBER(5),
salary NUMBER(10),
YEAR NUMBER(5) );


SELECT employee_id FROM(
SELECT employee_id, salary, YEAR, LEAD(salary) OVER(PARTITION BY employee_id ORDER BY YEAR)  salary1
 FROM example1)
 GROUP BY employee_id,CASE WHEN (salary1- salary) >0 THEN 1 ELSE NULL END
 HAVING COUNT(CASE WHEN (salary1- salary) >0 THEN 1 ELSE NULL END)>1;


-------------------------------------------------------------------------------------------------------------------------------
---19. Find the USER_ID, USER_NAME, TRAINING_ID, TRAINING_DATE AND COUNT WHO TOOK TRAINING(TRAINING_ID) MORE THAN ONCE IN A SAME DATE.

CREATE TABLE user1
(user_id NUMBER(5),
user_name VARCHAR2(25) );

SELECT * FROM user1;

CREATE TABLE training_details
(user_training_id NUMBER(5),
user_id NUMBER(5),
training_id NUMBER(5),
training_date DATE );

SELECT * FROM training_details;

SELECT u.user_id, u.user_name,T.training_id, to_char(T.training_date,'Month, dd, yyyy hh:mi:ss'), 
COUNT(*) COUNT FROM user1 u
INNER JOIN training_details T
ON u.user_id = T.user_id
GROUP BY  u.user_id, u.user_name,T.training_id, T.training_date
HAVING COUNT(*)>1;








SELECT * FROM hr.employees;
COMMIT;