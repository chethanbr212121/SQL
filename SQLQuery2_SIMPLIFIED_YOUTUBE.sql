--- 1. HOW TO CTEATE A DATABASE, TABLE, INSERT DATA TO TABLE, ALTER TABLE, DROP TABLE, UPDATE ROW, DELETE ROW.



--- CREATE DATABASE.

CREATE DATABASE test;



--- USE DATABASE.

USE test;



--- CREATE TABLE.

CREATE TABLE employee
(
id INT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
dob DATETIME,
email VARCHAR(40),
);




---INSERT INTO BY SINGLE DATA INTO TABLE.

INSERT INTO dbo.employee ([id],[name],[dob],[email])
VALUES('1','chet','2000-05-22','che@g.com')

INSERT INTO dbo.employee ([id],[name],[dob],[email])
VALUES('2','ram','2000-05-22','che@g.com')



--- INSERTING MULTIPLE DATA INTO TABLE.

INSERT INTO dbo.employee([id],[name],[dob],[email])
VALUES( '3','sam','2005-06-21','sam21@gmail.com'),
( '4','beam','2005-01-23','beam21@gmail.com'),
( '5','kallesh','2001-02-01','kallesh21@gmail.com'),
( '6','kumar','2008-08-15','kumar1@gmail.com'),
( '7','mahesh','2008-10-08','mahesh21@gmail.com'),
( '8','mukesh','2005-11-21','mukesh@gmail.com'),
( '9','ravi','2001-07-22','ravi21@gmail.com')

SELECT * FROM employee




--- ALTER QUERY.

ALTER TABLE employee
ADD salary DECIMAL(10,2);

ALTER TABLE employee
ADD age INT;

ALTER TABLE employee
ALTER column email VARCHAR(60);

DROP TABLE bemployee;


--- UPDATE QUERY.

UPDATE employee
 SET name = 'yash'
 WHERE id=3;

 UPDATE employee
 SET age = '29'
 WHERE id=4;

 UPDATE employee
 SET salary = '29000'
 WHERE id=1;


 UPDATE temployee
 SET name = UPPER(name);  --Changing or updating whole column data into uppercase.


 UPDATE temployee
 SET name = LOWER(name);  --Changing or updating whole column data into lowercase.


SELECT * FROM temployee



--- DROP QUERY

DROP TABLE gemployee;





--- DELETE QUERY WILL DELETE ENTIRE ROW IT CANNOT BE USE TO DELETE SINGLE FIELD.

DELETE FROM employee
WHERE id=9; 



--- Deleting multiplrows from a table ( it removes the multiple data identified by same data).

DELETE FROM demployee
WHERE email='che@g.com'; 

SELECT * FROM demployee

--- DELETE QUERY WILL DELETE ENTIRE DATA IN THE TABLE.

DELETE FROM SHAM4;  


         

---2. HOW TO CTEATE new table  FROM another existing table or copy same table as another table.

use test;

SELECT * INTO temployee FROM employee





 ---3. HOW TO CREATE NEW TABLE STRUCTURE WITH EXISTING TABLE (ONLY TABLE STRUCTURE NOT DATA).

 SELECT * INTO demployee FROM temployee
 WHERE 1 = 0;

 SELECT * FROM demployee;




--- 4. SELECT COLUMNS FROM TABLE.

 use test;

 SELECT id, name, dob FROM employee;



--- 5.ARITHMETIC OPERATOR (+,-,*,/).

SELECT 5+5;

SELECT 5-5;

SELECT 5*5;

SELECT 5/5;




--- 6. COMPARISON OPERATOR(>,<,=,<=,>=).

CREATE TABLE cemployee
(
id INT PRIMARY KEY,
name VARCHAR(50),
age INT,
email VARCHAR(50),
salary DECIMAL(10,2)
);

INSERT INTO cemployee([id],[name],[age],[email],[salary])
VALUES( '1','sam','21','sam21@gmail.com',10000),
( '2','beam','23','beam21@gmail.com',25000),
( '3','kallesh','25','kallesh21@gmail.com',30000),
( '4','kumar','35','kumar1@gmail.com',18000),
( '5','mahesh','32','mahesh21@gmail.com',35000),
( '6','mukesh','33','mukesh@gmail.com',12000),
( '7','ravi','22','ravi21@gmail.com',16000)

