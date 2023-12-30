CREATE TABLE TAB_DEMO_TEST
(
ID INT PRIMARY KEY,
F_NAME VARCHAR2(25) NOT NULL,
DOB DATE,
EMAIL VARCHAR2(25),
JOB_DET VARCHAR2(25)
);

SELECT * FROM TAB_DEMO_TEST;

INSERT INTO TAB_DEMO_TEST VALUES(1,'CHETU',TO_DATE('12/05/2006','DD/MM/YYYY'),'ABCGMAIL.COM','ENGINEER');

INSERT INTO VW_TAB_DEMO_TEST VALUES(4,'somu',TO_DATE('12/05/2006','DD/MM/YYYY'),'ABCGMAIL.COM','ENGINEER');

ALTER TABLE TAB_DEMO_TEST
MODIFY JOB_DET VARCHAR2(7);

alter TABLE TAB_DEMO_TEST1
RENAME TO TAB_DEMO_TEST;

ALTER TABLE TAB_DEMO_TEST
RENAME COLUMN FIRST_NAME TO F_NAME;

ALTER TABLE TAB_DEMO_TEST
MODIFY F_NAME UNIQUE;

DELETE TAB_DEMO_TEST
WHERE ID=3;

DESC TAB_DEMO_TEST;

SELECT  column_name, data_type FROM  user_tab_columns where table_name = 'TAB_DEMO_TEST';

SELECT * FROM all_users;

CREATE VIEW VW_TAB_DEMO_TEST AS SELECT * FROM TAB_DEMO_TEST;

SELECT * FROM VW_TAB_DEMO_TEST;

DESC VW_TAB_DEMO_TEST;

DELETE VW_TAB_DEMO_TEST
WHERE ID=3;

UPDATE VW_TAB_DEMO_TEST
SET F_NAME='RAMESH'
WHERE ID=1;


DROP VIEW VW_TAB_DEMO_TEST;


ALTER TABLE TAB_DEMO_TEST
MODIFY ID INT;

CREATE TABLE TAB_DEMO_TEST
(
ID INT,
F_NAME VARCHAR2(25),
PH_NO INT,
EMAIL VARCHAR2(25),
DEPT_NO INT,
PRIMARY KEY(ID,PH_NO)
);

DESC TAB_DEMO_TEST;

ALTER TABLE tab_demo_test
ADD FOREIGN KEY (dept_no) REFERENCES demo_dept(dept_no); 

CREATE TABLE DEMO_DEPT
( 
DEPT_NO INT PRIMARY KEY,
DEPT_NAME VARCHAR2(25),
LOCATION VARCHAR2(25));

SELECT * FROM DEMO_DEPT;

INSERT INTO DEMO_DEPT VALUES(1,'CS','BANG');
INSERT INTO DEMO_DEPT VALUES(2,'IS','MYS');
INSERT INTO DEMO_DEPT VALUES(3,'CV','CHT');
INSERT INTO DEMO_DEPT VALUES(4,'EC','DVG');


INSERT INTO TAB_DEMO_TEST VALUES(1,'RAM',8459788,'CHER@GAMIL.COM',1);
INSERT INTO TAB_DEMO_TEST VALUES(2,'RAM',8459788,'CHER@GAMIL.COM',1);
INSERT INTO TAB_DEMO_TEST VALUES(3,'RAM',8459788,'CHER@GAMIL.COM',5);


alter table TAB_DEMO_TEST 
add DEPT_CODE NUMBER(10);


select * from all_constraints where owner='ETL7' and table_name='TAB_DEMO_TEST';


CREATE TABLE customer111
	(
	cust_id NUMBER(6) PRIMARY KEY,
	cust_name VARCHAR2(30) NOT NULL,
	mobile_no NUMBER(10) UNIQUE CHECK (LENGTH(mobile_no)=10),
	age NUMBER(3) CHECK (age>=18),
	city_id NUMBER(4) REFERENCES city(city_id) 
	);

SELECT COUNT(DISTINCT DEPARTMENT_ID) FROM DEPARTMENTS;


select sysdate from dual;

select current_date from dual;

select sysdate from employees;

SELECT systimestamp FROM dual;

select LPAD(RPAD('WELCOME',15,'*'),30,'*') from dual;




select TRIM('         Welcome      ') from dual;


