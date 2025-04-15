
# 🏦 Bank Management System

A comprehensive digital banking platform designed to manage customer information, accounts, transactions, card services, loans, ATMs, currency exchange, and employee records across multiple branches.

## 👥 Our Team

- Abdelrahman Mohamed Fathy Mohamed  
- Eslam Mohamed Abdelnaby Ali  
- Nada Gamal Anwar Ahmed  
- Yasser Mohamed Mahmoud Atea  

---

## 📌 Project Overview

The system manages the full range of operations for a large banking institution, including:

- Customer and account management  
- Transaction and card operations  
- Loan and fixed deposit handling  
- Currency exchange and FX transactions  
- ATM and branch operations  
- Employee and risk score management  

---

## 🧩 Key Features

### 🔹 Customer Management
- Personal info: name, DOB, address, phone, email  
- Unique Customer ID and registration date  
- Multiple accounts per customer across branches  

### 🔹 Account Management
- Linked to a branch and a customer  
- Account type, balance, status, and opening date  
- Supports multiple services: cards, loans, bills, deposits  

### 🔹 Card Services
- **Debit Cards**: Linked to accounts  
- **Credit Cards**: Linked to customers  
- Card attributes: card number, expiry, CVV, status  

### 🔹 Transactions
- Withdrawal, deposit, and transfer types  
- Includes ID, amount, date, type, description  
- Supports multiple currencies  

### 🔹 Currency Exchange
- Multi-currency accounts  
- Currency info with exchange rates  
- Used in FX, card, and ATM transactions  

### 🔹 ATM & ATM Transactions
- Each ATM linked to a branch  
- ATM operations: withdrawal, deposit, balance inquiry  
- Unique ID and status per ATM and transaction  

### 🔹 FX Transactions
- Foreign exchange between different currency accounts  
- Includes original/converted amount and exchange rate  

### 🔹 Loans & Payments
- Loan details: ID, type, interest, term, status  
- Payments tracked with date and amount  

### 🔹 Fixed Deposits
- Fixed-term investments linked to accounts  
- Attributes: amount, interest, term, maturity date  

### 🔹 Bill Payments
- Bills linked to accounts  
- Includes biller info, due date, paid date, and status  

### 🔹 Risk Score
- Credit score, risk level, default history  
- Linked to customers  

### 🔹 Branch & Employee Management
- Branch info: name, location, contact  
- Employees: name, role, salary, hire date, supervisor  
- Branch-account and branch-employee relationships  

---

## 🛠️ Project Steps

### ✅ Requirement Analysis
- Identify goals and data needs  
- Analyze requirements for key functionalities  

### ✅ Entity Identification
- Extract key entities and attributes  
- Define data types and structure  

### ✅ ERD & Relationships
- Design Entity-Relationship Diagram  
- Set up PKs, FKs, cardinality, and participation  
- [🔗 ERD Board (Miro)](https://miro.com/app/board/uXjVIGMGzV8=/)

---

## 🧱 Database Implementation (SQL Server)

### 📂 Schema Creation
- Tables created with PKs, FKs, data types  
- Referential integrity and relationships established  

### 📥 Sample Data Insertion
- Data used to validate structure and perform testing  

---

## 📊 SQL Query Examples

### 🔸 Joins
- Customer details with accounts (INNER JOIN)  
- All customers including those without accounts (LEFT JOIN)  
- Full customer transaction history (Multi-table JOIN)  

### 🔸 Subqueries
- Transactions greater than average  

### 🔸 Functions
- Customers with high transaction amounts  
- Average transaction per year  

### 🔸 Views
- Branch with the highest transactions  
- Total bank balance  
- Largest customer balances  

### 🔸 Stored Procedures
- All transactions for an account, sorted by date  
- Customers with no transactions in last 6 months  

### 🔸 Triggers
- Track changes to account balances in audit table  

### 🔸 Window Functions
- Rank customers by balance per branch  
- Handle duplicate balances with DENSE_RANK  

### 🔸 Rollup & Cube
- Total loans by type and term (ROLLUP and CUBE)  

### 🔸 Cursor
- Update employee salaries based on conditions  

---

## 📚 Technologies Used

- **Database**: Microsoft SQL Server  
- **Modeling**: Miro (ERD design)  
- **Languages**: SQL  

---

## 📎 License

This project is for academic and educational purposes.

---

