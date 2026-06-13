-------------CREATING VIEW
CREATE TABLE EMK(EMP_ID NUMBER,EMP_NAME VARCHAR2(50),SALARY NUMBER,DEPARTMENT VARCHAR2(20))
CREATE VIEW EMP_VIEW AS SELECT EMP_ID,EMP_NAME,DEPARTMENT FROM EMK
INSERT INTO EMK VALUES(103,'JK',45000,'HR')
SELECT * FROM EMP_VIEW

---------
CREATE VIEW READONLY_VIEW AS SELECT * FROM EMK WITH READ ONLY 
CREATE VIEW SALARY_VIEW AS SELECT DEPARTMENT,AVG(SALARY) AVGSALARY FROM EMK GROUP BY DEPARTMENT
SELECT  * FROM SALARY_VIEW
CREATE OR REPLACE VIEW EMP_VIEWS AS SELECT EMP_ID,EMP_NAME FROM EMK
SELECT * FROM EMP_VIEWS
CREATE SEQUENCE EMP_SEQ START WITH 1 INCREMENT BY 1 MAXVALUE 9999 NOCYCLE
SELECT EMP_SEQ.NEXTVAL FROM DUAL
----------------------------------

CREATE TABLE staff
(
emp_id NUMBER,
emp_name VARCHAR2(50),
salary NUMBER,
department VARCHAR2(30),
joining_date DATE
);

INSERT INTO staff VALUES(101, 'Rahul', 50000, 'IT', '10-JAN-22');
INSERT INTO staff VALUES(102, 'Amit', 45000, 'HR', '15-FEB-22');
INSERT INTO staff VALUES(103, 'Neha', 60000, 'IT', '20-MAR-22');
INSERT INTO staff VALUES(104, 'Priya', 40000, 'Finance', '05-APR-22');
INSERT INTO staff VALUES(105, 'Karan', 55000, 'HR', '12-MAY-22');



CREATE VIEW emp_basic_view AS
SELECT emp_id, emp_name
FROM staff;


-- TASK 2 – Display Data from View

SELECT * FROM emp_basic_view;


-- TASK 3 – Create View with WHERE Condition

CREATE VIEW it_emp_view AS
SELECT emp_id, emp_name, department FROM staff WHERE department = 'IT';


-- TASK 4 – Create Salary View

CREATE VIEW salary_viewss AS SELECT emp_name, salary FROM staff WHERE salary > 50000;


-- TASK 5 – Create Read Only View

CREATE VIEW readonly_emp_view AS SELECT emp_id, emp_name, department FROM staff WITH READ ONLY;

-- TASK 6 – Replace Existing View

CREATE OR REPLACE VIEW emp_basic_view AS SELECT emp_id, emp_name, department FROM staff;

-- TASK 7 – Create Complex View

CREATE VIEW dept_avg_salary_view ASSELECT department, AVG(salary) AS average_salaryFROM staff
GROUP BY department;


-- TASK 8 – Create Inline View Query

SELECT * FROM (SELECT emp_id, emp_name, salary, department,AVG(salary) OVER() AS overall_avg_salary FROM staff)
WHERE salary > overall_avg_salary;

-- Alternative inline view querY
SELECT * FROM staff WHERE salary > (SELECT AVG(salary) FROM staff);



---------------------------------------------------------------------------------
CREATE TABLE employees_new
(
emp_id NUMBER,
emp_name VARCHAR2(50),
salary NUMBER,
department VARCHAR2(30),
joining_date DATE
);


INSERT INTO employees_new VALUES(101, 'Rahul', 50000, 'IT', TO_DATE('10-JAN-22', 'DD-MON-YY'));
INSERT INTO employees_new VALUES(102, 'Amit', 45000, 'HR', TO_DATE('15-FEB-22', 'DD-MON-YY'));
INSERT INTO employees_new VALUES(103, 'Neha', 60000, 'Finance', TO_DATE('20-MAR-22', 'DD-MON-YY'));


CREATE OR REPLACE VIEW emp_view_new AS
SELECT emp_id, emp_name, department FROM employees_new;

-- TASK 2: Retrieve Data from View
SELECT * FROM emp_view_new;


-- TASK 3: Create Read Only View
CREATE OR REPLACE VIEW readonly_emp_view_new AS
SELECT emp_id, emp_name, salary
FROM employees_new
WITH READ ONLY;

-- TASK 5: Create Sequence
CREATE SEQUENCE emp_seq_new
START WITH 200
INCREMENT BY 1
MAXVALUE 9999
NOCYCLE
NOCACHE;