select * from cemployee


SELECT * FROM cemployee
WHERE salary < 20000;


SELECT * FROM cemployee
WHERE salary > 20000;

SELECT * FROM cemployee
WHERE salary = 25000;


SELECT * FROM cemployee
WHERE age < 25;

SELECT * FROM cemployee
WHERE age >= 25;

SELECT * FROM cemployee
WHERE age = 25;

SELECT salary FROM cemployee
WHERE name='sam' ;

SELECT age FROM cemployee
WHERE name='sam' ;

SELECT email FROM cemployee
WHERE name='beam' ;




---7. LOGICAL OPERATOR (ALL,AND,BETWEEN,IN,LIKE,OR,ISNULL).

 use test;

 SELECT * FROM cemployee
 WHERE age>=30 and salary<=30000;


 SELECT * FROM cemployee
 WHERE age>=30 OR salary<=25000;

 SELECT * FROM employee
 WHERE name LIKE 'm%';  ** HERE % AFTER ANY LETTER INDICATES WORDS STARTS FROM LETTER 'M'.
  
 SELECT * FROM cemployee
 WHERE age IN (25,32,33);

 SELECT * FROM cemployee
 WHERE age BETWEEN 25 AND 33;

 SELECT * FROM cemployee
 WHERE age < ALL(SELECT age FROM cemployee WHERE salary > 25000);

 UPDATE Cemployee
 SET name = 'yash'
 WHERE id=3;





--- 8. LIKE OPERATOR( % AND _)

SELECT * FROM cemployee
WHERE email LIKE '%gmail%';   -- IT FILTERS ALL EMAIL CONTAINS WORD 'GMAIL'.

SELECT * FROM cemployee
WHERE email LIKE 'b%';        -- IT FILTERS ALL EMAIL "STATRS" FROM LETTE 'B'.

SELECT * FROM cemployee
WHERE email LIKE '%21%';      -- IT FILTERS ALL EMAIL CONTAINS NUMBER '21'.

SELECT * FROM cemployee
WHERE email LIKE '%com';      --IT FILTERS ALL EMAIL "END" FROM  'COM'.

SELECT * FROM cemployee
WHERE age LIKE '2_';           -- IT FILTERS ALL AGE "STATRS" FROM NUMBER  '2'(_ IS USED FOR ONLY ONE NUMBER OR CHARACTER).

SELECT * FROM cemployee
WHERE name LIKE '_a%';         -- IT FILTERS ALL NAME SECOND LETTER 'A' REMAININ LETTERS ANYTHING).

SELECT * FROM cemployee
WHERE name LIKE '__h%';         -- IT FILTERS ALL NAME THIRD LETTER 'H' REMAININ LETTERS ANYTHING).




---9. ORDER BY CLAUSE.

SELECT * FROM cemployee
ORDER BY name;                 -- ORANGE NAME COLUMN IN ALPHABATIC ORDER.

SELECT * FROM cemployee
ORDER BY name DESC;            --- ORANGE NAME COLUMN IN DESENDING ORDER.

SELECT * FROM cemployee
ORDER BY name ASC;            -- ORANGE NAME COLUMN IN ASCENDING ORDER.

SELECT * FROM cemployee
ORDER BY salary DESC;            -- ORANGE SALARY COLUMN IN DESENDING ORDER.

SELECT * FROM cemployee
ORDER BY salary ASC;            -- ORANGE SALARY COLUMN IN ASCENDING ORDER.

SELECT * FROM cemployee
ORDER BY age;                  --ORANGE AGE COLUMN YOUNGEST TO OLDEST.




--- 10. GROUP BY CLAUSE.

SELECT * FROM employee;

SELECT gender , COUNT(*)
FROM employee
GROUP BY gender;               -- COUNTING NUMBER OF FEMALE AND MALE EMPLOYEES.

SELECT gender , SUM(salary)
FROM employee
GROUP BY gender;              -- SUM OF SALARY TAKEN BY MALE AND FEMALE GROUP.

