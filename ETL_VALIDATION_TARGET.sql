---1.	Metadata Testing.

------a). Table name check.
SELECT * FROM TAB WHERE tname = 'EMPLOYEES1';   ----TABLE PRESENT AS PER MAPPING SHEET.

----b). Column number count check ---> Check for number of columns in a table.
---- CHECK FOR AUDIT COLUMNS PRESENT OR NOT.
SELECT COUNT(*)  FROM user_tab_columns WHERE table_name='EMPLOYEES1';       --- 11 COLUMNS PRESENT AS PER MAPPING SHEET.

------c). Column name check.
SELECT  column_name FROM  user_tab_columns where table_name = 'EMPLOYEES1';  ---ALL COLUMN NAME ARE PRESENT AS PER MAPPING SHEET.


-----d). Column length 
-- --Data length in target should be as per mapping sheet and equal or grater than source Data length.
SELECT  column_name, data_length,data_precision,nullable FROM  user_tab_columns WHERE table_name = 'EMPLOYEES1'; ---ALL COLUMN LENGTH PRESENT AS PER MAPPING SHEET.


------e). Column Datatypes --- Number(), Varchar2(), Char(), Integer(), Date.
SELECT  column_name, data_type FROM  user_tab_columns where table_name = 'EMPLOYEES1';  ---ALL COLUMN DATATYPES ARE PRESENT AS PER MAPPING SHEET. 


-----f). Column Constraints --- Primary key,Unique, Check constraint, Forigen key,Default constraint, Not Null.
SELECT column_name,constraint_name FROM user_cons_columns WHERE table_name = 'EMPLOYEES1';  
					
SELECT constraint_name,constraint_type,search_condition FROM all_constraints WHERE OWNER='ETL7' AND table_name='EMPLOYEES1'; ---ONLY CHECK CONSTRAINTS ARE PRESENT.



----g). Column Index.
					
SELECT * FROM USER_INDEXES WHERE table_name = 'EMPLOYEES1';  ---NO INDEXS ARE PRESENT.

SELECT * FROM USER_IND_COLUMNS WHERE table_name = 'EMPLOYEES1';  ---NO INDEXS ARE PRESENT.

SELECT * FROM USER_IND_STATISTICS WHERE table_name = 'EMPLOYEES1';  ---NO INDEXS ARE PRESENT.

SELECT * FROM USER_IND_EXPRESSIONS WHERE table_name = 'EMPLOYEES1';  ---NO INDEXS ARE PRESENT.



----2.	Data Testing.
---a). Count Validation.
					
SELECT COUNT(*) FROM employees1;  ---112 RECORDS PRESENT.

SELECT COUNT(*) FROM HR.employees;  ---107 RECORDS PRESENT.

---b)	The count returned by Intersect should match with the individual counts of source and target tables.
	
 select count(*) from (   					
                        select * from hr.employees
                        INTERSECT
                        select * from employees1);  ----104 rows
---HERE IN SOURCE 107 RECORDS PRESENT AND INTERSECTION HAS 104 RECORDS, IT  MEANS IN SOURCE 3 EXTRA RECORDS PRESENT.
--- HERE IN TARGET 112 RECORDS PRESENT AND INTERSECTION HAS 104 RECORDS IT MEANS IN TARGET 8 ETRA RECORDS PRESENT.

/*5).  If the minus query returns no rows and the count intersect is less than the source count or the target table count, then the table holds 
duplicate rows.*/
					


---C). Checksum check.
---TAKE NUMERICAL COLUMNS AND PERFORM AGGREGATION AND COMPARE SOURCE AND TARGET.
select avg(salary),max(salary),min(salary) from employees1;  ---avg salary is changed.

select avg(salary),max(salary),min(salary) from hr.employees;  ---avg salary is changed.
				



----3.	Mapping Level Validation.
--- Perform Source query minus Target and vise versa. (Source – Target) U (Target – Source)
						
--- Source – Target.
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id FROM hr.employees
Minus
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id FROM employees1;
--- we found 3 rows are present in source which are not loaded to target
	
    					
--- Target – Source.
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id FROM employees1
Minus
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id FROM hr.employees;
---- we found 8 rows in source table which are present extra in target table.


---COLUMN-1  FOR employee_id.						
SELECT employee_id FROM hr.employees
MINUS
SELECT employee_id FROM employees1;  ---NULL

SELECT employee_id FROM employees1
MINUS
SELECT employee_id FROM hr.employees; ---WE FOUND 5 ROWS PRESENT IN TARGET BUT NOT IN SOURCE.


