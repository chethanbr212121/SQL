
CREATE TABLE CHECKTABLE
(
ID NUMBER,
NAME VARCHAR2(20),
MARKS NUMBER
);

INSERT ALL
INTO CHECKTABLE VALUES(1,'KALLESH',85)
INTO CHECKTABLE VALUES(2,'MALLESH',90)
INTO CHECKTABLE VALUES(3,'RAESH',80)
INTO CHECKTABLE VALUES(4,'SOMESH',92)
SELECT * FROM DUAL;

UPDATE CHECKTABLE
SET Name='RAKESH'
WHERE id=3;

SELECT * FROM CHECKTABLE;

---CHECK COUNT
SELECT COUNT(*) FROM CHECKTABLE;----COUNT-4

---CHECK DUPLICATE.
SELECT ID, NAME, MARKS, COUNT(*) FROM CHECKTABLE
GROUP BY ID, NAME, MARKS
HAVING COUNT(*)>1;

---CHECK SOURCE DATA PRESENT IN SOURCE AND NOT PRESENT IN TARGWT.
SELECT * FROM source.CHECKTABLE
MINUS
SELECT * FROM target.CHECKTABLE_TRGT;

---CHECKING TARGET DATA PRESENT IN TARGET AND NOT PRESENT IN SOURCE
SELECT * FROM target.CHECKTABLE_TRGT
MINUS
SELECT * FROM source.CHECKTABLE;



COMMIT;