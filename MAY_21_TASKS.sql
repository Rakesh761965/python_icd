CREATE OR REPLACE FUNCTION calculate_bonus(p_salary NUMBER, p_exp NUMBER)
RETURN NUMBER IS
BEGIN
IF p_exp >= 10 THEN RETURN p_salary * 0.30;
ELSIF p_exp >= 5 THEN RETURN p_salary * 0.20;
ELSE RETURN p_salary * 0.10;
END IF;
END;
/

SELECT calculate_bonus(50000, 8) FROM dual;

-----------------------------
CREATE OR REPLACE FUNCTION student_grade(p_name VARCHAR2, p_marks NUMBER)
RETURN VARCHAR2 IS
BEGIN
IF p_marks >= 90 THEN RETURN p_name || ' : Grade A';
ELSIF p_marks >= 75 THEN RETURN p_name || ' : Grade B';
ELSIF p_marks >= 60 THEN RETURN p_name || ' : Grade C';
ELSE RETURN p_name || ' : FAIL';
END IF;
END;
/

SELECT student_grade('Harsh', 92) FROM dual;

--------------------------------------------
CREATE OR REPLACE FUNCTION loan_status(p_salary NUMBER, p_cibil NUMBER)
RETURN VARCHAR2 IS
BEGIN
IF p_salary >= 40000 AND p_cibil >= 750 THEN RETURN 'Eligible';
ELSE RETURN 'Not Eligible';
END IF;
END;
/


SELECT loan_status(50000, 780) FROM dual;

-----------------------Part 1
Square a number
CREATE OR REPLACE FUNCTION square_num(p_num NUMBER) RETURN NUMBER IS
BEGIN RETURN p_num * p_num; END;
/

-- Greeting function
CREATE OR REPLACE FUNCTION get_greeting(p_name VARCHAR2) RETURN VARCHAR2 IS
BEGIN RETURN 'Welcome ' || p_name; END;
/

--  Current date function
CREATE OR REPLACE FUNCTION today_date RETURN DATE IS
BEGIN RETURN SYSDATE; END;
/

--  Annual salary function
CREATE OR REPLACE FUNCTION annual_salary(p_salary NUMBER) RETURN NUMBER IS
BEGIN RETURN p_salary * 12; END;
/

Total amount (price * quantity)
CREATE OR REPLACE FUNCTION total_amount(p_price NUMBER, p_qty NUMBER) RETURN NUMBER IS
BEGIN RETURN p_price * p_qty; END;
/

-- Calculate bonus based on salary
CREATE OR REPLACE FUNCTION calculate_bonus(p_salary NUMBER) RETURN NUMBER IS
BEGIN
IF p_salary > 50000 THEN RETURN p_salary * 0.20;
ELSIF p_salary > 30000 THEN RETURN p_salary * 0.10;
ELSE RETURN p_salary * 0.05;
END IF;
END;
/

--  Calculate tax based on annual salary
CREATE OR REPLACE FUNCTION calculate_tax(p_annual_salary NUMBER) RETURN NUMBER IS
BEGIN
IF p_annual_salary > 500000 THEN RETURN p_annual_salary * 0.15;
ELSE RETURN p_annual_salary * 0.05;
END IF;
END;
/

--  Employee experience in years
CREATE OR REPLACE FUNCTION employee_experience(p_joining_date DATE) RETURN NUMBER IS
BEGIN RETURN FLOOR(MONTHS_BETWEEN(SYSDATE, p_joining_date) / 12); END;
/

--  Department code
CREATE OR REPLACE FUNCTION dept_code(p_department VARCHAR2) RETURN VARCHAR2 IS
BEGIN
IF p_department = 'HR' THEN RETURN 'HRD';
ELSIF p_department = 'IT' THEN RETURN 'ITS';
ELSIF p_department = 'Finance' THEN RETURN 'FIN';
ELSIF p_department = 'Sales' THEN RETURN 'SAL';
ELSE RETURN 'GEN';
END IF;
END;
/

