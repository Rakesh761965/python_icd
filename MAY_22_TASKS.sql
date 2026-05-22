CREATE TABLE emp_master (id NUMBER, name VARCHAR2(20), dept_id NUMBER);
CREATE TABLE dept_master (dept_id NUMBER, dept_name VARCHAR2(20));

INSERT INTO dept_master VALUES (1, 'IT');
INSERT INTO dept_master VALUES (2, 'HR');

CREATE VIEW emp_view AS
SELECT e.id, e.name, d.dept_name
FROM emp_master e JOIN dept_master d ON e.dept_id = d.dept_id;

CREATE TRIGGER trg1
INSTEAD OF INSERT ON emp_view
FOR EACH ROW
BEGIN
INSERT INTO emp_master VALUES (:NEW.id, :NEW.name,
(SELECT dept_id FROM dept_master WHERE dept_name = :NEW.dept_name));
DBMS_OUTPUT.PUT_LINE('Inserted: ' || :NEW.name);
END;
/

INSERT INTO emp_view VALUES (1, 'Ali', 'IT');
SELECT * FROM emp_master;
SELECT * FROM dept_master;
select * from emp_view;



------------------------------------------
CREATE TABLE students (id NUMBER, name VARCHAR2(20), course_id NUMBER);
CREATE TABLE coursess (course_id NUMBER, course_name VARCHAR2(20));

INSERT INTO coursess VALUES (1, 'SQL');
INSERT INTO coursess VALUES (2, 'Java');

CREATE VIEW stu_view AS
SELECT s.id, s.name, c.course_name
FROM students s, coursess c
WHERE s.course_id = c.course_id;

CREATE TRIGGER trg22
INSTEAD OF INSERT ON stu_view
FOR EACH ROW
BEGIN
INSERT INTO students VALUES (:NEW.id, :NEW.name,
(SELECT course_id FROM coursess WHERE course_name = :NEW.course_name));
DBMS_OUTPUT.PUT_LINE('Inserted: ' || :NEW.name);
END;
/

INSERT INTO stu_view VALUES (101, 'Bob', 'SQL');
SELECT * FROM STUDENTS


-----------------------------------------
------------------------------------------------------
--------task2

-- BEFORE INSERT trigger
CREATE OR REPLACE TRIGGER trg_bi
BEFORE INSERT ON emp
FOR EACH ROW
BEGIN
:NEW.date := SYSDATE;
END;
/

-- AFTER UPDATE trigger
CREATE OR REPLACE TRIGGER trg_au
AFTER UPDATE ON emp
FOR EACH ROW
BEGIN
INSERT INTO audit VALUES (:OLD.id, :OLD.sal, :NEW.sal, SYSDATE);
END;
/

-- Prevent negative salary
CREATE OR REPLACE TRIGGER trg_no_neg
BEFORE INSERT OR UPDATE ON emp
FOR EACH ROW
BEGIN
IF :NEW.sal < 0 THEN
RAISE_APPLICATION_ERROR(-20001, 'Negative salary');
END IF;
END;
/

-- DELETE audit trigger
CREATE TABLE del_audit (id NUMBER, del_date DATE);

CREATE OR REPLACE TRIGGER trg_del
AFTER DELETE ON emp
FOR EACH ROW
BEGIN
INSERT INTO del_audit VALUES (:OLD.id, SYSDATE);
END;
/

-- LOGON trigger
CREATE TABLE log_log (user VARCHAR2(50), log_time DATE);

CREATE OR REPLACE TRIGGER trg_logon
AFTER LOGON ON DATABASE
BEGIN
INSERT INTO log_log VALUES (USER, SYSDATE);
COMMIT;
END;
/

-- DDL trigger for DROP
CREATE OR REPLACE TRIGGER trg_drop
BEFORE DROP ON SCHEMA
BEGIN
RAISE_APPLICATION_ERROR(-20002, 'DROP blocked');
END;
/

-- Trigger using :NEW
CREATE OR REPLACE TRIGGER trg_new
BEFORE INSERT ON emp
FOR EACH ROW
BEGIN
:NEW.name := UPPER(:NEW.name);
END;
/

