SELECT * FROM BSEIT;

DESC BSEIT;

---Verify column names.
SELECT * 
FROM user_tab_columns
WHERE table_name='BSEIT';

---Verify column count.
SELECT COUNT(*) 
FROM user_tab_columns
WHERE table_name='BSEIT';


---Check Data type of the columns in Table.
SELECT  column_name, data_type 
FROM  user_tab_columns 
WHERE table_name = 'BSEIT';

---Check size of the columns in Table
SELECT  column_name, data_length 
FROM  user_tab_columns 
WHERE table_name = 'BSEIT';

---Check Contraints of columns in EMPLOYEES Table
SELECT column_name,constraint_name 
FROM user_cons_columns
WHERE table_name = 'BSEIT';

---
SELECT column_name,index_name 
FROM dba_ind_columns 
WHERE table_name='BSEIT' AND index_owner='chetu';