--  Even or Odd Function
CREATE OR REPLACE FUNCTION check_even_odd(p_num NUMBER) RETURN VARCHAR2 IS
BEGIN
IF MOD(p_num, 2) = 0 THEN
RETURN 'EVEN';
ELSE
RETURN 'ODD';
END IF;
END;
/

-- Salary Grade Function
CREATE OR REPLACE FUNCTION salary_grade(p_salary NUMBER) RETURN VARCHAR2 IS
BEGIN
IF p_salary >= 50000 THEN
RETURN 'Grade A';
ELSIF p_salary >= 30000 THEN
RETURN 'Grade B';
ELSE
RETURN 'Grade C';
END IF;
END;
/

--  Function Using Employee Table
CREATE OR REPLACE FUNCTION get_salary(p_emp_id NUMBER) RETURN NUMBER IS
v_salary NUMBER;
BEGIN
SELECT salary INTO v_salary FROM employees_pkg WHERE emp_id = p_emp_id;
RETURN v_salary;
END;
/

-- Function with Exception Handling
CREATE OR REPLACE FUNCTION get_salary(p_emp_id NUMBER) RETURN VARCHAR2 IS
v_salary NUMBER;
BEGIN
SELECT salary INTO v_salary FROM employees_pkg WHERE emp_id = p_emp_id;
RETURN TO_CHAR(v_salary);
EXCEPTION
WHEN NO_DATA_FOUND THEN
RETURN 'Employee Not Found';
END;
/

--  Nested Function Call
CREATE OR REPLACE FUNCTION annual_salary(p_salary NUMBER) RETURN NUMBER IS
BEGIN
RETURN p_salary * 12;
END;
/

CREATE OR REPLACE FUNCTION calculate_bonus(p_salary NUMBER) RETURN NUMBER IS
BEGIN
IF p_salary < 30000 THEN RETURN p_salary * 0.10;
ELSIF p_salary <= 60000 THEN RETURN p_salary * 0.15;
ELSE RETURN p_salary * 0.20;
END IF;
END;
/

CREATE OR REPLACE FUNCTION final_salary(p_emp_id NUMBER) RETURN NUMBER IS
v_salary NUMBER;
BEGIN
SELECT salary INTO v_salary FROM employees_pkg WHERE emp_id = p_emp_id;
RETURN annual_salary(v_salary) + calculate_bonus(v_salary);
EXCEPTION
WHEN NO_DATA_FOUND THEN RETURN 0;
END;
/

--  Complete Payroll Report
CREATE OR REPLACE FUNCTION calculate_tax(p_salary NUMBER) RETURN NUMBER IS
v_annual NUMBER;
BEGIN
v_annual := p_salary * 12;
IF v_annual < 500000 THEN RETURN 0;
ELSIF v_annual < 1000000 THEN RETURN v_annual * 0.10;
ELSE RETURN v_annual * 0.20;
END IF;
END;
/

CREATE OR REPLACE FUNCTION employee_experience(p_joining DATE) RETURN NUMBER IS
BEGIN
RETURN FLOOR(MONTHS_BETWEEN(SYSDATE, p_joining) / 12);
END;
/

SELECT
emp_id,emp_name,salary,
annual_salary(salary) AS annual_salary,
calculate_bonus(salary) AS bonus,
calculate_tax(salary) AS tax,
salary_grade(salary) AS grade,
employee_experience(joining_date) AS experience
FROM employees_pkg;
/
--------

create or replace package ee_pkg
IS
--COMPANY VARCHAR2(50) := 'ABC TECH';
PROCEDURE ADD_EMPLOYEE(
    EMPN NUMBER,
    NAMES VARCHAR2,
    SAL NUMBER,
    DEPT NUMBER
);

FUNCTION ANNUAL_SALARY(
    SAL NUMBER
)

END;
END EMPLOYEE_PKG;

/

