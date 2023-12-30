SELECT 
    DECODE(GROUPING(department_name), 1, 'ALL DEPARTMENTS', department_name)
      AS department,
    DECODE(GROUPING(job_id), 1, 'All Jobs', job_id) AS job,
    COUNT(*) "Total Empl",
    TRUNC(AVG(salary) * 12) "Average Sal"
  FROM hr.employees e, departments d
  WHERE d.department_id = e.department_id
  GROUP BY ROLLUP (department_name, job_id)
  ORDER BY department, job;  
  
  
SELECT department_id, STATS_MODE(salary) FROM employees
   GROUP BY department_id
   ORDER BY department_id, stats_mode(salary);


   
SELECT department_id, (salary) FROM employees 
WHERE department_id=50 AND SALARY=2200;


SELECT SALARY,COUNT(salary) FROM employees 
WHERE department_id=80
GROUP BY SALARY
ORDER BY SALARY;




select count(*) 
from user_tab_columns
where table_name='EMPLOYEES';

SELECT  column_name, data_type FROM  user_tab_columns where table_name = 'EMPLOYEES';


SELECT  column_name, data_length FROM  user_tab_columns where table_name = 'EMPLOYEES';

SELECT column_name,constraint_name from user_cons_columns where table_name = 'EMPLOYEES';













  
COMMIT;  
  
SELECT * FROM hr.employees;



SELECT * FROM hr.WORLD_DATA;