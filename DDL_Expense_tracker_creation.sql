USE expense_tracker_db;

DROP TABLE IF EXISTS user_category;
DROP TABLE IF EXISTS payment_information;
DROP TABLE IF EXISTS user_transaction;
DROP TABLE IF EXISTS transaction_type;
DROP TABLE IF EXISTS wallet;
DROP TABLE IF EXISTS user_credentials;
DROP TABLE IF EXISTS user_account;

-- TODO
-- User should be able to share the wallet with another user
-- Transaction can have multiple payments
-- New transaction type called as transfer
-- Wallet should have the computed information ?
-- Create unsorted wallets for user when they register
-- 

-- Stores the core user information
CREATE TABLE user_account (
	-- This field is required by LB4 for reference
    user_id VARCHAR(255) NOT NULL UNIQUE,
    user_name VARCHAR(50) NULL DEFAULT NULL UNIQUE,
    email VARCHAR(60) NOT NULL UNIQUE,
    email_verified TINYINT(1) NULL DEFAULT FALSE,
    phone_number VARCHAR(255) NOT NULL,
    phone_number_verified TINYINT(1) NULL DEFAULT FALSE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NULL,
    last_login DATETIME DEFAULT NOW(),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
    PRIMARY KEY (user_id)    
);

-- Contains the user credentials passwords for now
CREATE TABLE user_credentials (
    -- This field is required by LB4
    user_credentials_id VARCHAR(255) NOT NULL,
    -- This field is required by LB4
    user_id VARCHAR(255) NOT NULL,
    user_password VARCHAR(100) NOT NULL,    
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
    PRIMARY KEY (user_credentials_id),    
    FOREIGN KEY FK_user_credentials_user_account (user_id) REFERENCES user_account (user_id)
);

-- Wallet can be shared between users, the user can only provide access to known users
CREATE TABLE wallet (
	wallet_id INT NOT NULL AUTO_INCREMENT,
    wallet_name VARCHAR(200) NOT NULL,    
    created_by VARCHAR(255) NOT NULL,
    updated_by VARCHAR(255) NOT NULL,
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
    PRIMARY KEY (wallet_id),
    FOREIGN KEY FK_wallet_user_account (user_id) REFERENCES user_account (user_id)
);

CREATE TABLE user_wallet_access (
	user_wallet_access_id INT NOT NULL AUTO_INCREMENT
);

-- This is a master list which is applicable for all users
CREATE TABLE transaction_type (
	transaction_type_id INT NOT NULL AUTO_INCREMENT,
    transaction_type_name VARCHAR(150),
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
    PRIMARY KEY (transaction_type_id)
);

-- USER BASED CATEGORY LIST
CREATE TABLE user_category (
	category_id INT NOT NULL AUTO_INCREMENT,
	category_name VARCHAR(150) NOT NULL,
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
    PRIMARY KEY (category_id)
);

CREATE TABLE payment_information (
	payment_information_id INT NOT NULL AUTO_INCREMENT,
    payment_mode VARCHAR(25) NULL DEFAULT NULL,
    account_name VARCHAR(255) NULL DEFAULT NULL,
    account_info VARCHAR(255) NULL DEFAULT NULL,
    payment_reference_number VARCHAR(255) NULL DEFAULT NULL,
    comments VARCHAR(255) NULL DEFAULT NULL,
    upi_id VARCHAR(255) NULL DEFAULT NULL,
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
    PRIMARY KEY (payment_information_id)
);

CREATE TABLE user_transaction_payment (
	user_transaction_payment_id INT NOT NULL AUTO_INCREMENT
);

-- This contains all the transaction for the user
CREATE TABLE user_transaction (
	transaction_id INT NOT NULL AUTO_INCREMENT,
    amount DECIMAL(10,2) NOT NULL,
    narrative VARCHAR(255) NULL DEFAULT NULL,
    transaction_date DATETIME NOT NULL,
    bank_reference_number VARCHAR(255) NULL DEFAULT NULL,
    transaction_type_id INT NOT NULL,
    debited_wallet_id INT NOT NULL,
    credited_wallet_id INT NOT NULL,
    -- Change this to created by and track the user info for both created and updated by
	user_id VARCHAR(255) NOT NULL,
    payment_information_id INT NULL DEFAULT NULL,
    -- Defaults to unsorted
    category_id INT NULL DEFAULT 1,
	created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),        
    PRIMARY KEY (transaction_id),
    FOREIGN KEY FK_user_transaction_debit_wallet (debited_wallet_id) REFERENCES wallet (wallet_id),
    FOREIGN KEY FK_user_transaction_credit_wallet (credited_wallet_id) REFERENCES wallet (wallet_id),
    FOREIGN KEY FK_user_transaction_transaction_type (transaction_type_id) REFERENCES transaction_type (transaction_type_id),
    FOREIGN KEY FK_user_transaction_user_account (user_id) REFERENCES user_account (user_id),
    FOREIGN KEY FK_user_transaction_payment_information (payment_information_id) REFERENCES payment_information (payment_information_id)
);


