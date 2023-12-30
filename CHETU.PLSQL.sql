
--- Simple program
BEGIN
DBMS_OUTPUT.PUT_LINE('Well come to PL/SQL');
END;


--- Addition of two numbers.
declare
n1 number(6):=100;
n2 number(6):=250;
result number(12);

BEGIN
DBMS_OUTPUT.PUT_LINE('The addition of two numbers: '|| (n1+n2));

END;

--OR
declare
n1 number(6);
n2 number(6);
result number(12);

BEGIN
n1:=50;
n2:=150;
DBMS_OUTPUT.PUT_LINE('The addition of two numbers: '|| (n1+n2));

END;

--OR
declare
n1 number(6);
n2 number(6);
c  number(12);
BEGIN
n1:=500;
n2:=150;
c:=n1+n2;

DBMS_OUTPUT.PUT_LINE('The addition of two numbers: '||c);

END;


--OR
----Here it takes input from users
declare
n1 number(6):=&n1;
n2 number(6):=&n2;
c  number(12);
BEGIN
c:=n1+n2;

DBMS_OUTPUT.PUT_LINE('The addition of two numbers: '||c);

END;



---DML Operation in PLSQL.
---Anonymous Block.
create table customer
( cust_id number(10),
cust_name varchar2(25),
mobile number(10),
address varchar2(25)
);


SET SERVEROUTPUT ON;
clear screen ---To clear old output.

declare
v_cust_id number(10);
v_cust_name varchar2(25);
v_mobile number(10);
v_address varchar2(25);

begin
insert into customer values(100,'Arun',1234567898,'Chennai');
insert into customer values(101,'Ramesh',1456237897,'Bangloe');
insert into customer values(102,'Suresh',2456139875,'Mysore');
commit;
DBMS_OUTPUT.PUT_LINE('Values inserted');

update customer
set address = 'Manglore'
where cust_id = 102;
commit;
DBMS_OUTPUT.PUT_LINE('Values updated');

delete from customer
where cust_id = 101;
commit;
DBMS_OUTPUT.PUT_LINE('Values deleted');

select cust_id,cust_name,mobile,address into v_cust_id,v_cust_name,v_mobile,v_address 
from customer where cust_id = 102; 
DBMS_OUTPUT.PUT_LINE('customers are listed below:');
DBMS_OUTPUT.PUT_LINE('Customer name: '||v_cust_name);
DBMS_OUTPUT.PUT_LINE('Customer mobile:  number'||v_mobile);
DBMS_OUTPUT.PUT_LINE('Customer address: '||v_address);
end;


--- Select records from the table.
SET SERVEROUTPUT ON;
clear screen ---To clear old output.

declare
v_cust_id number(10);
v_cust_name varchar2(25);
v_mobile number(10);
v_address varchar2(25);

begin
select cust_id,cust_name,mobile,address into v_cust_id,v_cust_name,v_mobile,v_address 
from customer where cust_id = 102; 
DBMS_OUTPUT.PUT_LINE('customers are listed below:');
DBMS_OUTPUT.PUT_LINE('Customer name: '||v_cust_name);
DBMS_OUTPUT.PUT_LINE('Customer mobile:  number'||v_mobile);
DBMS_OUTPUT.PUT_LINE('Customer address: '||v_address);
end;


---Condition statements in PLSQL ("IF-THEN-ELSE" AND "CASE")
--- Eample:1.
SET SERVEROUTPUT ON;
clear screen 

DECLARE
a NUMBER := 10;
b NUMBER := 25;
BEGIN
IF a > b THEN
DBMS_OUTPUT.PUT_LINE(a || ' grater than'|| b);
ELSE
DBMS_OUTPUT.PUT_LINE(a || ' less than '|| b);
END IF;
END;


---Example:2.
SET SERVEROUTPUT ON;
clear screen 

