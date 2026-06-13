-- INSERT INTO EMMP VALUES (101, 'RAM', 50000, 10, 'MANAGER');
-- INSERT INTO EMMP VALUES (102, 'SHYAM', 45000, 20, 'CLERK');
-- INSERT INTO EMMP VALUES (103, 'AMIT', 60000, 10, 'ANALYST');
-- INSERT INTO EMMP VALUES (104, 'RAHUL', 55000, 30, 'MANAGER');
-- INSERT INTO EMMP VALUES (105, 'KARAN', 40000, 20, 'CLERK');
-- INSERT INTO EMMP VALUES (106, 'VIKAS', 70000, 10, 'HR');
-- INSERT INTO EMMP VALUES (107, 'ROHIT', 65000, 30, 'SALES');
-- COMMIT;


-----------------------------------
---IMPLICIT CURSOR

-- SET SERVEROUTPUT ON;
-- BEGIN
-- UPDATE EMMP SET salary = salary + 2000 WHERE deptno = 10;
-- DBMS_OUTPUT.PUT_LINE('Rows Updated: ' || SQL%ROWCOUNT);
-- COMMIT;
-- END;
-- /

-- SELECT * FROM EMMP;

--------------------------------
----

-- SET SERVEROUTPUT ON;
-- DECLARE
-- v_empno NUMBER := 120;
-- BEGIN
-- DELETE FROM EMMP WHERE empno = v_empno;
-- IF SQL%FOUND THEN
-- DBMS_OUTPUT.PUT_LINE('RECORD DELETED');
-- ELSE
-- DBMS_OUTPUT.PUT_LINE('RECORD NOT FOUND');
-- END IF;
-- COMMIT;
-- END;
-- /
--------------------------------------
-----NOT FOUND

-- SET SERVEROUTPUT ON;
-- DECLARE
-- v_name EMMP.ename%TYPE;
-- v_sal EMMP.salary%TYPE;
-- BEGIN
-- SELECT ename, salary INTO v_name, v_sal FROM EMMP WHERE empno = 500;
-- DBMS_OUTPUT.PUT_LINE('Found: ' || v_name);
-- EXCEPTION
-- WHEN NO_DATA_FOUND THEN
-- DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND: Employee not exists');
-- WHEN TOO_MANY_ROWS THEN
-- DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS: Duplicate records');
-- END;
-- /


--------------------------------------------------
---EXPLICIT CURSOR

-- SET SERVEROUTPUT ON;
-- DECLARE
-- CURSOR c1 IS SELECT empno, ename, salary FROM EMMP;
-- v_empno EMMP.empno%TYPE;
-- v_name EMMP.ename%TYPE;
-- v_sal EMMP.salary%TYPE;
-- BEGIN
-- OPEN c1;
-- LOOP
-- FETCH c1 INTO v_empno, v_name, v_sal;
-- EXIT WHEN c1%NOTFOUND;
-- DBMS_OUTPUT.PUT_LINE(v_empno || ' - ' || v_name || ' - ' || v_sal);
-- END LOOP;
-- CLOSE c1;
-- END;
-- /

---------------------------------------
------CURSOR ATTRIBUTE

-- SET SERVEROUTPUT ON;
-- DECLARE
-- CURSOR c1 IS SELECT ename FROM EMMP;
-- v_name EMMP.ename%TYPE;
-- BEGIN
-- OPEN c1;
-- LOOP
-- FETCH c1 INTO v_name;
-- EXIT WHEN c1%NOTFOUND;
-- DBMS_OUTPUT.PUT_LINE(c1%ROWCOUNT || ' ' || v_name);
-- END LOOP;
-- CLOSE c1;
-- END;
-- /

-------------------------------------
------CURSOR LOOP

-- SET SERVEROUTPUT ON;
-- DECLARE
-- CURSOR c1 IS SELECT * FROM EMMP;
-- BEGIN
-- FOR rec IN c1 LOOP
-- DBMS_OUTPUT.PUT_LINE(rec.empno || ' - ' || rec.ename || ' - ' || rec.salary);
-- END LOOP;
-- END;
-- /

-------------------------------------
------PARAMETER CURSORED

-- SET SERVEROUTPUT ON;
-- DECLARE
-- CURSOR c1(p_dept NUMBER) IS SELECT ename, salary FROM EMMP WHERE deptno = p_dept;
-- BEGIN
-- DBMS_OUTPUT.PUT_LINE('Dept 10 Employees:');
-- FOR rec IN c1(10) LOOP
-- DBMS_OUTPUT.PUT_LINE(rec.ename || ' - ' || rec.salary);
-- END LOOP;
-- END;
-- /

---------------------------------------
-------Multiple Parameters
-- SET SERVEROUTPUT ON;
-- DECLARE
-- CURSOR c1(p_dept NUMBER, p_sal NUMBER) IS
-- SELECT ename, salary FROM EMMP WHERE deptno = p_dept AND salary >= p_sal;
-- BEGIN
-- DBMS_OUTPUT.PUT_LINE('Dept 10, Salary >= 50000:');
-- FOR rec IN c1(10, 50000) LOOP
-- DBMS_OUTPUT.PUT_LINE(rec.ename || ' - ' || rec.salary);
-- END LOOP;
-- END;
-- /