---COLUMN-2  FOR first_name.								
SELECT first_name FROM HR.employees
MINUS
SELECT first_name FROM employees1; ---WE FOUND 2 NAMES PRESENT IN SOURCE WHICH ARE NOT IN TARGET. 

SELECT first_name FROM employees1
MINUS
SELECT first_name FROM HR.employees;--- WE FOUND 8 NAMES PRESENT IN TARGET WHICH ARE NOT IN SOURCE.


---COLUMN-3  FOR last_name.
SELECT last_name FROM HR.employees
MINUS
SELECT last_name FROM employees1; --- NULL
							

SELECT last_name FROM employees1
MINUS
SELECT last_name FROM HR.employees;--- WE FOUND ONLY 3 NAMES PRESENT IN TARGET WHICH ARE NOT IN SOURCE BECAUSE "KUMAR" IS DUPLICATE.


---COLUMN-4  FOR EMAIL.
SELECT EMAIL FROM HR.employees
MINUS
SELECT EMAIL FROM employees1; --- NULL
							

SELECT EMAIL FROM employees1
MINUS
SELECT EMAIL FROM HR.employees;  ---WE FOUND 5 ROWS PRESENT IN TARGET BUT NOT IN SOURCE.


---COLUMN-5  FOR PHONE_NUMBER.
SELECT PHONE_NUMBER FROM HR.employees
MINUS
SELECT PHONE_NUMBER FROM employees1; --- NULL
							

SELECT PHONE_NUMBER FROM employees1
MINUS
SELECT PHONE_NUMBER FROM HR.employees;  ---WE FOUND 5 ROWS PRESENT IN TARGET BUT NOT IN SOURCE.


---COLUMN-6  FOR HIRE_DATE.
SELECT HIRE_DATE FROM HR.employees
MINUS
SELECT HIRE_DATE FROM employees1; --- NULL
							

SELECT HIRE_DATE FROM employees1
MINUS
SELECT HIRE_DATE FROM HR.employees;----WE FOUND 5 ROWS PRESENT IN TARGET BUT NOT IN SOURCE.



---COLUMN-7  FOR JOB_ID.
SELECT JOB_ID FROM HR.employees
MINUS
SELECT JOB_ID FROM employees1; --- NULL
							

SELECT JOB_ID FROM employees1
MINUS
SELECT JOB_ID FROM HR.employees;---NULL


---COLUMN-8  FOR SALARY.
SELECT SALARY FROM HR.employees
MINUS
SELECT SALARY FROM employees1; --- NULL
							

SELECT SALARY FROM employees1
MINUS
SELECT SALARY FROM HR.employees; ---RETURN ONE ROW 



---COLUMN-9  FOR COMMISSION_PCT.
SELECT COMMISSION_PCT FROM HR.employees
MINUS
SELECT COMMISSION_PCT FROM employees1; --- NULL
							

SELECT COMMISSION_PCT FROM employees1
MINUS
SELECT COMMISSION_PCT FROM HR.employees; ---NULL


---COLUMN-10  FOR MANAGER_ID.
SELECT MANAGER_ID FROM HR.employees
MINUS
SELECT MANAGER_ID FROM employees1; --- NULL
							

SELECT MANAGER_ID FROM employees1
MINUS
SELECT MANAGER_ID FROM HR.employees; ---NULL


---COLUMN-11  FOR DEPARTMENT_ID.
SELECT DEPARTMENT_ID FROM HR.employees
MINUS
SELECT DEPARTMENT_ID FROM employees1; --- NULL
							

SELECT DEPARTMENT_ID FROM employees1
MINUS
SELECT DEPARTMENT_ID FROM HR.employees; ---NULL
						
---1)	We need to perform both source minus target and target minus source.
---2)	If the minus query returns a value, that should be considered as mismatching rows.
---3)	You need to match the rows in source and target using the Intersect statement.
			



---4.  Check for Transformation or Business logic.			
--- Check all the transformation and Business logics according to mapping sheet.