BEGIN DBMS_OUTPUT.PUT_LINE(
    EMPLOYEE_PKG.ADD_EMPLOYEE(202,'KL',25000)
);

END;
/

CREATE OR REPLACE PACKAGE COMPANY_PKG
IS
COUNTER NUMBER :=0

--------------------PART 2-------------------------
--------------------------------------------------


-- Create Simple Package Specification
CREATE OR REPLACE PACKAGE employee_pkg IS
PROCEDURE add_employee(p_emp_id NUMBER, p_emp_name VARCHAR2, p_department VARCHAR2, p_salary NUMBER);
END employee_pkg;
/

-- Create Package Body
CREATE OR REPLACE PACKAGE BODY employee_pkg IS
PROCEDURE add_employee(p_emp_id NUMBER, p_emp_name VARCHAR2, p_department VARCHAR2, p_salary NUMBER) IS
BEGIN
INSERT INTO employees_pkg(emp_id, emp_name, department, salary, joining_date, status)
VALUES(p_emp_id, p_emp_name, p_department, p_salary, SYSDATE, 'ACTIVE');
END;
END employee_pkg;
/

-- -- Execute Package Procedure Insert 3 Records
-- EXEC employee_pkg.add_employee(1, 'John', 'IT', 50000);
-- EXEC employee_pkg.add_employee(2, 'Jane', 'HR', 45000);
-- EXEC employee_pkg.add_employee(3, 'Bob', 'IT', 60000);

-- Create Function in Package Annual Salary
CREATE OR REPLACE PACKAGE employee_pkg IS
PROCEDURE add_employee(p_emp_id NUMBER, p_emp_name VARCHAR2, p_department VARCHAR2, p_salary NUMBER);
FUNCTION annual_salary(p_emp_id NUMBER) RETURN NUMBER;
END employee_pkg;
/

CREATE OR REPLACE PACKAGE BODY employee_pkg IS
PROCEDURE add_employee(p_emp_id NUMBER, p_emp_name VARCHAR2, p_department VARCHAR2, p_salary NUMBER) IS
BEGIN
INSERT INTO employees_pkg VALUES(p_emp_id, p_emp_name, p_department, p_salary, SYSDATE, NULL, 'ACTIVE');
END;

FUNCTION annual_salary(p_emp_id NUMBER) RETURN NUMBER IS
v_sal NUMBER;
BEGIN
SELECT salary INTO v_sal FROM employees_pkg WHERE emp_id = p_emp_id;
RETURN v_sal * 12;
END;
END employee_pkg;
/

-- Invoke Package Function
DECLARE
v_annual NUMBER;
BEGIN
v_annual := employee_pkg.annual_salary(1);
DBMS_OUTPUT.PUT_LINE('Annual Salary: ' || v_annual);
END;
/

-- Add Update Salary Procedure
CREATE OR REPLACE PACKAGE employee_pkg IS
PROCEDURE add_employee(p_emp_id NUMBER, p_emp_name VARCHAR2, p_department VARCHAR2, p_salary NUMBER);
FUNCTION annual_salary(p_emp_id NUMBER) RETURN NUMBER;
PROCEDURE update_salary(p_emp_id NUMBER, p_new_salary NUMBER);
END employee_pkg;
/

CREATE OR REPLACE PACKAGE BODY employee_pkg IS
PROCEDURE add_employee(p_emp_id NUMBER, p_emp_name VARCHAR2, p_department VARCHAR2, p_salary NUMBER) IS
BEGIN
INSERT INTO employees_pkg VALUES(p_emp_id, p_emp_name, p_department, p_salary, SYSDATE, NULL, 'ACTIVE');
END;

FUNCTION annual_salary(p_emp_id NUMBER) RETURN NUMBER IS
v_sal NUMBER;
BEGIN
SELECT salary INTO v_sal FROM employees_pkg WHERE emp_id = p_emp_id;
RETURN v_sal * 12;
END;