-------------------------------------------
--------ISOPEN 
-- SET SERVEROUTPUT ON;
-- DECLARE
-- CURSOR c1 IS SELECT ename FROM EMMP;
-- v_name EMMP.ename%TYPE;
-- BEGIN
-- DBMS_OUTPUT.PUT_LINE('Before OPEN: ' || CASE WHEN c1%ISOPEN THEN 'OPEN' ELSE 'CLOSED' END);
-- OPEN c1;
-- DBMS_OUTPUT.PUT_LINE('After OPEN: ' || CASE WHEN c1%ISOPEN THEN 'OPEN' ELSE 'CLOSED' END);
-- FETCH c1 INTO v_name;
-- CLOSE c1;
-- DBMS_OUTPUT.PUT_LINE('After CLOSE: ' || CASE WHEN c1%ISOPEN THEN 'OPEN' ELSE 'CLOSED' END);
-- END;
-- /

---------------------------------
------FOR UPDATE
-- SET SERVEROUTPUT ON;
-- DECLARE
-- CURSOR c1 IS SELECT ename, salary FROM EMMP FOR UPDATE;
-- v_old NUMBER;
-- BEGIN
-- FOR rec IN c1 LOOP
-- v_old := rec.salary;
-- UPDATE EMMP SET salary = salary + 5000 WHERE CURRENT OF c1;
-- DBMS_OUTPUT.PUT_LINE(rec.ename || ' Old: ' || v_old || ' New: ' || (v_old+5000));
-- END LOOP;
-- COMMIT;
-- END;
-- /

---------------------------------
--------Record Type
-- SET SERVEROUTPUT ON;
-- DECLARE
-- CURSOR c1 IS SELECT * FROM EMMP;
-- rec EMMP%ROWTYPE;
-- BEGIN
-- OPEN c1;
-- LOOP
-- FETCH c1 INTO rec;
-- EXIT WHEN c1%NOTFOUND;
-- DBMS_OUTPUT.PUT_LINE(rec.empno || ' - ' || rec.ename || ' - ' || rec.salary || ' - ' || rec.deptno);
-- END LOOP;
-- CLOSE c1;
-- END;
-- /

--------------------------------------
------------Nested Cursor
-- SET SERVEROUTPUT ON;
-- DECLARE
-- CURSOR d_cursor IS SELECT DISTINCT deptno FROM EMMP ORDER BY deptno;
-- CURSOR e_cursor(p_dept NUMBER) IS SELECT ename FROM EMMP WHERE deptno = p_dept;
-- BEGIN
-- FOR d_rec IN d_cursor LOOP
-- DBMS_OUTPUT.PUT_LINE('DEPARTMENT ' || d_rec.deptno);
-- FOR e_rec IN e_cursor(d_rec.deptno) LOOP
-- DBMS_OUTPUT.PUT_LINE(e_rec.ename);
-- END LOOP;
-- END LOOP;
-- END;
-- /

--------------------------------------
-----------------REF Cursor
-- CREATE OR REPLACE PROCEDURE get_emp(p_dept NUMBER, p_cursor OUT SYS_REFCURSOR) AS
-- BEGIN
-- OPEN p_cursor FOR SELECT ename, salary FROM EMMP WHERE deptno = p_dept;
-- END;
-- /

-- SET SERVEROUTPUT ON;
-- DECLARE
-- my_cursor SYS_REFCURSOR;
-- v_name EMMP.ename%TYPE;
-- v_sal EMMP.salary%TYPE;
-- BEGIN
-- get_emp(10, my_cursor);
-- LOOP
-- FETCH my_cursor INTO v_name, v_sal;
-- EXIT WHEN my_cursor%NOTFOUND;
-- DBMS_OUTPUT.PUT_LINE(v_name || ' - ' || v_sal);
-- END LOOP;
-- CLOSE my_cursor;
-- END;
-- /


----------------------------------------------
----------- Dynamic Parameter
-- SET SERVEROUTPUT ON;
-- DECLARE
-- CURSOR c1(p_dept NUMBER) IS SELECT ename, salary FROM EMMP WHERE deptno = p_dept;
-- v_dept NUMBER := &deptno;
-- BEGIN
-- FOR rec IN c1(v_dept) LOOP
-- DBMS_OUTPUT.PUT_LINE(rec.ename || ' - ' || rec.salary);
-- END LOOP;
-- END;
-- /

-----------------------------------------------
-----------Mini Payroll System
-- SET SERVEROUTPUT ON;
-- DECLARE
-- CURSOR c1(p_dept NUMBER, p_percent NUMBER) IS
-- SELECT ename, salary FROM EMMP WHERE deptno = p_dept FOR UPDATE;
-- v_new_sal NUMBER;
-- BEGIN
-- -- Dept 10: 10% hike
-- FOR rec IN c1(10, 10) LOOP
-- v_new_sal := rec.salary + (rec.salary * 10 / 100);
-- DBMS_OUTPUT.PUT_LINE(rec.ename || ' OLD = ' || rec.salary || ' NEW = ' || v_new_sal);
-- UPDATE EMMP SET salary = v_new_sal WHERE CURRENT OF c1;
-- END LOOP;

-- -- Dept 20: 5% hike
-- FOR rec IN c1(20, 5) LOOP
-- v_new_sal := rec.salary + (rec.salary * 5 / 100);
-- DBMS_OUTPUT.PUT_LINE(rec.ename || ' OLD = ' || rec.salary || ' NEW = ' || v_new_sal);
-- UPDATE EMMP SET salary = v_new_sal WHERE CURRENT OF c1;
-- END LOOP;

-- COMMIT;
-- END;
-- /