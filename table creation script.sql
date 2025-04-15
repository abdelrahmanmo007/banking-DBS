-- 1. Customers
create table Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address VARCHAR(255),
    date_of_birth DATE,
    created_at DATE DEFAULT GETDATE()
)

-- 2. Accounts
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    branch_id INT,
    account_type VARCHAR(20),
    currency_code CHAR(3),
    balance DECIMAL(18,2),
    opened_at DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (currency_code) REFERENCES Currencies(currency_code),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
)

-- 3. Currencies
CREATE TABLE Currencies (
    currency_code CHAR(3) PRIMARY KEY,
    currency_name VARCHAR(50),
    exchange_rate_to_base DECIMAL(10,4)
)

-- 4. Transactions
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(18,2),
    currency_code CHAR(3),
    transaction_date DATETIME DEFAULT GETDATE(),
    description VARCHAR(255),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (currency_code) REFERENCES Currencies(currency_code)
)

-- 5. Branches
CREATE TABLE Branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100),
    location VARCHAR(100),
    contact_number VARCHAR(20) ,
	MGRSSN INT,
	hair_date DATE 
FOREIGN KEY (MGRSSN) REFERENCES Employees (employee_id)
)

-- 6. Employees
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    branch_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    role VARCHAR(50),
    hire_date DATE,
	super_id INT,
    salary DECIMAL(12,2),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
    , FOREIGN KEY (super_id) REFERENCES Employees(employee_id)
)

-- 7. Loans
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY ,
    customer_id INT,
    loan_type VARCHAR(50),
    amount DECIMAL(18,2),
    interest_rate DECIMAL(5,2),
    term_months INT,
    status VARCHAR(20),
    start_date DATE,
    approval_date DATE,
    guarantor_name VARCHAR(100),
    interest_type VARCHAR(20),
    payment_frequency VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
)

-- 8. LoanPayments
CREATE TABLE LoanPayments (
    payment_id INT PRIMARY KEY ,
    loan_id INT,
    amount DECIMAL(18,2),
    payment_date DATE,
    paid_by_account_id INT,
    FOREIGN KEY (loan_id) REFERENCES Loans(loan_id),
    FOREIGN KEY (paid_by_account_id) REFERENCES Accounts(account_id)
)

-- 9. CreditCards
CREATE TABLE CreditCards (
    card_id INT PRIMARY KEY ,
    customer_id INT,
    card_number CHAR(16) UNIQUE,
    expiry_date DATE,
    cvv INT,
    credit_limit DECIMAL(18,2),
    current_balance DECIMAL(18,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
)

-- 10. CardTransactions
CREATE TABLE CardTransactions (
    card_transaction_id INT PRIMARY KEY ,
    card_id INT,
    merchant VARCHAR(100),
    amount DECIMAL(18,2),
    currency_code CHAR(3),
    transaction_date DATETIME,
    category VARCHAR(50),
    FOREIGN KEY (card_id) REFERENCES CreditCards(card_id),
    FOREIGN KEY (currency_code) REFERENCES Currencies(currency_code)
)

-- 11. FixedDeposits
CREATE TABLE FixedDeposits (
    deposit_id INT PRIMARY KEY ,
    customer_id INT,
    account_id INT,
    amount DECIMAL(18,2),
    interest_rate DECIMAL(5,2),
    term_months INT,
    start_date DATE,
    maturity_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
)

-- 12. BillPayments
CREATE TABLE BillPayments (
    bill_id INT PRIMARY KEY ,
    customer_id INT,
    biller_name VARCHAR(100),
    account_id INT,
    amount DECIMAL(18,2),
    due_date DATE,
    paid_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
)

-- 13. FX_Transactions
CREATE TABLE FX_Transactions (
    fx_id INT PRIMARY KEY IDENTITY,
    from_account_id INT,
    to_account_id INT,
    from_currency_code CHAR(3),
    to_currency_code CHAR(3),
    exchange_rate DECIMAL(10,4),
	amount_original DECIMAL(18,2),
    amount_converted DECIMAL(18,2),
    date_time DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (from_account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (to_account_id) REFERENCES Accounts(account_id),
	FOREIGN KEY (from_currency_code) REFERENCES Currencies(currency_code),
    FOREIGN KEY (to_currency_code) REFERENCES Currencies(currency_code)

);

-- 14. RiskScores
CREATE TABLE RiskScores (
    risk_id INT PRIMARY KEY ,
    customer_id INT,
    credit_score INT,
    loan_default_history INT,
    risk_level VARCHAR(20),
    last_updated DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
)

-- 15. DebitCards
CREATE TABLE DebitCards (
    debit_card_id INT PRIMARY KEY ,
    customer_id INT,
    account_id INT,
    card_number CHAR(16) UNIQUE,
    expiry_date DATE,
    cvv INT,
    status VARCHAR(20),
    issued_date DATE DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
)

-- 16. ATMs
CREATE TABLE ATMs (
    atm_id INT PRIMARY KEY ,
    location VARCHAR(100),
    branch_id INT,
    status VARCHAR(20),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
)

-- 17. ATM_Transactions
CREATE TABLE ATM_Transactions (
    atm_transaction_id INT PRIMARY KEY ,
    debit_card_id INT,
    atm_id INT,
    transaction_type VARCHAR(20),
    amount DECIMAL(18,2),
	currency_code CHAR(3),
    transaction_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (debit_card_id) REFERENCES DebitCards(debit_card_id),
    FOREIGN KEY (atm_id) REFERENCES ATMs(atm_id),
    FOREIGN KEY (currency_code) REFERENCES Currencies(currency_code)
)

