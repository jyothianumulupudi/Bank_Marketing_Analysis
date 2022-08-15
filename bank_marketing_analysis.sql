create schema bank_marketing_analysis; # databse name
use bank_marketing_analysis; # to set bank_marketing_analysis as my default database

select * from sql_bank_analysis; # to get all the values in the table

					################  QUESTIONS AND ANSERS ################
# Q1
# Write an SQL query to identify the age group which is 
# taking more loan and then calculate the sum of all of the balances of it?

/*For this question I have answered this question in two ways one is temporary table and another one is
CTE. Here I' tried to find  age and count of age so here I got the age with occurances of that 
particular age(number) so from that I have tried to find out maximum occurances of that age with sum of the 
balance*/

# By using temporary table
create temporary table loan
select age, count(age) as occurances, sum(balance) as total_balance, max(age) as age_group
from sql_bank_analysis
where loan = 'yes';
select age, occurances, total_balance from loan;

# By using with cte

with cte as 
(
select age, count(age) as occurances, sum(balance) as total_balance, max(age) as age_group
from sql_bank_analysis
where loan = 'yes')
select age, occurances, total_balance from cte;

# ANSWER: 33 years of the people have more loan with the total amount of 5606611.


# Q2
# Write an SQL query to calculate for each record if a loan has been taken less than 100, 
#then  calculate the fine of 15% of the current balance and create a temp table and    
# then add the amount for each month from that temp table?

CREATE TEMPORARY TABLE month_bal_tem
select (balance * 0.15) as fine, sum(balance) as total_balance, month
from sql_bank_analysis
where loan = 'yes' and balance < 100
group by month;

select * from month_bal_tem; 
 
# by using cte
with  month_bal_tem as (
select (balance * 0.15) as fine, balance, month
from sql_bank_analysis
where loan = 'yes' and balance < 100
)
select max(balance), fine, month from month_bal_tem group by month;

#ANSWER: Getting each highest record from each month with fine and only people who took balance < 100

# Q3
# Write an SQL query to calculate each age group along with each department's highest balance record? 

select age, max(balance) as highest_bal, job from sql_bank_analysis group by job;

# ANSWER: Here getting each age group with each department with highest balance.

# Q4
#Write an SQL query to find the secondary highest education, where duration is more than 150. 
#The query should contain only married people, and then calculate the interest amount? 
#(Formula interest => balance*15%). 

SELECT education, balance*(15/100) as Interest, marital as marital_status
FROM sql_bank_analysis
WHERE education='secondary' and duration > 150 and marital='married';

# ANSWER: Getting all married people from duration is more than 150 and education is secondary.

# Q5
# Write an SQL query to find which profession has taken more loan along with age?

select job, age, count(loan) as number_of_loans from sql_bank_analysis 
where loan='yes' 
group by job
order by count(loan) desc limit 1;

#ANSWER: blue-collar with age 33 are taking more loan.

# Q6
# Write an SQL query to calculate each month's total balance and then calculate 
# in which month the highest amount of transaction was performed?

WITH Total AS
(
SELECT month, sum(balance) as total_balance_for_month
FROM sql_bank_analysis group by month
)
SELECT month, max(total_balance_for_month) as highest_amount_of_transaction
FROM Total;

#ANSWER: Highest amount of transaction was perfomed on the month of may amount of 14200731.









