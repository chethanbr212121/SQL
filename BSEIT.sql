/****** Script for SelectTopNRows command from SSMS  ******/
USE TEST;

SELECT * FROM BSEIT


SELECT * FROM BSEIT
WHERE SECTOR = 'SERVICES'; 


SELECT DISTINCT sector  -- it gives unique value or charactor.
FROM BSEIT;

SELECT DISTINCT industry  -- it gives unique value or charactor.
FROM BSEIT;


SELECT UPPER(nse_code), UPPER(ROUND(marketcap,0)),UPPER(industry)
FROM BSEIT;



SELECT nse_code AS NSECODE, sector AS SECTOR, price*2 AS PRICE, ROUND((price / eps),0) AS PE
FROM BSEIT
 WHERE PE>30 AND PE<40;



SELECT slno, industry+','+nse_code+','+sector
FROM BSEIT;



SELECT nse_code, ROUND((price / eps),0) AS PE, price
FROM BSEIT
WHERE sector='technology'; 



SELECT nse_code, ROUND((price / eps),0) AS PE, price
FROM BSEIT
WHERE  ROUND((price / eps),0)>30 AND price<10000 AND sector='services'; 



SELECT nse_code
FROM BSEIT
WHERE nse_code LIKE 'in%';



SELECT nse_code, price
FROM BSEIT
WHERE sector ='services' AND price<8000 ;



SELECT nse_code, price
FROM BSEIT
WHERE sector <>'services' ; --- "<>"  means not equal to.



SELECT price, nse_code
FROM BSEIT
WHERE nse_code LIKE 'in%' OR nse_code LIKE 'm%';



SELECT price, nse_code,sector
FROM BSEIT
WHERE  sector <>'technology' AND (nse_code LIKE 'in%' OR nse_code LIKE 'm%');



SELECT price, nse_code,sector
FROM BSEIT
WHERE  sector <>'services' AND NOT(nse_code LIKE 'in%' OR nse_code LIKE 'm%');




SELECT price, nse_code,sector
FROM BSEIT
WHERE  (sector <>'services' AND sector <> 'technology') AND NOT(nse_code LIKE 'in%' OR nse_code LIKE 'm%');

--- WE CAN USE ABOVE QUERY BY ANOTHER WAY WITH OUT USING BRACKET IS.

SELECT price, nse_code,sector
FROM BSEIT
WHERE  sector <>'services' AND sector <> 'technology' AND nse_code NOT LIKE 'in%' AND nse_code NOT LIKE 'm%';



SELECT price, nse_code,sector,industry
FROM BSEIT
ORDER BY sector, industry;  --ORDER BY first apply to sector and then apply to industry.



SELECT TOP 10 price, nse_code,sector
FROM BSEIT
ORDER BY price DESC; 

SELECT TOP 10 price, nse_code,sector
FROM BSEIT
ORDER BY price ASC;


SELECT MAX(price) AS PRICE ,sector
FROM BSEIT
GROUP BY sector;

SELECT MIN(price) AS PRICE , sector
FROM BSEIT
GROUP BY sector;

SELECT * FROM BSEIT

SELECT ROUND(SUM(marketcap),0) , sector
FROM BSEIT
GROUP BY sector
HAVING ROUND(SUM(marketcap),0)=46894;   -- HAVING SUM() used to compare.


SELECT ROUND(SUM(marketcap),0) , sector
FROM BSEIT
GROUP BY sector
HAVING ROUND(SUM(marketcap),0)>25000;   -- HAVING SUM() used to compare.

SELECT ROUND(MAX(marketcap),0) , sector
FROM BSEIT
GROUP BY sector
HAVING ROUND(MAX(marketcap),0)>25000;   ---- NEED TO CHECK.



SELECT industry, ROUND(SUM(marketcap),0) AS TOTAL_MARKET_CAP
FROM stocks
GROUP BY Industry;


SELECT name,pe,industry_pe,marketcap,Sales
FROM stocks
WHERE Industry='bearings' OR industry='tyres'
ORDER BY marketcap DESC;  -- Industry='bearings'  Industry='auto ancilaries' industry='tyres'


SELECT name,pe,industry_pe,marketcap,Sales
FROM stocks
WHERE Industry='construction'
ORDER BY marketcap DESC;



SELECT  current_price INTO stocksnew1 FROM stocks  
-- SELECT 'REQUIRED COLUMNS' INTO 'NEWTABLE NAME' FROM 'OLD TABLE NAME'.
-- SELECT '*' INTO 'NEWTABLE NAME' FROM 'OLD TABLE NAME'.  

SELECT(SELECT COUNT(*) FROM stocks) *(SELECT COUNT(*) FROM stocksnew); --- NEED TO CHECK.

SELECT * FROM stocks;

SELECT name
FROM stocks
WHERE name LIKE 'IN%';


SELECT name, Industry,pe,marketcap
FROM stocks
WHERE marketcap >2000 AND pe<20 AND industry='finance - housing'
ORDER BY PE DESC;




-- 1. FINDING SECOND HIGHEST PRICE USING MAX AND TOP.
SELECT MAX(price) FROM BSEIT 
WHERE price < (SELECT MAX(price) FROM BSEIT);

SELECT TOP 1 price FROM (SELECT TOP 2 price FROM bseit ORDER BY price DESC) 
AS bseit ORDER BY price ASC; --- in sub query we are selecting only top 2 (ex: 1,2) price by descending order and in outer query selected top 1 by ascending order (2 comes to top).


SELECT TOP 1 price FROM (SELECT TOP 4 price FROM bseit ORDER BY price DESC) 
AS bseit ORDER BY price ASC; --- in sub query we are selecting only top 3 (ex: 1,2,3) price by descending order and in outer query selected top 1 by ascending order (3 comes to top).



-- 2. FINDING HIGHEST "MARKETCAP" GROUP BY "SECTOR".
SELECT ROUND(MAX(marketcap),0),sector
FROM BSEIT
GROUP BY sector;


-- 3. INNER JOINT.
CREATE TABLE emp
(
e_id INT PRIMARY KEY NOT NULL,
e_name VARCHAR(50) NULL,
dob DATE NULL,
d_id INT NOT NULL);

INSERT INTO emp(e_id,e_name,dob,d_id)
VALUES(1,'ram','2005-05-22',10),
(2,'mahesh','2002-09-20',20),
(3,'kallesh','2000-08-21',10),
(4,'kamal','2001-06-29',20),
(5,'sham','2002-01-26',10),
(6,'bhema','2003-03-25',20),
(7,'ramesh','2006-05-28',10),
(8,'shanker','2005-05-24',20)

ALTER TABLE EMP
ADD salary INT  NULL;

UPDATE EMP
SET  salary=32000
WHERE e_id=8;

CREATE TABLE dep
(
d_id INT PRIMARY KEY NOT NULL,
d_name VARCHAR(50) NULL,
);

INSERT INTO dep(d_id,d_name)
VALUES(10,'civil'),
(20,'cse')
 

 SELECT d.d_name AS 'department',
        e.e_name AS 'employee',
		salary
FROM emp AS e
INNER JOIN dep AS d
ON e.d_id=d.d_id;




--4. SQL QUERY TO FIND ALL DUPLICATE nse_code IN A TABLE.

SELECT nse_code
FROM bseit
GROUP BY nse_code
HAVING COUNT(nse_code)>1



USE test
SELECT * FROM BSEIT