SELECT email , COUNT(*)
FROM employee
GROUP BY email;               -- GIVES SAME EMAIL ID .


SELECT dob , COUNT(*)
FROM employee
GROUP BY dob;                 -- GIVES SAME DOB BY EMPLOYEE.



--- 11. DISTINCT CLAUSE.

SELECT * FROM employee;

SELECT DISTINCT dob           -- GIVES UNIQUE OR DISTINCT RECORDS(NOT REPEATING). 
FROM employee
ORDER BY dob;    



--- 12.ALIASING AS  CLAUSE. 
  
SELECT id AS ID, name AS FIRST_NAME, dob AS DOB       
FROM employee;                             -- IT REPLACES id FROM ID IN RESULTS COLUMN, name from FIRST_NAME etc.




--- 13.JOIN  CLAUSE.

CREATE TABLE students
(
stid INT PRIMARY KEY NOT NULL,
stname VARCHAR(50) NULL,
smarks INT NULL
);


INSERT INTO dbo.students([stid],[stname],[smarks])
VALUES(101, 'sam', 96),
(102, 'ram', 95),
(103, 'beam', 96),
(104, 'jon', 93),
(105, 'koli', 97),
(106, 'kris', 92),
(107, 'nav', 95),
(108, 'fag', 93),
(109, 'dep', 85),
(110, 'gen', 89),
(111, 'tin', 87),
(112, 'yen', 85),
(113, 'rub', 90),
(114, 'zep', 91)


SELECT * FROM students;

SELECT * FROM cemployee;



**--- JOIN USING ON.

SELECT  t.id,t.name,
 ti.smarks, ti.gen, ti.stname
FROM dbo.cemployee AS t
JOIN dbo.students AS ti
ON t.id = ti.stid;



**--- JOIN USING WHERE.

SELECT  t.id,t.name,
 ti.smarks, ti.gen
FROM dbo.cemployee AS t, dbo.students AS ti
WHERE t.id = ti.stid;




**--- 14.GROUP BY AND JOIN  CLAUSE.
-- JOIN give result when id(1,2,3,4,5,6,7) from cemployee and stid(1,2,3,4,5,6,7) from students have same values.

SELECT ti.gen, SUM(t.salary) AS 'total_salary'
FROM cemployee AS t
JOIN students AS ti
ON t.id = ti.stid        
GROUP BY ti.gen;

  

**---- LEFT JOIN CLAUSE.
--- LEFT JOIN gives result even when some data in id(1,2,3,4,5,6,7) from cemployee not present as compare to stid(1,2,3,4,5,6,7,8,9,10,11) from students.

SELECT ti.gen, SUM(t.salary) AS 'total_salary'
FROM cemployee AS t
LEFT JOIN students AS ti
ON t.id = ti.stid        
GROUP BY ti.gen;  


SELECT ti.gen, SUM(t.salary) AS 'total_salary'
FROM cemployee AS t
RIGHT JOIN students AS ti
ON t.id = ti.stid        
GROUP BY ti.gen; 




--- 15.ABS()  FUNCTION.

SELECT ABS(25)

SELECT ABS(-25)

**-- IT GIVES POSITIVE DIFFERENCE EVEN THE VALUE IS NEGETIVE, IT IS USED WHEN WE WANT SHOW ONLY POSITIVE DATA OR WE NEED ONLY DIFFERENCE IRRESPECTIVE OF SIGN.

SELECT ti.id,
ABS(ti.age - ti.salary) AS 'age salary'
FROM students AS t
JOIN cemployee AS ti
ON ti.id=t.stid;


--- 16.SOME USEFULL FUNCTION.

SELECT ROUND(54.6328,2);



---- CEILING ROUND TO NEXT OR HIGHER NUMBER.

SELECT CEILING(35.20);   

 

--- FLOOR ROUND TO PREVIOUS OR LOWER NUMBER.

SELECT FLOOR(35.60);


SELECT EXP(5);
-- VALUE OF e=2.7. ABOVE RESULT GIVES 2.7 POWER 5.



