---1.	Metadata Testing.

------a). Table name check.
SELECT * FROM TAB WHERE tname = 'EMPLOYEES';  ----TABLE PRESENT AS PER MAPPING SHEET.


----b). Column number count check ---> Check for number of columns in a table.
SELECT COUNT(*)  FROM user_tab_columns WHERE table_name='EMPLOYEES'; --- 11 COLUMNS PRESENT AS PER MAPPING SHEET.



------c). Column name check.
SELECT  column_name FROM  user_tab_columns where table_name = 'EMPLOYEES';  ---ALL COLUMN NAME ARE PRESENT AS PER MAPPING SHEET.
 

-----d). Column length 
-- --Data length in target should be as per mapping sheet and equal or grater than source Data length.
SELECT  column_name, data_length,data_precision,nullable FROM  user_tab_columns WHERE table_name = 'EMPLOYEES';  ---ALL COLUMN LENGTH PRESENT AS PER MAPPING SHEET.



------e). Column Datatypes --- Number(), Varchar2(), Char(), Integer(), Date.
SELECT  column_name, data_type FROM  user_tab_columns where table_name = 'EMPLOYEES'; ---ALL COLUMN DATATYPES ARE PRESENT AS PER MAPPING SHEET. 


-----f). Column Constraints --- Primary key,Unique, Check constraint, Forigen key,Default constraint, Not Null.
SELECT column_name,constraint_name FROM user_cons_columns WHERE table_name = 'EMPLOYEES'; 
					
SELECT constraint_name,constraint_type,search_condition FROM all_constraints WHERE OWNER='HR' AND table_name='EMPLOYEES'; ---ALL CONSTRAINTS PRESENT AS PER MAPPING SHEET.


----g). Column Index.
					
SELECT * FROM USER_INDEXES WHERE table_name = 'EMPLOYEES'; ---IT GIVES INDEX_NAME,INDEX_TYPE(NORMAL MEANS B-TREE INDEX), TABLE_NAME, UNIQUENESS.

SELECT * FROM USER_IND_COLUMNS WHERE table_name = 'EMPLOYEES';--- IT GIVES INDEX_NAME, TABLE_NAME, COLUMN_NAME

SELECT * FROM USER_IND_STATISTICS WHERE table_name = 'EMPLOYEES'; ---IT GIVES INDEX_NAME, TABLE_NAME, DISTINCT_KEYS(DISTINCT VALUES),AVG_LEAF_BLOCKS_PER_KEY,NUM_ROWS,LAST_ANALYZED

SELECT * FROM USER_IND_EXPRESSIONS WHERE table_name = 'EMPLOYEES';---HERE ONLY "FUNCTIONAL INDEX" ARE DISPLAYED IF PRESENT. IT GIVES INDEX_NAME, TABLE_NAME,COLUMN_EXPRESSIONS.














































