-- CREATE TABLE emp_master (
-- emp_code NUMBER PRIMARY KEY,
-- emp_fullname VARCHAR2(30),
-- emp_salary NUMBER,
-- emp_dept NUMBER
-- );


-- INSERT INTO emp_master VALUES(301, 'DAVID', 8000, 10);
-- INSERT INTO emp_master VALUES(302, 'EMMA', 4000, 20);
-- INSERT INTO emp_master VALUES(303, 'FRANK', 9000, 10);
-- INSERT INTO customer_accounts VALUES(201, 'DAVID', 12000);
-- INSERT INTO customer_accounts VALUES(202, 'EMMA', 3000);
-- INSERT INTO product_stock VALUES(701, 'MOUSE', 5);
-- INSERT INTO product_stock VALUES(702, 'MONITOR', 0);
-- COMMIT;

-- SET SERVEROUTPUT ON;

------- No data Exception
DECLARE
v_name emp_master.emp_fullname%TYPE;
v_id emp_master.emp_code%TYPE := 999;
BEGIN
SELECT emp_fullname INTO v_name FROM emp_master WHERE emp_code = v_id;
DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('TASK 1: No employee found with code ' || v_id);
END;
/

------ too many rows exception
DECLARE
v_name emp_master.emp_fullname%TYPE;
v_dept emp_master.emp_dept%TYPE := 10;
BEGIN
SELECT emp_fullname INTO v_name FROM emp_master WHERE emp_dept = v_dept;
DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
EXCEPTION
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE('TASK 2: Multiple employees found in dept ' || v_dept);
END;
/

-----task4
DECLARE
v_num1 NUMBER := 100;
v_num2 NUMBER := 0;
v_result NUMBER;
BEGIN
v_result := v_num1 / v_num2;
DBMS_OUTPUT.PUT_LINE('Result: ' || v_result);
EXCEPTION
WHEN ZERO_DIVIDE THEN
DBMS_OUTPUT.PUT_LINE('TASK 3: Division by zero is not allowed!');
END;
/

------VALUE ERROR Exception
DECLARE
v_small VARCHAR2(5);
v_large VARCHAR2(100) := 'This string is way too long for this small variable';
BEGIN
v_small := v_large;
DBMS_OUTPUT.PUT_LINE(v_small);
EXCEPTION
WHEN VALUE_ERROR THEN
DBMS_OUTPUT.PUT_LINE('TASK 4: Data size mismatch error occurred!');
END;
/

-----DUP_VAL_ON_INDEX Exception
DECLARE
v_id emp_master.emp_code%TYPE := 301;
BEGIN
INSERT INTO emp_master VALUES(v_id, 'DUPLICATE', 5000, 99);
COMMIT;
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE('TASK 5: Duplicate primary key value ' || v_id || ' - cannot insert');
ROLLBACK;
END;
/

---------------------------------------

CREATE TABLE customer_accounts (
cust_acc_id NUMBER PRIMARY KEY,
cust_name VARCHAR2(30),
current_balance NUMBER
);


----INVALID_NUMBER Exception
DECLARE
v_text VARCHAR2(10) := 'XYZ789';
v_num NUMBER;
BEGIN
v_num := TO_NUMBER(v_text);
DBMS_OUTPUT.PUT_LINE('Number: ' || v_num);
EXCEPTION
WHEN INVALID_NUMBER THEN
DBMS_OUTPUT.PUT_LINE('TASK 6: Cannot convert "' || v_text || '" to a number');
END;
/

 -----CURSOR_ALREADY_OPEN Exception

DECLARE
CURSOR cur_emp IS SELECT emp_fullname FROM emp_master;
BEGIN
OPEN cur_emp;
OPEN cur_emp; -- Trying to open again - causes error
CLOSE cur_emp;
EXCEPTION
WHEN CURSOR_ALREADY_OPEN THEN
DBMS_OUTPUT.PUT_LINE('TASK 7: Cursor is already open, cannot open again');
CLOSE cur_emp;
END;
/


-- --User-Defined Exception (Salary < 5000)
DECLARE
v_salary emp_master.emp_salary%TYPE := 4000;
ex_low_salary EXCEPTION;
BEGIN
IF v_salary < 5000 THEN
RAISE ex_low_salary;
END IF;
DBMS_OUTPUT.PUT_LINE('Salary validation passed');
EXCEPTION
WHEN ex_low_salary THEN
DBMS_OUTPUT.PUT_LINE('TASK 8: Salary ' || v_salary || ' is below minimum requirement of 5000');
END;
/


