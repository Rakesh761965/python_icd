CREATE TABLE EM(
EMP_ID NUMBER PRIMARY KEY,
EMP_NAME VARCHAR2(50),
DEPARTMENT VARCHAR2(30),
SALARY NUMBER
);


CREATE TABLE PROJECTS(
PROJECT_ID NUMBER PRIMARY KEY,
PROJECT_NAME VARCHAR2(50),
DEPARTMENT VARCHAR2(30),
BUDGET NUMBER
);



INSERT INTO EMPLOYEES VALUES(1,'AMAN','HR',30000);
INSERT INTO EMPLOYEES VALUES(2,'ROHIT','IT',50000);
INSERT INTO EMPLOYEES VALUES(3,'PRIYA','IT',60000);
INSERT INTO EMPLOYEES VALUES(4,'NEHA','SALES',45000);
INSERT INTO EMPLOYEES VALUES(5,'KARAN','SALES',70000);
INSERT INTO EMPLOYEES VALUES(6,'SIMRAN','HR',35000);



INSERT INTO PROJECTS VALUES(101,'ALPHA','IT',200000);
INSERT INTO PROJECTS VALUES(102,'BETA','SALES',150000);
INSERT INTO PROJECTS VALUES(103,'GAMMA','HR',80000);
INSERT INTO PROJECTS VALUES(104,'DELTA','IT',250000);


-- Find employees earning more than avg salary
SELECT *FROM EM WHERE SALARY >(SELECT AVG(SALARY)FROM EMPLOYEES);

-- Employees working in dept of highest paid employee
SELECT *FROM EMWHERE DEPARTMENT =(SELECT DEPARTMENTFROM EMPLOYEES WHERE SALARY =(SELECT MAX(SALARY)FROM EMPLOYEES));

-- Employees earning more than dept avg
SELECT * FROM EM E1 WHERE SALARY >(SELECT AVG(SALARY)FROM EM E2 WHERE E1.DEPARTMENT = E2.DEPARTMENT);

-- Departments whose avg salary > 40000
SELECT * FROM (SELECT DEPARTMENT,AVG(SALARY) AVG_SALARY fROM EM GROUP BY DEPARTMENT) WHERE AVG_SALARY > 40000;

-- Employees in departments where project budget >150000
SELECT *FROM EM WHERE DEPARTMENT IN(SELECT DEPARTMENT FROM PROJECTSWHERE BUDGET > 150000);


-----------------------------------
CREATE TABLE EMPLI(EMP_ID NUMBER,EMP_NAME VARCHAR2(30),GENDER CHAR(1), SALARY NUMBER(10,2),JOINING_DATE DATE)
INSERT INTO EMPLI VALUES(1,'AMAN','M',450000.50,SYSDATE)

CREATE TABLE CUS(CUSTOMER_ID NUMBER,CUSTOMER_NAME VARCHAR2(5),CITY VARCHAR2(30),BALANCE NUMBER(10,2))

------------------------------------------------------

-------------------------


CREATE TABLE student_info (
student_id NUMBER,
student_name VARCHAR2(50),
gender CHAR(1),
dob DATE,
fees NUMBER(10,2),
email VARCHAR2(100),
admission_time TIMESTAMP
);

INSERT INTO student_info VALUES (101, 'Alice Johnson', 'F', DATE '2005-06-15', 1500.50, 'alice@example.com', TIMESTAMP '2024-09-01 09:30:00');
INSERT INTO student_info VALUES (102, 'Bob Smith', 'M', DATE '2004-11-22', 1200.75, 'bob@example.com', TIMESTAMP '2024-09-01 10:15:00');
INSERT INTO student_info VALUES (103, 'Cathy Brown', 'F', DATE '2005-02-10', 1800.00, 'cathy@example.com', TIMESTAMP '2024-09-02 08:45:00');
INSERT INTO student_info VALUES (104, 'David Lee', 'M', DATE '2004-09-05', 1600.25, 'david@example.com', TIMESTAMP '2024-09-02 11:00:00');
INSERT INTO student_info VALUES (105, 'Emma Wilson', 'F', DATE '2005-12-01', 1400.00, 'emma@example.com', TIMESTAMP '2024-09-03 14:20:00');