--- LOG FUNCTION.

SELECT LOG(2);



--- LOG TO THE BASE 10 FUNCTION.

SELECT LOG10(2);



--- POWER FUNCTION.

SELECT POWER(2,7)




--- 17.SOME USEFULL NUMERIC FUNCTION.


--- RADIANS FUNCTION.

SELECT RADIANS(180);



--- SQRT FUNCTION.

SELECT SQRT(225.6);



--- TRUNCATE FUNCTION -- IT REMOVES ALL THE DATA FROM TABLE.
 
 TRUNCATE TABLE Dbo.bemployee;




--- RAND FUNCTION.

 SELECT RAND();



--- CONCAT FUNCTION.

SELECT CONCAT('HELLO ', 'WORLD');

SELECT CONCAT(  [stname] , ' is have marks', [smarks]) AS students
FROM students;

--- CONCAT GIVES RESULT IN THE FORM OF WORDINGS.




--- UPPER() AND LOWER() FUNCTION.

-- UPPER GIVES UPPER CASE LETTERS.

SELECT UPPER( ' my name is chethan');

-- LOWER GIVES LOWER CASE LETTERS.

SELECT LOWER( ' MY Name is Chethan');

SELECT UPPER(name) FROM cemployee;




--- SUBSTRING FUNCTION.

SELECT SUBSTRING( 'I NEED A BREAK',3,4);

SELECT SUBSTRING( 'I NEED A BREAK',10,5);


--HERE WE REQUIRED TO SHOW WORD 'NEED'.HERE  3 MEANS STARTING LETTER 'N' IS 3rd CHARACTER AND 4 MEANS 'NEED' HAVE 4 CHARACTER.
--HERE WE REQUIRED TO SHOW WORD 'BREAK'.HERE  10 MEANS STARTING LETTER'B' IS 10th CHARACTER AND 5 MEANS 'BREAK' HAVE 5 CHARACTER.



--- RIGHT FUNCTION.

SELECT RIGHT( 'I NEED A BREAK',5);

-- RIGHT GIVES 5 (BREAK) CHARACTERS AT RIGHT SIDE OF STRING OR 5 CHARACTERS FROM THE END OF THE STRING.



--- LEFT FUNCTION.

SELECT LEFT( 'I NEED A BREAK',6);

-- LEFT GIVES 6 (I NEED) CHARACTERS AT LEFT SIDE OF STRING OR 6 CHARACTERS FROM THE START OF THE STRING.



-- UPDATING PART OF STRING.
UPDATE employee
SET email = REPLACE(email,'g.com','gmail.com');



-- REVERSE OPERATION.
SELECT REVERSE('see you later');



-- CREATE "VIEW TABLE" TO SEE ONLY PARTICULAR COLUMNS AND INSERTING DATA INTO VIEW TABLE(THE DATA WILL ALSO UPDATE IN ORIGINAL EMPLOYE TABLE ALSO)..
CREATE VIEW emp_view AS
SELECT ID,name,email
FROM employee
WHERE name is NOT NULL;

select * from emp_view;

INSERT INTO emp_view
VALUES(9,'ramesh','ramesh21@gmail.com'); --'UPDATE','DELETE' AND 'DROP' ALSO WORKS SAME HERE ALSO.

-- 'COUNT' USED TO FIND TOTAL NUMBER OF RECORDS.
SELECT COUNT(*) FROM employee;

SELECT COUNT(*) FROM employee
WHERE age<30;


SELECT COUNT(*) FROM employee
WHERE salary<25000;

SELECT COUNT(*) FROM employee
WHERE gender='M';

SELECT COUNT(*) FROM employee
WHERE gender='F';


-- 'MAX' , 'MIN' AND 'AVG' FUNCTION.
SELECT MAX(salary) FROM employee;

SELECT MIN(salary) FROM employee;

SELECT AVG(salary) FROM employee;

--IT GIVES ALL EMPLOYEE DETAILS WHO HAVE MAXIMUM SALARY.
SELECT id, name FROM employee
WHERE salary=(SELECT MAX(SALARY) FROM employee);






SELECT * FROM employee;

USE test