-----5.	Data quality Testing.
---1.	Null check.
Select * from employees1 where Employee_id is Null;  ---IT SHOULD NOT CONTAIN NULL VALUES BECAUSE PRIMARY KEY IS DEFINED.
Select * from employees1 where FIRST_NAME is Null;
Select * from employees1 where LAST_NAME is Null;  ---IT SHOULD NOT CONTAIN NULL VALUES BECAUSE NOT NULL IS DEFINED.
Select * from employees1 where EMAIL is Null;   ---IT SHOULD NOT CONTAIN NULL VALUES BECAUSE NOT NULL IS DEFINED.
Select * from employees1 where PHONE_NUMBER is Null;
Select * from employees1 where HIRE_DATE is Null;   ---IT SHOULD NOT CONTAIN NULL VALUES BECAUSE NOT NULL IS DEFINED.
Select * from employees1 where JOB_ID is Null;   ---IT SHOULD NOT CONTAIN NULL VALUES BECAUSE NOT NULL IS DEFINED.
Select * from employees1 where SALARY is Null;
Select * from employees1 where COMMISSION_PCT is Null; ---77 ROWS ARE NULL.
Select * from employees1 where MANAGER_ID is Null;-- 1 ROW IS NULL.
Select * from employees1 where DEPARTMENT_ID is Null;-- 1 ROW IS NULL.
                      
---a). Check for null count for all columns.
---b). check for Not Null count for all columns.
---c). Primary key, Unique and Not Null column should not accept Null values.
---d). Take the required screen shots and data sample to include in the test result document



----2.	Duplicate check.					
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id, count(*) 
FROM HR.employees
group by employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct,manager_id, department_id
Having count(*)>1;

													
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id, count(*) 
FROM employees1
group by employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct,manager_id, department_id
Having count(*)>1;	
							
							
---a). Check for duplicate record count.
---b). Check for distinct record count for each column and compare with source.
						
SELECT COUNT(DISTINCT employee_id) FROM HR.employees; ----107 RECORDS
SELECT COUNT(DISTINCT employee_id) FROM employees1; ---- 112 RECORDS

SELECT COUNT(DISTINCT FIRST_NAME) FROM HR.employees; ----91 RECORDS
SELECT COUNT(DISTINCT FIRST_NAME) FROM employees1; ---- 97 RECORDS

SELECT COUNT(DISTINCT LAST_NAME) FROM HR.employees; ----102 RECORDS
SELECT COUNT(DISTINCT LAST_NAME) FROM employees1; ---- 105 RECORDS

SELECT COUNT(DISTINCT EMAIL) FROM HR.employees; ----107 RECORDS
SELECT COUNT(DISTINCT EMAIL) FROM employees1; ---- 112 RECORDS

SELECT COUNT(DISTINCT PHONE_NUMBER) FROM HR.employees; ----107 RECORDS
SELECT COUNT(DISTINCT PHONE_NUMBER) FROM employees1; ---- 112 RECORDS

SELECT COUNT(DISTINCT HIRE_DATE) FROM HR.employees; ----98 RECORDS
SELECT COUNT(DISTINCT HIRE_DATE) FROM employees1; ---- 103 RECORDS

SELECT COUNT(DISTINCT JOB_ID) FROM HR.employees; ----19 RECORDS
SELECT COUNT(DISTINCT JOB_ID) FROM employees1; ---- 19 RECORDS

SELECT COUNT(DISTINCT SALARY) FROM HR.employees; ----58 RECORDS
SELECT COUNT(DISTINCT SALARY) FROM employees1; ---- 59 RECORDS

SELECT COUNT(DISTINCT COMMISSION_PCT) FROM HR.employees; ----7 RECORDS
SELECT COUNT(DISTINCT COMMISSION_PCT) FROM employees1; ---- 7 RECORDS

SELECT COUNT(DISTINCT MANAGER_ID) FROM HR.employees; ----18 RECORDS
SELECT COUNT(DISTINCT MANAGER_ID) FROM employees1; ---- 18 RECORDS

SELECT COUNT(DISTINCT DEPARTMENT_ID) FROM HR.employees; ----11 RECORDS
SELECT COUNT(DISTINCT DEPARTMENT_ID) FROM employees1; ---- 11 RECORDS
							
---c). If we are doing truncate and load approach or incremental load approach but developer is not configured ETL job properly then it may load duplicate data to target table and inflate the count.
---d).	Take the required screen shots and data sample to include in the test result document.
						

----3.	Data truncation check.
--- max() length of columns should be less than or equal data length of column. 
SELECT MAX(LENGTH(EMPLOYEE_ID)) FROM employees1; ---3
SELECT MAX(LENGTH(EMPLOYEE_ID)) FROM HR.employees;---3


SELECT MAX(LENGTH(FIRST_NAME)) FROM employees1;---11
SELECT MAX(LENGTH(FIRST_NAME)) FROM HR.employees;---11

SELECT MAX(LENGTH(LAST_NAME)) FROM employees1;---11
SELECT MAX(LENGTH(LAST_NAME)) FROM HR.employees;---11

SELECT MAX(LENGTH(EMAIL)) FROM employees1;---8
SELECT MAX(LENGTH(EMAIL)) FROM HR.employees;---8