-- TASK 2 ALTER TABLE ADD

ALTER TABLE student_info ADD (mobile_no VARCHAR2(15));
ALTER TABLE student_info ADD (city VARCHAR2(50));

INSERT INTO student_info (student_id, mobile_no, city) VALUES (101, '9876543210', 'New York');
INSERT INTO student_info (student_id, mobile_no, city) VALUES (102, '9876543211', 'Los Angeles');
INSERT INTO student_info (student_id, mobile_no, city) VALUES (103, '9876543212', 'Chicago');
INSERT INTO student_info (student_id, mobile_no, city) VALUES (104, '9876543213', 'Houston');
INSERT INTO student_info (student_id, mobile_no, city) VALUES (105, '9876543214', 'Phoenix');

---TASK 3 ALTER TABLE MODIFY

ALTER TABLE student_info MODIFY student_name VARCHAR2(100);
ALTER TABLE student_info MODIFY email VARCHAR2(150);
ALTER TABLE student_info MODIFY fees NUMBER(12,2);

DESC student_info;


-- TASK 4 ALTER TABLE RENAME COLUMN

ALTER TABLE student_info RENAME COLUMN mobile_no TO phone_no;
ALTER TABLE student_info RENAME COLUMN dob TO date_of_birth;

SELECT * FROM student_info;

-- TASK 5 ALTER TABLE DROP COLUMN

ALTER TABLE student_info DROP COLUMN city;
ALTER TABLE student_info DROP COLUMN email;

DESC student_info;

-- TASK 6 SET UNUSED COLUMN

CREATE TABLE employee_data (
emp_id NUMBER,
emp_name VARCHAR2(50),
salary NUMBER(8,2),
department VARCHAR2(30),
temporary_field VARCHAR2(100)
);

INSERT INTO employee_data VALUES (1, 'John', 50000, 'IT', 'temp1');
INSERT INTO employee_data VALUES (2, 'Sarah', 60000, 'HR', 'temp2');
INSERT INTO employee_data VALUES (3, 'Mike', 55000, 'Finance', 'temp3');


ALTER TABLE employee_data SET UNUSED COLUMN temporary_field;
DESC employee_data;

ALTER TABLE employee_data DROP UNUSED COLUMNS;
DESC employee_data;


-- TASK 7 RENAME TABLE

CREATE TABLE course_details (
course_id NUMBER,
course_name VARCHAR2(50),
duration_months NUMBER
);

INSERT INTO course_details VALUES (101, 'Mathematics', 6);
INSERT INTO course_details VALUES (102, 'Physics', 5);
INSERT INTO course_details VALUES (103, 'Computer Science', 4);

RENAME course_details TO courses;

SELECT * FROM courses;

-- TASK 8 TRUNCATE  DROP

CREATE TABLE product_data (
product_id NUMBER,
product_name VARCHAR2(50),
price NUMBER(8,2)
);

INSERT INTO product_data VALUES (1, 'Laptop', 75000);
INSERT INTO product_data VALUES (2, 'Mouse', 500);
INSERT INTO product_data VALUES (3, 'Keyboard', 1200);
INSERT INTO product_data VALUES (4, 'Monitor', 15000);
INSERT INTO product_data VALUES (5, 'Printer', 8000);


TRUNCATE TABLE product_data;
SELECT * FROM product_data; -- No rows

INSERT INTO product_data VALUES (6, 'Tablet', 25000);
INSERT INTO product_data VALUES (7, 'Speaker', 3000);
COMMIT;

DROP TABLE product_data;
-- SELECT * FROM product_data; -- Error: table does not exist

-- Difference between DELETE, TRUNCATE, DROP:
-- DELETE: DML, removes specific rows, can rollback, slow, triggers fire
-- TRUNCATE: DDL, removes all rows, cannot rollback, fast, no triggers, reset HWM
-- DROP: DDL, removes entire table structure, cannot rollback, fastest

