USE expense_tracker_db;

SELECT * FROM user_account;
SELECT * FROM user_credentials;
SELECT * FROM wallet;
SELECT * FROM transaction_type;
SELECT * FROM user_transaction;

SELECT now();

DELETE FROM user_credentials WHERE user_account_id =1;
DELETE FROM user_account WHERE user_account_id = 1;
DELETE FROM wallet WHERE wallet_id=4;

INSERT INTO transaction_type (transaction_type_name) VALUES('Credit'),('Debit');

UPDATE user_transaction SET amount = 439.57 WHERE transaction_id = 1;

INSERT INTO user_transaction (amount, spent_at, spent_on, transaction_type_id, debited_from, credited_to, user_id) VALUES (438.57, 'More Super Market', NOW(), 2, 1, 2, '64209733-5929-4d82-b26f-039e5ef6a9a0');



ALTER TABLE user_account AUTO_INCREMENT = 1;
ALTER TABLE user_credentials AUTO_INCREMENT = 1;
ALTER TABLE wallet AUTO_INCREMENT = 1;