----- Banking Withdrawal Validation
DECLARE
v_balance customer_accounts.current_balance%TYPE;
v_withdraw NUMBER := 5000;
v_acc_no customer_accounts.cust_acc_id%TYPE := 202;
ex_insufficient_bal EXCEPTION;
BEGIN
SELECT current_balance INTO v_balance FROM customer_accounts WHERE cust_acc_id = v_acc_no;
IF v_balance < v_withdraw THEN
RAISE ex_insufficient_bal;
END IF;
UPDATE customer_accounts SET current_balance = v_balance - v_withdraw WHERE cust_acc_id = v_acc_no;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Withdrawal successful. Remaining balance: ' || (v_balance - v_withdraw));
EXCEPTION
WHEN ex_insufficient_bal THEN
DBMS_OUTPUT.PUT_LINE('TASK 9: Insufficient balance! Available: ' || v_balance || ', Requested: ' || v_withdraw);
ROLLBACK;
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('TASK 9: Account number ' || v_acc_no || ' does not exist');
END;
/


------------------------------------
CREATE TABLE product_stock (
prod_code NUMBER PRIMARY KEY,
prod_description VARCHAR2(30),
available_stock NUMBER
);


-- RAISE_APPLICATION_ERROR 

DECLARE
v_stock product_stock.available_stock%TYPE;
v_prod_code product_stock.prod_code%TYPE := 702;
BEGIN
SELECT available_stock INTO v_stock FROM product_stock WHERE prod_code = v_prod_code;
IF v_stock = 0 THEN
RAISE_APPLICATION_ERROR(-20010, 'Product is currently out of stock!');
END IF;
UPDATE product_stock SET available_stock = v_stock - 1 WHERE prod_code = v_prod_code;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Purchase completed successfully');
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('TASK 10: Error - ' || SQLERRM);
ROLLBACK;
END;
/


--– SQLCODE and SQLERRM

DECLARE
v_num NUMBER;
BEGIN
v_num := TO_NUMBER('HELLO123'); -- This will cause error
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('TASK 11: SQLCODE = ' || SQLCODE);
DBMS_OUTPUT.PUT_LINE('TASK 11: SQLERRM = ' || SQLERRM);
END;
/



---------------------------------------------------
--------------------------------------------------
-- 1. Display employee name
CREATE OR REPLACE PROCEDURE display_emp_name(p_id NUMBER) AS
v_name VARCHAR2(100);
BEGIN
SELECT name INTO v_name FROM employees WHERE emp_id = p_id;
DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
END;
/

-- 2. Increase salary
CREATE OR REPLACE PROCEDURE increase_salary(p_id NUMBER, p_percent NUMBER) AS
BEGIN
UPDATE employees SET salary = salary * (1 + p_percent/100) WHERE emp_id = p_id;
COMMIT;
END;
/

-- 3. OUT parameter
CREATE OR REPLACE PROCEDURE get_salary(p_id NUMBER, p_salary OUT NUMBER) AS
BEGIN
SELECT salary INTO p_salary FROM employees WHERE emp_id = p_id;
END;
/

-- 4. IN OUT parameter
CREATE OR REPLACE PROCEDURE adjust_salary(p_id NUMBER, p_amount IN OUT NUMBER) AS
BEGIN
UPDATE employees SET salary = salary + p_amount WHERE emp_id = p_id
RETURNING salary INTO p_amount;
COMMIT;
END;
/

-- 5. Delete employee
CREATE OR REPLACE PROCEDURE delete_employee(p_id NUMBER) AS
BEGIN
DELETE FROM employees WHERE emp_id = p_id;
COMMIT;
END;
/

-- 6. Exception handling
CREATE OR REPLACE PROCEDURE safe_transfer(p_from NUMBER, p_to NUMBER, p_amt NUMBER) AS
BEGIN
UPDATE accounts SET balance = balance - p_amt WHERE acc_id = p_from;
UPDATE accounts SET balance = balance + p_amt WHERE acc_id = p_to;
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- 7. Transfer bank balance
CREATE OR REPLACE PROCEDURE transfer_balance(p_from NUMBER, p_to NUMBER, p_amt NUMBER) AS
v_bal NUMBER;
BEGIN
SELECT balance INTO v_bal FROM accounts WHERE acc_id = p_from FOR UPDATE;
IF v_bal >= p_amt THEN
UPDATE accounts SET balance = balance - p_amt WHERE acc_id = p_from;
UPDATE accounts SET balance = balance + p_amt WHERE acc_id = p_to;
COMMIT;
ELSE
RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance');
END IF;
END;
/

-- 8. Count employees
CREATE OR REPLACE PROCEDURE count_employees(p_count OUT NUMBER) AS
BEGIN
SELECT COUNT(*) INTO p_count FROM employees;
END;
/