-- TASK 10 CREATE COMMENT & VIEW COMMENTS

CREATE TABLE hospital (
hospital_id NUMBER,
hospital_name VARCHAR2(100),
location VARCHAR2(80),
bed_count NUMBER
);

INSERT INTO hospital VALUES (1, 'City Hospital', 'New York', 500);
INSERT INTO hospital VALUES (2, 'Memorial Medical', 'Los Angeles', 750);
INSERT INTO hospital VALUES (3, 'St. Marys Hospital', 'Chicago', 300);

COMMENT ON TABLE hospital IS 'Stores information about hospitals in the healthcare system';
COMMENT ON COLUMN hospital.hospital_id IS 'Unique identifier for each hospital (Primary Key)';
COMMENT ON COLUMN hospital.hospital_name IS 'Official name of the hospital';
COMMENT ON COLUMN hospital.location IS 'City and state where hospital is located';

SELECT table_name, comments FROM USER_TAB_COMMENTS WHERE table_name = 'HOSPITAL';
SELECT column_name, comments FROM USER_COL_COMMENTS WHERE table_name = 'HOSPITAL';



------------------------------------------------------------------------

-- TASK 1: Create DEPTS 
CREATE TABLE DEPTS (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(100) NOT NULL,
dept_location VARCHAR(100)
);

-- TASK 2: Create EMPLOYEES_DAta
CREATE TABLE EMPLOYEES_DATA (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(100) NOT NULL,
emp_salary DECIMAL(10,2),
emp_hire_date DATE,
emp_email VARCHAR(100) UNIQUE NOT NULL,
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES DEPTS(dept_id)
);

-- TASK 3: Create PROJECTS_Lst
CREATE TABLE PROJECTS_LIST (
proj_id INT PRIMARY KEY,
proj_name VARCHAR(100) NOT NULL,
proj_budget DECIMAL(12,2),
proj_start_date DATE,
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES DEPTS(dept_id)
);

-- TASK 4: Create SALARY_HISTORY
CREATE TABLE SALARY_HISTORY_LOG (
history_id INT PRIMARY KEY,
emp_id INT,
old_salary DECIMAL(10,2),
new_salary DECIMAL(10,2),
changed_date DATE,
FOREIGN KEY (emp_id) REFERENCES EMPLOYEES_DATA(emp_id)
);

-- TASK 5: ALTER TABLE ADD Column 
ALTER TABLE EMPLOYEES_DATA ADD (phone_number VARCHAR(15));

-- TASK 6: ALTER TABLE MODIFY Column 
ALTER TABLE EMPLOYEES_DATA MODIFY emp_salary DECIMAL(12,2);

-- TASK 7: ALTER TABLE RENAME COLUMN
ALTER TABLE EMPLOYEES_DATA RENAME COLUMN phone_number TO mobile_number;

-- TASK 8: SET UNUSED COLUMN
ALTER TABLE EMPLOYEES_DATA SET UNUSED COLUMN mobile_number;

-- TASK 9: DROP UNUSED COLUMNS
ALTER TABLE EMPLOYEES_DATA DROP UNUSED COLUMNS;

-- TASK 10: RENAME TABLE 
RENAME PROJECTS_LIST TO COMPANY_PROJECTS;

-- TASK 11: TRUNCATE TABLE
TRUNCATE TABLE SALARY_HISTORY_LOG;

-- TASK 12: FLASHBACK TABLE 
FLASHBACK TABLE SALARY_HISTORY_LOG TO BEFORE TRUNCATE;

-- TASK 13: DROP TABLE
DROP TABLE COMPANY_PROJECTS;

-- TASK 14: CREATE COMMENTS 
COMMENT ON TABLE EMPLOYEES_DATA IS 'Stores all employee personal and job information';
COMMENT ON COLUMN EMPLOYEES_DATA.emp_salary IS 'Monthly salary of employee in USD';