-- TASK 6: Insert Data Using Sequence
INSERT INTO employees_new (emp_id, emp_name, salary, department, joining_date)
VALUES (emp_seq_new.NEXTVAL, 'Priya', 55000, 'IT', SYSDATE);

-- TASK 7: Create Index
CREATE INDEX emp_index_new ON employees_new(emp_name);


-- TASK 8: View Index Information
SELECT index_name, table_name FROM USER_INDEXES WHERE table_name = 'EMPLOYEES_NEW';


-- TASK 9: Create Backup Table
CREATE TABLE emp_backup_new AS SELECT * FROM employees_new;

-- TASK 10: Perform MERGE Operation
MERGE INTO emp_backup_new e_back
USING employees_new e
ON (e_back.emp_id = e.emp_id)
WHEN MATCHED THEN
UPDATE SET e_back.salary = e.salary
WHEN NOT MATCHED THEN
INSERT (emp_id, emp_name, salary, department, joining_date)
VALUES (e.emp_id, e.emp_name, e.salary, e.department, e.joining_date);


-- TASK 11: Retrieve Merged Data
SELECT * FROM emp_backup_new;


-- TASK 12: Create Audit Table
CREATE TABLE salary_audit_new (
emp_id NUMBER,
old_salary NUMBER,
new_salary NUMBER,
audit_date DATE DEFAULT SYSDATE
);

----Task 13 
CREATE TABLE salary_audit (
emp_id NUMBER,
old_salary NUMBER,
new_salary NUMBER
);

-- CREATE PROCEDURE

CREATE OR REPLACE PROCEDURE update_salary (
p_emp_id NUMBER,
p_new_salary NUMBER)
IS
v_old_salary NUMBER;
BEGIN

-- FETCH OLD SALARY
SELECT salary INTO v_old_salary FROM employees_new WHERE emp_id = p_emp_id FOR UPDATE;

-- UPDATE NEW SALARY
UPDATE employees_new SET salary = p_new_salary WHERE emp_id = p_emp_id;

-- STORE OLD AND NEW SALARY
INSERT INTO salary_audit VALUES (p_emp_id, v_old_salary, p_new_salary);

COMMIT;
END;

-- TASK 14 : EXECUTE PROCEDURE

BEGIN
update_salary(101, 50000);
END;

SELECT * FROM employees_new;

SELECT * FROM salary_audit;

-- TASK 15 : DROP SALARY COLUMN

ALTER TABLE employees_new
DROP COLUMN salary;

SELECT object_name, status FROM user_objects WHERE status = 'INVALID';

ALTER PROCEDURE update_salary COMPILE;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
------------------------------------------------------------------------------


CREATE TABLE departments_demo (
dept_id NUMBER PRIMARY KEY,
dept_name VARCHAR2(50),
location VARCHAR2(50)
);

CREATE TABLE employees_demo (
emp_id NUMBER PRIMARY KEY,
emp_name VARCHAR2(50),
salary NUMBER(10,2),
dept_id NUMBER,
hire_date DATE
);

-- Insert sample data
INSERT INTO departments_demo VALUES (10, 'IT', 'New York');
INSERT INTO departments_demo VALUES (20, 'HR', 'London');
INSERT INTO departments_demo VALUES (30, 'Sales', 'Tokyo');

INSERT INTO employees_demo VALUES (1, 'Alice', 60000, 10, DATE '2020-01-15');
INSERT INTO employees_demo VALUES (2, 'Bob', 45000, 20, DATE '2019-03-20');
INSERT INTO employees_demo VALUES (3, 'Charlie', 70000, 10, DATE '2021-06-10');


-- TASK 1:
CREATE VIEW vw_emp_details AS
SELECT emp_id, emp_name, salary, dept_id
FROM employees_demo;

-- Query the view
SELECT * FROM vw_emp_details;

-- Insert into base table and verify
INSERT INTO employees_demo VALUES (4, 'Diana', 55000, 30, DATE '2022-02-28');
SELECT * FROM vw_emp_details WHERE emp_id = 4;

-- TASK 2: Read Only View
CREATE VIEW vw_high_salary AS
SELECT emp_id, emp_name, salary, dept_id
FROM employees_demo
WHERE salary > 50000
WITH READ ONLY;


-- TASK 3: Complex View
CREATE VIEW vw_dept_summary AS
SELECT e.emp_name, e.salary, d.dept_name, d.location
FROM employees_demo e
INNER JOIN departments_demo d ON e.dept_id = d.dept_id
ORDER BY e.salary DESC;

SELECT * FROM vw_dept_summary;




