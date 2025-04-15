
--------------------
--joins
--Show customer details with accounts

SELECT c.customer_id,concat(c.first_name,c.last_name) as full_name,a.branch_id,a.balance
from Customers c , Accounts a
where c.customer_id=a.customer_id


------------------------------
--Show all customers accounts and customers if they don't have accounts

SELECT c.*,a.account_id
from Customers c left join Accounts a
on c.customer_id=a.customer_id

---------------------------
-- list showing all transactions made by each customer on his account, with customer details.

SELECT c.customer_id ,concat(c.first_name,c.last_name) as full_name ,a.account_id,t.amount,t.transaction_type
from Customers c,Accounts a,Transactions t
where c.customer_id=a.customer_id and a.account_id=t.account_id

---------------------------------
------- subqueries

--- customer's transactions that greater than avg
select c.customer_id, c.first_name+' '+c.last_name as fullname ,ac.account_id,t.amount
FROM Customers c JOIN Accounts ac ON c.customer_id = ac.customer_id JOIN Transactions t ON ac.account_id = t.account_id 
WHERE t.amount> (SELECT AVG(amount) FROM Transactions)
--------------------

------- functions
--- to get high customer amount
create OR alter function Get_High_Customer_amount(@main_amount int)
returns table
as 
return

(
select c.customer_id, c.first_name+' '+c.last_name AS fullname , ac.account_id ,ac.balance , t.amount
FROM dbo.Customers c LEFT JOIN dbo.Accounts ac ON c.customer_id = ac.customer_id JOIN dbo.Transactions t ON ac.account_id = t.account_id 
WHERE t.amount > @main_amount)

SELECT * FROM get_High_Customer_amount(9000000)


--to get transfer avg in specific year

CREATE OR ALTER  FUNCTION GetAVGTransactionsperYear (@year INT)
RETURNS TABLE
AS
RETURN 
(  SELECT 
        AVG(t.amount) AS average_transaction
    FROM 
        transactions t
    WHERE 
        YEAR(t.transaction_date) = @year)

SELECT * FROM GetAVGTransactionsperYear(2007)
---------------------------

--view
-- To view customers's loans that have account
CREATE or alter view CUSTOMER_LOAN_ACC
as 
select a.account_id ,concat(c.first_name,c.last_name) as full_name ,l.loan_id ,l.amount
from Accounts a,Customers c,Loans l
where a.account_id=c.customer_id and c.customer_id=l.customer_id

SELECT * from CUSTOMER_LOAN_ACC

--------------------------

-- The branch with the highest transactions

CREATE or alter view The_branch_with_the_highest_transactions
as
select top (10) b.branch_id,b.branch_name ,sum(t.amount) as TotalTransactions
from Transactions t join Accounts a
on t.account_id=a.account_id join Branches b
on a.branch_id=b.branch_id 
group by b.branch_id,b.branch_name
order by TotalTransactions desc

select * from The_branch_with_the_highest_transactions

----------------------

--Total accounts balance in the bank

CREATE or alter view TotalBankBalance
as
select sum(a.balance) as TotalBankBalance 
from Accounts a

SELECT *  from TotalBankBalance

-----------------------------

--largest customers balance

 create or alter view Largest_customers_by_balance
 as
 select top(1)  c.customer_id   ,concat(c.first_name,c.last_name) as fullname ,a.balance
 from Customers c,Accounts a
 where c.customer_id=a.customer_id
 order by a.balance desc
 
 SELECT * from Largest_customers_by_balance

 ------------------------------------------

 -- procedures

 --Show all transactions in specific account , sorted by date from newest to oldest.
 
 CREATE or alter proc show (@acount_id int)
 as
 begin
 select t.*
 from Transactions t
 where t.account_id=@acount_id
 order by t.transaction_date desc
 end
 
 show 40
 
 
 -----------------------
 --For customers don't have any transactions in last 3 years

create or alter proc For_customers_who_have_not_had_any_operations_during_the_last_3_years
 as
 begin
 select c.customer_id ,concat(c.first_name,c.last_name) as fullname
 from Customers c
 where not exists (
                   select *
				   from Transactions t ,Accounts a
				   where t.account_id=a.account_id
				   and c.customer_id=a.account_id   
				   and t.transaction_date>dateadd(year ,-3,getdate())) 
end				   
                  --function that adds or subtracts a time from a given date
For_customers_who_have_not_had_any_operations_during_the_last_3_years

-------------------------------------------

--trigger

--Changes in the balance within the account table appear in the audit table.
create table aduit_table3
(account_id int,
username varchar(100),
ModifiedDate date,
balance_old int,
balance_new int)
											--trg_Audit_AccountBalanceUpdate
create or alter trigger If_a_user_updated_balance
on Accounts
after update
as
begin
if update (balance)
   declare @account_id int
   declare @balance_old int
   declare @balance_new int
         select @account_id=(select account_id from inserted) 
         select @balance_old=(select balance from deleted)
         select @balance_new =(select balance from inserted)
	     insert into aduit_table3
	     values(@account_id,system_user,getdate(),@balance_old,@balance_new )
end
update Accounts
set balance =1000000
where account_id =1
select * from aduit_table3


---------------------------------
---to perevent altring on table

 CREATE OR ALTER TRIGGER june_prevent
ON Employees 
INSTEAD OF INSERT
AS
    IF MONTH(GETDATE()) = 6  
    BEGIN     
        PRINT 'insert not allowed in june'
	END
    ELSE
	 BEGIN 
        
		INSERT INTO employees (employee_id  , first_name,last_name ,ROLE ,hire_date ,salary )  
        
		SELECT employee_id,first_name,last_name ,ROLE ,hire_date ,salary FROM inserted
	 END
INSERT INTO employees (employee_id  , first_name,last_name ,ROLE ,hire_date ,salary )  
	 VALUES (55,'abdo','mohamed','manager',GETDATE(),20000)

	 SELECT * FROM employees

--------------------------------------------------------
     

--window functions

-- Sort customers according to the highest balance in each branch
select * ,row_number() over(partition by branch_id order by status desc) as RN
      from Accounts a 
--------------
-- Ranking the highest customer according to the balance in each branch
select *
from(select * ,row_number() over(partition by branch_id order by balance desc) as RN
      from Accounts a ) as new
	  where RN=1
---------------------
--Arranging the highest customer according to the status in each branch, even if it is repeated
select *
from(select * ,dense_rank() over(partition by branch_id order by status desc) as DN	
      from Accounts a ) as new
	  where DN=1
----------------------------
--rollup and cube grouping sets
--Total Loans by Loan Type and term_months – Using ROLLUP
select l.loan_type,l.term_months,sum(l.amount ) as total_amount
from Loans l
group by rollup (l.loan_type,l.term_months)

----
select l.loan_type,l.term_months,sum(l.amount ) as total_amount
from Loans l
group by cube (l.loan_type,l.term_months)
--------------------------------
--cursor
declare c1 cursor
    for select Salary
    from Employees
       for update
          declare @salary int
          open c1
            fetch c1 into @salary
                 while @@fetch_status = 0
                 begin 
	                  select @salary
                  if @salary >30000
                      update Employees
					 set salary=@salary *1.20
				     where current of c1
                  else 
	                update Employees
	               set salary=@salary *1.10
	               where current of c1
                  fetch c1 into @salary
                end
          close c1
         deallocate c1

		 ------------------
		