-- Trigger using :OLD
CREATE OR REPLACE TRIGGER trg_old
BEFORE UPDATE ON emp
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE(:OLD.sal);
END;
/

-- Disable and enable trigger
ALTER TRIGGER trg_bi DISABLE;
ALTER TRIGGER trg_bi ENABLE;

-- View trigger information
SELECT trigger_name, status FROM USER_TRIGGERS;

-- Create dependent view
CREATE VIEW emp_view AS SELECT id, name FROM emp;

-- Invalidate object
ALTER TABLE emp ADD (x NUMBER);

-- Recompile invalid object
ALTER VIEW emp_view COMPILE;

-- Query USER_DEPENDENCIES
SELECT name, referenced_name FROM USER_DEPENDENCIES;

-- Check Oracle background processes
SELECT name FROM V$BGPROCESS WHERE paddr <> '00';

-------------------------------------------------------------------
--------------------------------------------------------------------
--------task 3

CREATE TABLE employee_master (
emp_id NUMBER PRIMARY KEY,
emp_name VARCHAR2(100),
salary NUMBER,
department VARCHAR2(50)
);

INSERT INTO employee_master VALUES (101, 'Alice', 50000, 'IT');
INSERT INTO employee_master VALUES (102, 'Bob', 60000, 'HR');
INSERT INTO employee_master VALUES (103, 'Charlie', 55000, 'IT');
INSERT INTO employee_master VALUES (104, 'Diana', 70000, 'Finance');
INSERT INTO employee_master VALUES (105, 'Eve', 48000, 'HR');
COMMIT;

---  BEFORE INSERT TRIGGER
CREATE OR REPLACE TRIGGER trg_before_insert
BEFORE INSERT ON employee_master
FOR EACH ROW
BEGIN
DBMS_OUTPUT.PUT_LINE('Employee Record Being Inserted: ' || :NEW.emp_name);
END;
/

--  PREVENT NEGATIVE SALARY 
CREATE OR REPLACE TRIGGER trg_no_negative
BEFORE UPDATE ON employee_master
FOR EACH ROW
BEGIN
IF :NEW.salary < 0 THEN
RAISE_APPLICATION_ERROR(-20001, 'Salary cannot be negative');
END IF;
END;
/

------ DELETE AUDIT TRIGGER
CREATE TABLE employee_delete_audit (
emp_id NUMBER,
emp_name VARCHAR2(100),
deleted_date DATE
);

CREATE OR REPLACE TRIGGER trg_audit_delete
AFTER DELETE ON employee_master
FOR EACH ROW
BEGIN
INSERT INTO employee_delete_audit VALUES (:OLD.emp_id, :OLD.emp_name, SYSDATE);
END;
/

--  TASK 6: SALARY HISTORY 
CREATE TABLE salary_history (
emp_id NUMBER,
old_salary NUMBER,
new_salary NUMBER,
updated_date DATE
);

CREATE OR REPLACE TRIGGER trg_salary_history
BEFORE UPDATE ON employee_master
FOR EACH ROW
BEGIN
INSERT INTO salary_history VALUES (:OLD.emp_id, :OLD.salary, :NEW.salary, SYSDATE);
END;
/

--  STATEMENT LEVEL TRIGGER 
CREATE OR REPLACE TRIGGER trg_stmt_level
AFTER UPDATE ON employee_master
BEGIN
DBMS_OUTPUT.PUT_LINE('UPDATE statement executed on employee_master');
END;
/

-- WHEN CLAUSE (IT DEPARTMENT ONLY) 
CREATE OR REPLACE TRIGGER trg_it_only
BEFORE UPDATE ON employee_master
FOR EACH ROW
WHEN (OLD.department = 'IT')
BEGIN
DBMS_OUTPUT.PUT_LINE('Updating IT employee: ' || :OLD.emp_name);
END;
/

--  INSTEAD OF TRIGGER 
CREATE TABLE dept_table (
dept_id NUMBER PRIMARY KEY,
dept_name VARCHAR2(50)
);