-- TASK 15: VIEW COMMENTS
SELECT * FROM USER_TAB_COMMENTS WHERE TABLE_NAME = 'EMPLOYEES_DATA';
SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME = 'EMPLOYEES_DATA';


-- TASK 16: Basic INSERT 
INSERT INTO DEPTS VALUES (10, 'IT', 'New York');
INSERT INTO DEPTS VALUES (20, 'HR', 'London');
INSERT INTO DEPTS VALUES (30, 'Finance', 'Delhi');
INSERT INTO DEPTS VALUES (40, 'Marketing', 'Mumbai');
INSERT INTO DEPTS VALUES (50, 'Sales', 'Delhi');


-- TASK 17: INSERT Using Functions
INSERT INTO EMPLOYEES_DATA (emp_id, emp_name, emp_salary, emp_hire_date, emp_email, dept_id)
VALUES (101, UPPER('john doe'), 60000, SYSDATE, LOWER('John.Doe@email.com'), 10);

INSERT INTO EMPLOYEES_DATA (emp_id, emp_name, emp_salary, emp_hire_date, emp_email, dept_id)
VALUES (102, UPPER('jane smith'), 75000, SYSDATE, LOWER('Jane.Smith@email.com'), 20);

INSERT INTO EMPLOYEES_DATA (emp_id, emp_name, emp_salary, emp_hire_date, emp_email, dept_id)
VALUES (103, UPPER('bob wilson'), 55000, SYSDATE, LOWER('Bob.Wilson@email.com'), 30);

INSERT INTO EMPLOYEES_DATA (emp_id, emp_name, emp_salary, emp_hire_date, emp_email, dept_id)
VALUES (104, UPPER('alice brown'), 80000, SYSDATE, LOWER('Alice.Brown@email.com'), 10);

INSERT INTO EMPLOYEES_DATA (emp_id, emp_name, emp_salary, emp_hire_date, emp_email, dept_id)
VALUES (105, UPPER('charlie davis'), 45000, SYSDATE, LOWER('Charlie.Davis@email.com'), 40);
COMMIT;

-- TASK 18: INSERT Using Sub
INSERT INTO SALARY_HISTORY_LOG (history_id, emp_id, old_salary, new_salary, changed_date)
SELECT ROWNUM, emp_id, emp_salary, emp_salary, SYSDATE
FROM EMPLOYEES_DATA
WHERE emp_salary > 50000;

-- TASK 19: Multi Table Insert
INSERT ALL
INTO EMPLOYEES_DATA (emp_id, emp_name, emp_salary, emp_hire_date, emp_email, dept_id)
VALUES (106, 'DAVID MILLER', 70000, SYSDATE, 'david@email.com', 30)
INTO SALARY_HISTORY_LOG (history_id, emp_id, old_salary, new_salary, changed_date)
VALUES (10, 106, NULL, 70000, SYSDATE)
SELECT * FROM DUAL;


-- TASK 20: Basic UPDATE 
UPDATE EMPLOYEES_DATA SET emp_salary = emp_salary * 1.10;
COMMIT;

-- TASK 21: UPDATE Using Functions 
UPDATE EMPLOYEES_DATA SET emp_email = LOWER(emp_email);
COMMIT;

-- TASK 22: UPDATE Using Sub Query
-- First create bonus table
CREATE TABLE DEPT_BONUS (dept_id INT, bonus_amount DECIMAL(10,2));
INSERT INTO DEPT_BONUS VALUES (10, 5000);
INSERT INTO DEPT_BONUS VALUES (20, 3000);
INSERT INTO DEPT_BONUS VALUES (30, 4000);
COMMIT;

UPDATE EMPLOYEES_DATA e
SET emp_salary = emp_salary + (SELECT bonus_amount FROM DEPT_BONUS db WHERE db.dept_id = e.dept_id)
WHERE EXISTS (SELECT 1 FROM DEPT_BONUS db WHERE db.dept_id = e.dept_id);
COMMIT;


