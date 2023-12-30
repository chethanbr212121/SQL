SELECT * FROM TEMPORARY1;

DESC TEMPORARY1;

------------------Structural Validation.

---Verify column names.
SELECT * FROM user_tab_columns
WHERE table_name='TEMPORARY1';

---Verify column count.
SELECT COUNT(*) 
FROM user_tab_columns
WHERE table_name='TEMPORARY1';

---Check Data type of the columns in Table.
SELECT  COLUMN_NAME, DATA_TYPE 
FROM  USER_TAB_COLUMNS 
WHERE TABLE_NAME = 'TEMPORARY1';

---Check size of the columns in Table
SELECT  column_name, data_length 
FROM  user_tab_columns 
WHERE table_name = 'TEMPORARY1';

---Check Contraints of columns in EMPLOYEES Table
SELECT column_name,constraint_name 
FROM user_cons_columns
WHERE table_name = 'TEMPORARY1';
---OR
SELECT *
FROM user_cons_columns
WHERE table_name = 'TEMPORARY1';

---
SELECT column_name,index_name 
FROM dba_ind_columns 
WHERE table_name='TEMPORARY1' AND index_owner='target';