DECLARE
 a boolean := True;
 b boolean := False;
 BEGIN
 IF (a AND b) THEN
 DBMS_OUTPUT.PUT_LINE('LINE 1');-- IF BOTH ARE TRUE THEN RETURNS RESULT FOR 'AND' STATEMENTS.
 END IF;
 IF (a OR b) THEN
 DBMS_OUTPUT.PUT_LINE('LINE2');    ---IF ANY OF THE CONDITION ARE TRUE RETURN RESULT IN "OR" CONDITION.
 END IF;
 IF (NOT a) THEN
 dbms_output.put_line('LINE 3');  ---IT WONT RETURN RESULT BECAUSE HERE "a" IS TRUE, SO NOT "a" MEANS FALSE. 
 ELSE 
 dbms_output.put_line('LINE4');   ---RETURN ELSE CONDITION BECAUSE IF CONDITION NOT RETURN.
 END IF;
 IF ( NOT b) THEN
 dbms_output.put_line('LINE5');   ---IT RETURN RESULT BECAUSE HERE "b" IS FALSE, SO NOT "b" MEANS TRUE. 
 ELSE 
 dbms_output.put_line('LINE6');
 END IF;
 END;
 
 
 ---Example:3.
 SET SERVEROUTPUT ON;
 CLEAR SCREEN;
 
 DECLARE
 V_EMPLOYEE_ID NUMBER:=&EMPLOYEE_ID;
 V_HIRE_DATE NUMBER(5);
 
 BEGIN
 SELECT TO_NUMBER(TO_CHAR(HIRE_DATE,'YYYY')) INTO V_HIRE_DATE FROM EMPLOYEES
 WHERE EMPLOYEE_ID = V_EMPLOYEE_ID;
 IF MOD(V_HIRE_DATE,4)=0 THEN
 DBMS_OUTPUT.PUT_LINE('THE HIRE_DATE  ' ||V_HIRE_DATE||' OF EMPLOYEE '||V_EMPLOYEE_ID||' IS LEAP YEAR');
 ELSE
 DBMS_OUTPUT.PUT_LINE('THE HIRE_DATE ' ||V_HIRE_DATE||' OF EMPLOYEE '||V_EMPLOYEE_ID||' IS NON LEAP YEAR');
 END IF;
 END;
 
 
 
 ---- Example:4.
 SET SERVEROUTPUT ON;
 CLEAR SCREEN;
 
 DECLARE
 V_EMPLOYEE_ID NUMBER:=&EMPLOYEE_ID;
 V_SALARY NUMBER(6);
 
 BEGIN
 SELECT SALARY INTO V_SALARY FROM EMPLOYEES
 WHERE EMPLOYEE_ID = V_EMPLOYEE_ID;
 
 CASE
 WHEN V_SALARY < 5000 THEN
  DBMS_OUTPUT.PUT_LINE('THE SALARY '||V_SALARY|| ' OF EMPLOYEE '||V_EMPLOYEE_ID||' IS LOWER SALARY');
  WHEN V_SALARY > 5000 AND V_SALARY <= 10000 THEN
  DBMS_OUTPUT.PUT_LINE('THE SALARY '||V_SALARY|| ' OF EMPLOYEE '||V_EMPLOYEE_ID||' IS AVERAGE SALARY');
 ELSE
 DBMS_OUTPUT.PUT_LINE('THE SALARY '||V_SALARY|| ' OF EMPLOYEE '||V_EMPLOYEE_ID||' IS HIGHER SALARY');
 END CASE;
 END;
 
 
--- EXAMPLE:5.
--- FROM ABOVE EXAMPLE WRITE PLSQL USING IF AND ELSIF.


--- LOOPING STATEMENT IN PLSQL BLOCK.
--- EXAMPLE:1.0
SET SERVEROUTPUT ON;
CLEAR SCREEN;

DECLARE
C NUMBER :=1;

BEGIN
LOOP
DBMS_OUTPUT.PUT_LINE('WELL COME TO PLSQL LOOPING' || C);
C:=C+1;
EXIT WHEN C>5;
END LOOP;
END;


--- EXAMPLE:2.0
SET SERVEROUTPUT ON;
CLEAR SCREEN;

DECLARE
C NUMBER :=0;

BEGIN
LOOP
DBMS_OUTPUT.PUT_LINE('WELL COME TO PLSQL LOOPING' || C);
C:=C+1;
EXIT WHEN C>5;
END LOOP;
END;



---WHILE LOOP STATEMENT.
SET SERVEROUTPUT ON;
CLEAR SCREEN;

DECLARE
C NUMBER :=1;
BEGIN
WHILE (C<=5)
LOOP
DBMS_OUTPUT.PUT_LINE('WELCOME'||C);
C:=C+1;
END LOOP;
END;



--- FOR LOOP STATEMENT.
SET SERVEROUTPUT ON;
CLEAR SCREEN;

DECLARE
i NUMBER ;
BEGIN
FOR i IN 1..5
LOOP
DBMS_OUTPUT.PUT_LINE('WEL COME '|| i);
END LOOP;
END;


 --- FOR REVERSE LOOP STATEMENT.
SET SERVEROUTPUT ON;
CLEAR SCREEN;

DECLARE
i NUMBER ;
BEGIN
FOR i IN  REVERSE 1..5
LOOP
DBMS_OUTPUT.PUT_LINE('WEL COME '|| i);
END LOOP;
END;


---CREATE PROCEDURE IN PLSQL.
--EXAMPLE:1.0
SET SERVEROUTPUT ON;
CLEAR SCREEN;

CREATE OR REPLACE PROCEDURE ADDITION_PROC(NUM1 IN NUMBER, NUM2 IN NUMBER)
AS 
TOTAL1 NUMBER(10);
BEGIN
TOTAL1 := NUM1 + NUM2;
DBMS_OUTPUT.PUT_LINE('THE ADDITION OF TWO NUMBERS ARE:' || TOTAL1);
END;

EXEC addition_proc(250,205);



--EXAMPLE:2.0
SET SERVEROUTPUT ON;
CLEAR SCREEN;
CREATE OR REPLACE PROCEDURE TOTAL_SALARY(IN_EMP_ID NUMBER)
IS
V_SALARY NUMBER(10);
BEGIN
SELECT SALARY+(SALARY*NVL(COMMISSION_PCT,0)) INTO V_SALARY FROM
EMPLOYEES WHERE EMPLOYEE_ID = IN_EMP_ID;
DBMS_OUTPUT.PUT_LINE('THE TOTAL SALARY OF EMPLOYEE '|| in_emp_id||' IS ' || V_SALARY);
END;

EXEC TOTAL_SALARY(110);


---METADATA CHECKS
SELECT * FROM USER_PROCEDURES;

SELECT * FROM USER_PROCEDURES WHERE OBJECT_TYPE = 'PROCEDURE';

SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE = 'PROCEDURE';

SELECT * FROM USER_SOURCE WHERE TYPE ='PROCEDURE' AND NAME = 'TOTAL_SALARY' ; --IT RETURNS FULL CODE OF PROCEDURE.