-- 9. Update department
CREATE OR REPLACE PROCEDURE update_dept(p_emp_id NUMBER, p_dept_id NUMBER) AS
BEGIN
UPDATE employees SET dept_id = p_dept_id WHERE emp_id = p_emp_id;
COMMIT;
END;
/

-- 10. Display procedure code
SELECT text FROM user_source WHERE name = 'DISPLAY_EMP_NAME' ORDER BY line;


------------------------------------

-- CREATE TABLE STAFF_MASTER(
-- STAFF_ID NUMBER PRIMARY KEY,
-- STAFF_NAME VARCHAR2(50),
-- DIVISION VARCHAR2(30),
-- PAY NUMBER,
-- OFFICE_ID NUMBER,
-- EXTRA_BONUS NUMBER
-- );

-- CREATE TABLE CLIENT_MASTER(
-- CLIENT_ID NUMBER PRIMARY KEY,
-- CLIENT_NAME VARCHAR2(50),
-- AGE NUMBER,
-- MONTHLY_INCOME NUMBER,
-- SCORE NUMBER
-- );

-- CREATE TABLE BANK_WALLET(
-- WALLET_NO NUMBER PRIMARY KEY,
-- CLIENT_ID NUMBER,
-- CURRENT_BALANCE NUMBER,
-- MAX_LIMIT NUMBER
-- );

-- CREATE TABLE MONEY_LOG(
-- LOG_ID NUMBER PRIMARY KEY,
-- CLIENT_ID NUMBER,
-- AMOUNT NUMBER,
-- LOG_DATE DATE
-- );

-- CREATE TABLE CREDIT_DETAILS(
-- CREDIT_ID NUMBER PRIMARY KEY,
-- CLIENT_ID NUMBER,
-- CREDIT_TYPE VARCHAR2(30),
-- CREDIT_AMOUNT NUMBER,
-- DUE_DATE DATE
-- );

-- CREATE TABLE OFFICE_INFO(
-- OFFICE_ID NUMBER PRIMARY KEY,
-- OFFICE_NAME VARCHAR2(50)
-- );

-- CREATE TABLE HELP_DESK(
-- ISSUE_ID NUMBER PRIMARY KEY,
-- ISSUE_TEXT VARCHAR2(100),
-- ISSUE_STATUS VARCHAR2(20)
-- );

-- INSERT INTO OFFICE_INFO VALUES(1,'CHENNAI');
-- INSERT INTO OFFICE_INFO VALUES(2,'BANGALORE');

-- INSERT INTO STAFF_MASTER
-- VALUES(101,'RAHUL','Finance',25000,1,0);

-- INSERT INTO STAFF_MASTER
-- VALUES(102,'ARUN','IT',45000,1,0);

-- INSERT INTO STAFF_MASTER
-- VALUES(103,'KIRAN','HR',28000,2,0);

-- INSERT INTO CLIENT_MASTER
-- VALUES(1,'AJAY',25,40000,750);

-- INSERT INTO CLIENT_MASTER
-- VALUES(2,'RAVI',19,15000,500);

-- INSERT INTO BANK_WALLET
-- VALUES(5001,1,60000,20000);

-- INSERT INTO BANK_WALLET
-- VALUES(5002,2,3000,10000);

-- INSERT INTO MONEY_LOG
-- VALUES(1,1,5000,SYSDATE-10);

-- INSERT INTO MONEY_LOG
-- VALUES(2,1,3000,SYSDATE-200);

-- INSERT INTO CREDIT_DETAILS
-- VALUES(1,1,'HOME',500000,SYSDATE-5);

-- COMMIT;



---------------------------------------------------
DECLARE

CURSOR c1 IS
SELECT staff_id,staff_name,pay
FROM staff_master;

v_id STAFF_MASTER.staff_id%TYPE;
v_name STAFF_MASTER.staff_name%TYPE;
v_pay STAFF_MASTER.pay%TYPE;

BEGIN
OPEN c1;
LOOP
FETCH c1 INTO v_id,v_name,v_pay;
EXIT WHEN c1%NOTFOUND;

DBMS_OUTPUT.PUT_LINE('ID : '||v_id);
DBMS_OUTPUT.PUT_LINE('NAME : '||v_name);

IF v_pay < 30000 THEN

UPDATE staff_master
SET pay = pay + (pay*0.10)
WHERE staff_id=v_id;

DBMS_OUTPUT.PUT_LINE('SALARY UPDATED');
END IF;
DBMS_OUTPUT.PUT_LINE('ROWCOUNT : '||c1%ROWCOUNT);
END LOOP;
CLOSE c1;
END;
/