PROCEDURE update_salary(p_emp_id NUMBER, p_new_salary NUMBER) IS
BEGIN
UPDATE employees_pkg SET salary = p_new_salary WHERE emp_id = p_emp_id;
DBMS_OUTPUT.PUT_LINE('Salary Updated');
END;
END employee_pkg;
/

-- Add Delete Employee Procedure
CREATE OR REPLACE PACKAGE employee_pkg IS
PROCEDURE add_employee(p_emp_id NUMBER, p_emp_name VARCHAR2, p_department VARCHAR2, p_salary NUMBER);
FUNCTION annual_salary(p_emp_id NUMBER) RETURN NUMBER;
PROCEDURE update_salary(p_emp_id NUMBER, p_new_salary NUMBER);
PROCEDURE remove_employee(p_emp_id NUMBER);
END employee_pkg;
/

CREATE OR REPLACE PACKAGE BODY employee_pkg IS
PROCEDURE add_employee(p_emp_id NUMBER, p_emp_name VARCHAR2, p_department VARCHAR2, p_salary NUMBER) IS
BEGIN
INSERT INTO employees_pkg VALUES(p_emp_id, p_emp_name, p_department, p_salary, SYSDATE, NULL, 'ACTIVE');
END;

FUNCTION annual_salary(p_emp_id NUMBER) RETURN NUMBER IS
v_sal NUMBER;
BEGIN
SELECT salary INTO v_sal FROM employees_pkg WHERE emp_id = p_emp_id;
RETURN v_sal * 12;
END;

PROCEDURE update_salary(p_emp_id NUMBER, p_new_salary NUMBER) IS
BEGIN
UPDATE employees_pkg SET salary = p_new_salary WHERE emp_id = p_emp_id;
END;

PROCEDURE remove_employee(p_emp_id NUMBER) IS
BEGIN
DELETE FROM employees_pkg WHERE emp_id = p_emp_id;
END;
END employee_pkg;
/

-- Add Salary Validation
CREATE OR REPLACE PACKAGE BODY employee_pkg IS
PROCEDURE add_employee(p_emp_id NUMBER, p_emp_name VARCHAR2, p_department VARCHAR2, p_salary NUMBER) IS
BEGIN
IF p_salary < 10000 THEN
RAISE_APPLICATION_ERROR(-20001, 'Salary cannot be less than 10000');
END IF;
INSERT INTO employees_pkg VALUES(p_emp_id, p_emp_name, p_department, p_salary, SYSDATE, NULL, 'ACTIVE');
END;
END employee_pkg;
/

-- Add Department Total Salary Function
CREATE OR REPLACE PACKAGE employee_pkg IS
FUNCTION dept_total_salary(p_department VARCHAR2) RETURN NUMBER;
END employee_pkg;
/

CREATE OR REPLACE PACKAGE BODY employee_pkg IS
FUNCTION dept_total_salary(p_department VARCHAR2) RETURN NUMBER IS
v_total NUMBER;
BEGIN
SELECT SUM(salary) INTO v_total FROM employees_pkg WHERE department = p_department;
RETURN NVL(v_total, 0);
END;
END employee_pkg;
/

-- Create Package Variable Counter
CREATE OR REPLACE PACKAGE employee_pkg IS
v_counter NUMBER := 0;
PROCEDURE add_employee(p_emp_id NUMBER, p_emp_name VARCHAR2, p_department VARCHAR2, p_salary NUMBER);
END employee_pkg;
/

CREATE OR REPLACE PACKAGE BODY employee_pkg IS
PROCEDURE add_employee(p_emp_id NUMBER, p_emp_name VARCHAR2, p_department VARCHAR2, p_salary NUMBER) IS
BEGIN
IF p_salary < 10000 THEN RAISE_APPLICATION_ERROR(-20001, 'Invalid Salary'); END IF;
INSERT INTO employees_pkg VALUES(p_emp_id, p_emp_name, p_department, p_salary, SYSDATE, NULL, 'ACTIVE');
v_counter := v_counter + 1;
DBMS_OUTPUT.PUT_LINE('Total Records: ' || v_counter);
END;
END employee_pkg;
/