SELECT MAX(LENGTH(PHONE_NUMBER)) FROM employees1;---18
SELECT MAX(LENGTH(PHONE_NUMBER)) FROM HR.employees;---18

SELECT MAX(LENGTH(HIRE_DATE)) FROM employees1;---8
SELECT MAX(LENGTH(HIRE_DATE)) FROM HR.employees;---8

SELECT MAX(LENGTH(JOB_ID)) FROM employees1;---10
SELECT MAX(LENGTH(JOB_ID)) FROM HR.employees;---10

SELECT MAX(LENGTH(SALARY)) FROM employees1;---5
SELECT MAX(LENGTH(SALARY)) FROM HR.employees;---5

SELECT MAX(LENGTH(COMMISSION_PCT)) FROM employees1;---3
SELECT MAX(LENGTH(COMMISSION_PCT)) FROM HR.employees;---3

SELECT MAX(LENGTH(MANAGER_ID)) FROM employees1;---3
SELECT MAX(LENGTH(MANAGER_ID)) FROM HR.employees;---3

SELECT MAX(LENGTH(DEPARTMENT_ID)) FROM employees1;---3
SELECT MAX(LENGTH(DEPARTMENT_ID)) FROM HR.employees;---3




---4.	REFERENTIAL INTEGRITY CHECK: PARENT AND CHILD RELATIONSHIP.
---a).VALIDATE ALL REFERENCE TABLES. CHECK WHETHER LATEST REFERENCE FILES ARE LOADED IN THE REFERENCE TABLE.
---b).CHILD TABLE DOESNOT HAVE RECORDS WHICH ARE NOT PRESENT IN PARENT TABLE (EARLY COMMING FACT DATA AND LATE ARRIVING DIMINSION DATA).



----5.  Perform data cleansing and find all extra spaces in the data using Trim operation.

SELECT first_name, LENGTH(first_name) original_length, LENGTH(RTRIM(LTRIM(first_name))) length_after_trim ,(LENGTH(first_name)- LENGTH(RTRIM(LTRIM(first_name)))) AS extra_space
FROM employees1
WHERE (LENGTH(first_name)- LENGTH(RTRIM(LTRIM(first_name))))>0;


SELECT EMPLOYEE_ID, LENGTH(EMPLOYEE_ID) original_length, LENGTH(RTRIM(LTRIM(EMPLOYEE_ID))) length_after_trim ,(LENGTH(EMPLOYEE_ID)- LENGTH(RTRIM(LTRIM(EMPLOYEE_ID)))) AS extra_space
FROM employees1
WHERE (LENGTH(EMPLOYEE_ID)- LENGTH(RTRIM(LTRIM(EMPLOYEE_ID))))>0;

SELECT LAST_NAME, LENGTH(LAST_NAME) original_length, LENGTH(RTRIM(LTRIM(LAST_NAME))) length_after_trim ,(LENGTH(LAST_NAME)- LENGTH(RTRIM(LTRIM(LAST_NAME)))) AS extra_space
FROM employees1
WHERE (LENGTH(LAST_NAME)- LENGTH(RTRIM(LTRIM(LAST_NAME))))>0;


SELECT EMAIL, LENGTH(EMAIL) original_length, LENGTH(RTRIM(LTRIM(EMAIL))) length_after_trim ,(LENGTH(EMAIL)- LENGTH(RTRIM(LTRIM(EMAIL)))) AS extra_space
FROM employees1
WHERE (LENGTH(EMAIL)- LENGTH(RTRIM(LTRIM(EMAIL))))>0;


SELECT PHONE_NUMBER, LENGTH(PHONE_NUMBER) original_length, LENGTH(RTRIM(LTRIM(PHONE_NUMBER))) length_after_trim ,(LENGTH(PHONE_NUMBER)- LENGTH(RTRIM(LTRIM(PHONE_NUMBER)))) AS extra_space
FROM employees1
WHERE (LENGTH(PHONE_NUMBER)- LENGTH(RTRIM(LTRIM(PHONE_NUMBER))))>0;


SELECT HIRE_DATE, LENGTH(HIRE_DATE) original_length, LENGTH(RTRIM(LTRIM(HIRE_DATE))) length_after_trim ,(LENGTH(HIRE_DATE)- LENGTH(RTRIM(LTRIM(HIRE_DATE)))) AS extra_space
FROM employees1
WHERE (LENGTH(HIRE_DATE)- LENGTH(RTRIM(LTRIM(HIRE_DATE))))>0;


