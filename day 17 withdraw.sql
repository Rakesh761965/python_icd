CREATE TABLE transaction_history
(
transaction_id NUMBER,
account_no NUMBER,
customer_name VARCHAR2(30),
transaction_type VARCHAR2(20),
old_balance NUMBER,
amount NUMBER,
new_balance NUMBER,
transaction_date DATE
);


DECLARE


v_transaction_id NUMBER := 1;

v_account_no NUMBER := 1001;

v_customer_name VARCHAR2(30)
:= 'RAHUL';

v_transaction_type VARCHAR2(20)
:= 'WITHDRAW';

v_old_balance NUMBER := 50000;

v_amount NUMBER := 5000;

v_new_balance NUMBER;

BEGIN



v_new_balance :=
v_old_balance - v_amount;


INSERT INTO transaction_history
(
transaction_id,
account_no,
customer_name,
transaction_type,
old_balance,
amount,
new_balance,
transaction_date
)

VALUES
(
v_transaction_id,
v_account_no,
v_customer_name,
v_transaction_type,
v_old_balance,
v_amount,
v_new_balance,
SYSDATE
);



DBMS_OUTPUT.PUT_LINE
(
'TRANSACTION STORED SUCCESSFULLY'
);

DBMS_OUTPUT.PUT_LINE
(
'CUSTOMER NAME: '
|| v_customer_name
);

DBMS_OUTPUT.PUT_LINE
(
'OLD BALANCE: '
|| v_old_balance
);

DBMS_OUTPUT.PUT_LINE
(
'WITHDRAW AMOUNT: '
|| v_amount
);

DBMS_OUTPUT.PUT_LINE
(
'NEW BALANCE: '
|| v_new_balance
);


COMMIT;



EXCEPTION

WHEN OTHERS THEN

ROLLBACK;

DBMS_OUTPUT.PUT_LINE
(
'ERROR OCCURRED'
);

DBMS_OUTPUT.PUT_LINE
(
SQLERRM
);

END;
/