-- TASK 23: Scalar Sub Query
SELECT emp_name AS EMPLOYEE_NAME,
(SELECT AVG(emp_salary) FROM EMPLOYEES_DATA) AS AVG_SALARY
FROM EMPLOYEES_DATA;

-- TASK 24: Nested Sub Query
SELECT emp_name, emp_salary
FROM EMPLOYEES_DATA
WHERE emp_salary > (SELECT AVG(emp_salary) FROM EMPLOYEES_DATA WHERE dept_id = 10);

-- TASK 25: Co-Related Sub Query 
SELECT emp_name, emp_salary, dept_id
FROM EMPLOYEES_DATA e1
WHERE emp_salary = (SELECT MAX(emp_salary) FROM EMPLOYEES_DATA e2 WHERE e2.dept_id = e1.dept_id);

-- TASK 26: In-Line View
SELECT * FROM (
SELECT emp_name, emp_salary
FROM EMPLOYEES_DATA
ORDER BY emp_salary DESC
) WHERE ROWNUM <= 3;

-- TASK 27: Retrieve Data Using Sub Query
SELECT emp_name
FROM EMPLOYEES_DATA
WHERE dept_id IN (SELECT dept_id FROM DEPTS WHERE dept_location = 'Delhi');


-- TASK 28: MERGE Statement 
-- Create EMPLOYEE_NEW table first
CREATE TABLE EMPLOYEE_NEW (
emp_id INT,
emp_name VARCHAR(100),
emp_salary DECIMAL(10,2),
emp_email VARCHAR(100),
dept_id INT
);

INSERT INTO EMPLOYEE_NEW VALUES (101, 'john doe updated', 65000, 'john.new@email.com', 10);
INSERT INTO EMPLOYEE_NEW VALUES (107, 'eve white', 48000, 'eve@email.com', 50);


MERGE INTO EMPLOYEES_DATA e
USING EMPLOYEE_NEW en
ON (e.emp_id = en.emp_id)
WHEN MATCHED THEN
UPDATE SET e.emp_name = en.emp_name, e.emp_salary = en.emp_salary, e.emp_email = en.emp_email
WHEN NOT MATCHED THEN
INSERT (emp_id, emp_name, emp_salary, emp_hire_date, emp_email, dept_id)
VALUES (en.emp_id, en.emp_name, en.emp_salary, SYSDATE, en.emp_email, en.dept_id);


-- TASK 29: MERGE Enhancement
MERGE INTO EMPLOYEES_DATA e
USING EMPLOYEE_NEW en
ON (e.emp_id = en.emp_id)
WHEN MATCHED THEN
UPDATE SET e.emp_salary = en.emp_salary
DELETE WHERE e.emp_salary < 20000
WHEN NOT MATCHED THEN
INSERT (emp_id, emp_name, emp_salary, emp_hire_date, emp_email, dept_id)
VALUES (en.emp_id, en.emp_name, en.emp_salary, SYSDATE, en.emp_email, en.dept_id);


-- TASK 30: COMMIT, ROLLBACK, SAVEPOINT

-- Step 1: Insert records
INSERT INTO DEPTS VALUES (60, 'Support', 'Chennai');
INSERT INTO EMPLOYEES_DATA VALUES (108, 'FRANK MILLER', 35000, SYSDATE, 'frank@email.com', 60);
COMMIT;

-- Step 2: Create SAVEPOINT
SAVEPOINT before_update;

-- Step 3: Update records
UPDATE EMPLOYEES_DATA SET emp_salary = emp_salary + 10000 WHERE dept_id = 60;

-- Check data after update
SELECT * FROM EMPLOYEES_DATA WHERE dept_id = 60;

-- Step 4: Rollback to SAVEPOINT
ROLLBACK TO before_update;

-- Check data after rollback
SELECT * FROM EMPLOYEES_DATA WHERE dept_id = 60;

-- Step 5: Commit transaction
COMMIT;

-- Final check
SELECT * FROM EMPLOYEES_DATA;
SELECT * FROM DEPTS;
SELECT * FROM SALARY_HISTORY_LOG;