INSERT INTO dept_table VALUES (10, 'IT');
INSERT INTO dept_table VALUES (20, 'HR');

CREATE VIEW emp_dept_view AS
SELECT e.emp_id, e.emp_name, e.salary, d.dept_name
FROM employee_master e, dept_table d
WHERE e.department = d.dept_name;

CREATE OR REPLACE TRIGGER trg_instead_insert
INSTEAD OF INSERT ON emp_dept_view
FOR EACH ROW
BEGIN
INSERT INTO employee_master VALUES (:NEW.emp_id, :NEW.emp_name, :NEW.salary, :NEW.dept_name);
END;
/

--  DISABLE AND ENABLE TRIGGER 
ALTER TRIGGER trg_before_insert DISABLE;
ALTER TRIGGER trg_before_insert ENABLE;

--  DDL LOG TABLE & TRIGGER 
CREATE TABLE ddl_activity_log (
username VARCHAR2(50),
object_name VARCHAR2(100),
operation VARCHAR2(30),
event_date DATE
);

CREATE OR REPLACE TRIGGER trg_ddl_audit
AFTER CREATE OR ALTER OR DROP ON SCHEMA
BEGIN
INSERT INTO ddl_activity_log VALUES (USER, ORA_DICT_OBJ_NAME, ORA_SYSEVENT, SYSDATE);
END;
/

--  RESTRICT DROP TABLE 
CREATE OR REPLACE TRIGGER trg_no_drop
BEFORE DROP ON SCHEMA
BEGIN
IF ORA_DICT_OBJ_TYPE = 'TABLE' THEN
RAISE_APPLICATION_ERROR(-20002, 'Dropping tables is not allowed');
END IF;
END;
/

-- LOGON TRIGGER
CREATE TABLE user_login_history (
username VARCHAR2(50),
login_time DATE
);

CREATE OR REPLACE TRIGGER trg_logon
AFTER LOGON ON DATABASE
BEGIN
INSERT INTO user_login_history VALUES (USER, SYSDATE);
COMMIT;
END;
/

--  SERVERERROR TRIGGER 
CREATE TABLE server_error_log (
username VARCHAR2(50),
error_date DATE
);

CREATE OR REPLACE TRIGGER trg_server_error
AFTER SERVERERROR ON DATABASE
BEGIN
INSERT INTO server_error_log VALUES (USER, SYSDATE);
COMMIT;
END;
/

--  STARTUP TRIGGER 
CREATE TABLE startup_log (
startup_time DATE
);

CREATE OR REPLACE TRIGGER trg_startup
AFTER STARTUP ON DATABASE
BEGIN
INSERT INTO startup_log VALUES (SYSDATE);
COMMIT;
END;
/

--  CREATE DEPENDENCY OBJECTS 
CREATE TABLE depend_table (id NUMBER, name VARCHAR2(50));
CREATE VIEW depend_view AS SELECT id, name FROM depend_table;

CREATE OR REPLACE PROCEDURE depend_proc AS
v_name VARCHAR2(50);
BEGIN
SELECT name INTO v_name FROM depend_view WHERE id = 1;
DBMS_OUTPUT.PUT_LINE(v_name);
END;
/

--  INVALIDATE OBJEC
ALTER TABLE depend_table ADD (salary NUMBER);

SELECT object_name, object_type, status FROM USER_OBJECTS
WHERE object_name IN ('DEPEND_VIEW', 'DEPEND_PROC');

--  VIEW DEPENDENCIES 
SELECT name, type, referenced_name, referenced_type
FROM USER_DEPENDENCIES
WHERE name IN ('DEPEND_VIEW', 'DEPEND_PROC');

--  DATABASE ARCHITECTURE MONITORING
SELECT * FROM V$SGA;
SELECT instance_name, host_name, version, status FROM V$INSTANCE;
SELECT name, db_unique_name, open_mode FROM V$DATABASE;
SELECT pid, name, description FROM V$BGPROCESS WHERE paddr <> '00';