-- Add Update Employee Status Procedure
CREATE OR REPLACE PACKAGE employee_pkg IS
PROCEDURE update_status(p_emp_id NUMBER, p_status VARCHAR2);
END employee_pkg;
/

CREATE OR REPLACE PACKAGE BODY employee_pkg IS
PROCEDURE update_status(p_emp_id NUMBER, p_status VARCHAR2) IS
BEGIN
UPDATE employees_pkg SET status = p_status WHERE emp_id = p_emp_id;
DBMS_OUTPUT.PUT_LINE('Status Updated to ' || p_status);
END;
END employee_pkg;
/

-- Use Cursor to Show All Employees
CREATE OR REPLACE PACKAGE employee_pkg IS
PROCEDURE show_all_employees;
END employee_pkg;
/

CREATE OR REPLACE PACKAGE BODY employee_pkg IS
PROCEDURE show_all_employees IS
CURSOR c_emp IS SELECT * FROM employees_pkg;
v_emp employees_pkg%ROWTYPE;
BEGIN
OPEN c_emp;
LOOP
FETCH c_emp INTO v_emp;
EXIT WHEN c_emp%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v_emp.emp_id || ' - ' || v_emp.emp_name || ' - ' || v_emp.salary);
END LOOP;
CLOSE c_emp;
END;
END employee_pkg;
/

-- Use Parameterized Cursor for Department Employees
CREATE OR REPLACE PACKAGE employee_pkg IS
PROCEDURE show_department_employees(p_department VARCHAR2);
END employee_pkg;
/

CREATE OR REPLACE PACKAGE BODY employee_pkg IS
PROCEDURE show_department_employees(p_department VARCHAR2) IS
CURSOR c_dept(p_dept VARCHAR2) IS SELECT * FROM employees_pkg WHERE department = p_dept;
v_emp employees_pkg%ROWTYPE;
BEGIN
OPEN c_dept(p_department);
LOOP
FETCH c_dept INTO v_emp;
EXIT WHEN c_dept%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v_emp.emp_id || ' - ' || v_emp.emp_name);
END LOOP;
CLOSE c_dept;
END;
END employee_pkg;
/

-- Add Exception Handling
CREATE OR REPLACE PACKAGE BODY employee_pkg IS
PROCEDURE add_employee(p_emp_id NUMBER, p_emp_name VARCHAR2, p_department VARCHAR2, p_salary NUMBER) IS
BEGIN
IF p_salary < 10000 THEN RAISE_APPLICATION_ERROR(-20001, 'Salary too low'); END IF;
INSERT INTO employees_pkg VALUES(p_emp_id, p_emp_name, p_department, p_salary, SYSDATE, NULL, 'ACTIVE');
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('Duplicate ID');
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
END employee_pkg;
/

-- Add Bonus Calculation Function
CREATE OR REPLACE PACKAGE employee_pkg IS
FUNCTION calculate_bonus(p_emp_id NUMBER) RETURN NUMBER;
END employee_pkg;
/

CREATE OR REPLACE PACKAGE BODY employee_pkg IS
FUNCTION calculate_bonus(p_emp_id NUMBER) RETURN NUMBER IS
v_salary NUMBER;
v_bonus NUMBER;
BEGIN
SELECT salary INTO v_salary FROM employees_pkg WHERE emp_id = p_emp_id;
IF v_salary < 30000 THEN v_bonus := v_salary * 0.10;
ELSIF v_salary <= 60000 THEN v_bonus := v_salary * 0.15;
ELSE v_bonus := v_salary * 0.20;
END IF;
UPDATE employees_pkg SET bonus = v_bonus WHERE emp_id = p_emp_id;
RETURN v_bonus;
END;
END employee_pkg;
/