SELECT JOB_ID, LENGTH(JOB_ID) original_length, LENGTH(RTRIM(LTRIM(JOB_ID))) length_after_trim ,(LENGTH(JOB_ID)- LENGTH(RTRIM(LTRIM(JOB_ID)))) AS extra_space
FROM employees1
WHERE (LENGTH(JOB_ID)- LENGTH(RTRIM(LTRIM(JOB_ID))))>0;


SELECT SALARY, LENGTH(SALARY) original_length, LENGTH(RTRIM(LTRIM(SALARY))) length_after_trim ,(LENGTH(SALARY)- LENGTH(RTRIM(LTRIM(SALARY)))) AS extra_space
FROM employees1
WHERE (LENGTH(SALARY)- LENGTH(RTRIM(LTRIM(SALARY))))>0;


SELECT COMMISSION_PCT, LENGTH(COMMISSION_PCT) original_length, LENGTH(RTRIM(LTRIM(COMMISSION_PCT))) length_after_trim ,(LENGTH(COMMISSION_PCT)- LENGTH(RTRIM(LTRIM(COMMISSION_PCT)))) AS extra_space
FROM employees1
WHERE (LENGTH(COMMISSION_PCT)- LENGTH(RTRIM(LTRIM(COMMISSION_PCT))))>0;


SELECT MANAGER_ID, LENGTH(MANAGER_ID) original_length, LENGTH(RTRIM(LTRIM(MANAGER_ID))) length_after_trim ,(LENGTH(MANAGER_ID)- LENGTH(RTRIM(LTRIM(MANAGER_ID)))) AS extra_space
FROM employees1
WHERE (LENGTH(MANAGER_ID)- LENGTH(RTRIM(LTRIM(MANAGER_ID))))>0;


SELECT DEPARTMENT_ID, LENGTH(DEPARTMENT_ID) original_length, LENGTH(RTRIM(LTRIM(DEPARTMENT_ID))) length_after_trim ,(LENGTH(DEPARTMENT_ID)- LENGTH(RTRIM(LTRIM(DEPARTMENT_ID)))) AS extra_space
FROM employees1
WHERE (LENGTH(DEPARTMENT_ID)- LENGTH(RTRIM(LTRIM(DEPARTMENT_ID))))>0;



----6. SYNTAX TEST TO REPORT INVALID CHARACTERS, INCORRECT UPPER/LOWER CASE ORDER, ETC

SELECT COUNT(*) FROM employees1
WHERE substr(first_name,1,1) IN ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');

SELECT COUNT(*) FROM employees1
WHERE substr(last_name,1,1) IN ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');

SELECT COUNT(*) FROM employees1
WHERE email = upper(email);

SELECT COUNT(*) FROM employees1
WHERE HIRE_DATE = to_char(HIRE_DATE,'dd-mm-yy');



----7.BOUNDARY VALUE ANALYSIS CHECK AND PATTERN MATCHING



---8.NEGATIVE CHECK.

---(a)	ADD NULL TO PRIMARY CONSTRAINTS / NOT NULL COLUMN.
---(b)	ADD DUPLICATE DATA TO PRIMARY/UNIQUE CONSTRAINTS COLUMN.
---(c)	ADD DIFFERENT DATA TYPE VALUES("TEXT" TO  "NUMBER" DATA TYPES COLUMNS) TO EACH COLUMNS AND CHECK.
---(d)  ADD RECORDS LENGHTH HIGHER THAN SPECIFIED DATA LENGTH OF COLUMNS AND CHECK. 
---(f)  ADD RECORD TO CHILD TABLE WHICH DOES NOT HAVE DATA IN PARENT TABLE AND CHECK FOR REFRENTIAL INTIGRITY VIOLATION.
---(G)  ADD DATE OF DIFFRENT FORMAT AND CHECK.
---(e)  TAKE THE REQUIRED SCREEN SHOTS AND DATA SAMPLE TO INCLUDE IN THE TEST RESULT DOCUMENT.



---8.FIRST LOAD / INCREMENTAL LOAD.



---9.REGRESSION TESTING AND RETESTING.
--- SELECT TEST CASE FOR THOSE WE WANT TO PERFORM REGRESSION TESTING AND RETESTING AND EXECUTE.
    


----10.	PERFORMANCE TESTING.

















SELECT * FROM HR.EMPLOYEES
MINUS
SELECT * FROM EMPLOYEES1; ----SPACES ARE THERE IN FIRST_NAME OF TABLE EMPLOYEES1


SELECT * FROM EMPLOYEES1
MINUS
SELECT * FROM HR.EMPLOYEES;









































































