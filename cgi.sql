select count(EMPLOYEE_ID), count(JOB_ID), count(COMMISSION_PCT), count(department_id) from employees;


select * from employees;


select count(*) from (
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
from employees
where EMPLOYEE_ID is null or
FIRST_NAME is null or
LAST_NAME is null or
EMAIL is null or
PHONE_NUMBER is null or
HIRE_DATE is null or
JOB_ID is null or
SALARY is null or
COMMISSION_PCT is null or
MANAGER_ID is null or
DEPARTMENT_ID is null);


select count(*) from (
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
from employees
where EMPLOYEE_ID is not null and
FIRST_NAME is not null and
LAST_NAME is not null and
EMAIL is not null and
PHONE_NUMBER is not null and
HIRE_DATE is not null and
JOB_ID is not null and
SALARY is not null and
COMMISSION_PCT is not null and
MANAGER_ID is not null and
DEPARTMENT_ID is not null);

select nullcount, count(*) from (
select case when COMMISSION_PCT is null then 'null'
    when length(COMMISSION_PCT)=0 then 'empty'
    else 'Not empty' end as nullcount from employees)
    group by nullcount;





select count(unique salary) from employees ;

select count(unique salary) from (
select salary, dense_rank() over(partition by salary order by employee_id) rank from employees)
where rank >1;

select * from employees;

select count(distinct DEPARTMENT_ID) from employees;

select count(*) from employees
where JOB_ID = 'ST_CLERK';







