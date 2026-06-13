
DECLARE


v_transaction_id NUMBER := 2;

v_account_no NUMBER := 2001;

v_customer_name VARCHAR2(30)
:= 'SNEHA';

v_transaction_type VARCHAR2(20)
:= 'DEPOSIT';

v_old_balance NUMBER := 30000;

v_amount NUMBER := 10000;

v_new_balance NUMBER;

BEGIN


v_new_balance :=
v_old_balance + v_amount;


INSERT INTO bank_transaction_history
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
'DEPOSIT TRANSACTION SUCCESSFUL'
);

DBMS_OUTPUT.PUT_LINE
(
'CUSTOMER NAME : '
|| v_customer_name
);

DBMS_OUTPUT.PUT_LINE
(
'OLD BALANCE : '
|| v_old_balance
);

DBMS_OUTPUT.PUT_LINE
(
'DEPOSIT AMOUNT : '
|| v_amount
);

DBMS_OUTPUT.PUT_LINE
(
'NEW BALANCE : '
|| v_new_balance
);


COMMIT;


-------------------------------------------------

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


