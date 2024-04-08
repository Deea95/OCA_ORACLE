-- OCA app: pg 16/586
-- Car Dealership Data Model (exemplu practic)

-- crearea tabelului CAR_DEALERSHIP:
create table CAR_DEALERSHIP
(CarDealership_ID int primary key,
Make varchar2(40) not null,
Model varchar2(40) not null,
EngineCapacity varchar2(40) not null,
Color varchar2(40) not null,
PurchaseDate date not null,
SoldDate date not null,
SellersName varchar2(40) not null,
SellersSSN varchar2(40) not null,
SellersCompany varchar2(40) not null,
BuyersName varchar2(40) not null,
BuyersSSN varchar2(40) not null,
BuyersCompany varchar2(40) not null,
SellingPrice number not null,
PurchasePrice number not null);
-- inserarea in tabel pe baza cerintelor (pg 14):
INSERT INTO CAR_DEALERSHIP (CarDealership_ID, Make, Model, EngineCapacity, Color, PurchaseDate, SoldDate, SellersName, SellersSSN, SellersCompany, BuyersName, BuyersSSN, BuyersCompany, SellingPrice, PurchasePrice) 
VALUES 
(1, 'Mercedes', 'A160', '1600cc', 'Silver', '01-JUN-2013', '01-JUN-2013', 'Coda', '12345', 'Private Seller', 'Sid', '12346', 'Sid’s Cars', 10000, 0);
INSERT INTO CAR_DEALERSHIP (CarDealership_ID, Make, Model, EngineCapacity, Color, PurchaseDate, SoldDate, SellersName, SellersSSN, SellersCompany, BuyersName, BuyersSSN, BuyersCompany, SellingPrice, PurchasePrice) 
VALUES
(2, 'Mercedes', 'A160', '1600cc', 'Silver', '01-AUG-2013', '01-AUG-2013', 'Sid', '12346', 'Sid’s Cars', 'Wags', '12347', 'Wags Auto', 12000, 0);

select * from CAR_DEALERSHIP;

-- crearea tabelului COLORS
create table colors
(color_id int primary key,
color varchar2(50) not null);

-- crearea tabelului CARS care se leaga cu tabele COLORS
create table cars
(car_id int primary key,
make varchar2(50) not null,
model varchar2(50) not null,
engine_capacity varchar2(50) not null,
color_id int,
foreign key (color_id) references colors(color_id)
);

-- crearea tabelului TRANSACTIONS:
create table transactions
(tx_id int primary key,
tx_date date not null,
tx_type varchar2(50) not null,
tx_amount varchar2(50) not null,
customer_id int,
car_id int,
foreign key (customer_id) references customers(customer_id),
foreign key (car_id) references cars(car_id)
);

-- crearea tabelului CUSTOMERS:
create table customers
(customer_id int primary key,
customer_name varchar2(50) not null,
customer_type varchar2(50) not null,
customer_ssn varchar2(50) not null,
customer_co varchar2(50) not null);

-- modificare tip de date pt tabelul TRANSACTIONS:
alter table transactions
modify tx_amount number;


-- Cerinte:
-- Inserare tranzac?ie cu TX_ID 100
-- Inserare tranzac?ie cu TX_ID 100, care descrie achizi?ia unei ma?ini de la clientul cu ID-ul 2
insert into transactions (tx_id, tx_date, tx_type, tx_amount, customer_id, car_id)
values (100, to_date('2013-06-01', 'YYYY-MM-DD'), 'Purchase', 10000, 2, 1);

-- Inserare tranzac?ie cu TX_ID 101, care descrie vânzarea ma?inii la clientul cu ID-ul 4
insert into transactions (tx_id, tx_date, tx_type, tx_amount, customer_id, car_id)
values (101, to_date('2013-08-01', 'YYYY-MM-DD'), 'Sale', 12000, 4, 1);


-- Selectarea informatiilor despre tranzac?ia cu TX_ID 100
select 
    t.tx_id,
    t.tx_date,
    t.tx_type,
    t.tx_amount,
    cus.customer_name,
    cus.customer_ssn,
    car.make,
    car.model,
    col.color
from 
    transactions t
join 
    customers cus on t.customer_id = cus.customer_id
join 
    cars car on t.car_id = car.car_id
join 
    colors col on car.color_id = col.color_id
where 
    t.tx_id = 100;

-- Selectarea informa?iilor despre tranzac?ia cu TX_ID 101
select 
    t.tx_id,
    t.tx_date,
    t.tx_type,
    t.tx_amount,
    cus.customer_name,
    cus.customer_ssn,
    car.make,
    car.model,
    col.color
from 
    transactions t
join 
    customers cus on t.customer_id = cus.customer_id
join 
    cars car on t.car_id = car.car_id
join 
    colors col on car.color_id = col.color_id
where 
    t.tx_id = 101;


--
select * from customers;
select * from cars;
select * from colors;
select * from transactions;

-- inserarrea in tabele:
-- 1. tabelul Colors:
insert into colors (color_id, color)
select 1, 'Silver' from dual union all
select 2, 'Blue Mist' from dual union all
select 3, 'Green Grass' from dual union all
select 4, 'Daisy Yellow' from dual;

-- 2. Tabelul Cars:
insert into cars (car_id, make, model, engine_capacity, color_id)
select 1, 'Mercedes','2001-A160','1600cc',1 from dual union all
select 2, 'Honda','2005-CRV','2000cc',2 from dual union all
select 3, 'BMW','2010-3351','3350cc',1 from dual;

-- 3. Tabelul CUSTOMERS:
insert into customers (customer_id,customer_name, customer_type, customer_ssn, customer_co)
select 1, 'Sid','Owner','12346','Sids Cars' from dual union all
select 2, 'Coda','Private','12345','Pvt' from dual union all
select 3, 'Yoda','Auctioneer','12348','SW Auctions' from dual union all
select 4, 'Wags','Dealer','12347','Wags Auto' from dual;

-- 4. Tabelul TRANSACTIONS:
insert into transactions (tx_id, tx_date, tx_type, tx_amount, customer_id, car_id)
select 100,to_date('2024-06-01', 'YYYY-MM-DD'),'Purchase',10000,2,1 from dual union all
select 101,to_date('2024-08-01', 'YYYY-MM-DD'),'Sale',12000,4,1 from dual union all
select 102,to_date('2024-07-02', 'YYYY-MM-DD'),'Purchase',14000,3,2 from dual;


-- crearea tabelelor pentru GeoCore:
--1. Entitatea Elements:
create table Elements 
(AtomicNumber number Primary key not null,
ElementDescription varchar2(50) not null,
Symbol varchar2(50) not null,
AtomicMass varchar2(50) not null);

--2. Entitatea Contents:
create table Contents 
(Content_ID number Primary key not null,
AtomicNumber number not null,
Quantity number not null);

--3. Entitatea Depth:
create table Depth
(Depth_ID number primary key not null,
StartDepth varchar2(50) not null,
EndDepth varchar2(50) not null);

--4. Entitatea Cores
create table Cores 
(Core_ID number primary key not null,
CollectionDate date not null,
Longitude number not null,
Latitude number not null);

ALTER TABLE Cores
ADD Depth_ID number not null;
ALTER TABLE Cores
ADD Content_ID number not null;

--Adaugarea cheilor straine:
-- 1.Ad?ugare cheie str?in? Depth_ID
ALTER TABLE Cores 
ADD CONSTRAINT fk_Depth_ID 
FOREIGN KEY (Depth_ID) 
REFERENCES Depth(Depth_ID);

-- 2.Ad?ugare cheie str?in? Content_ID
ALTER TABLE Cores 
ADD CONSTRAINT fk_Content_ID 
FOREIGN KEY (Content_ID) 
REFERENCES Contents(Content_ID);


--------=========================================== EXEMPLE COMENZI CAP 1 OCA =======================================---------
-- SELECT
select * from cars;

-- INSERT
insert into cars (car_id, make, model, engine_capacity, color_id)
values (4, 'Mercedes', 'A160', '1600cc', 1);

-- UPDATE
update cars set engine_capacity = '1800cc' where car_id = 1;

-- DELETE
delete from cars where car_id = 1;

-- MERGE
merge into cars using dual on (car_id = 1)
when matched then update set engine_capacity = '1800cc'
when not matched then insert (car_id, make, model, engine_capacity, color_id)
values (1, 'Mercedes', 'A160', '1800cc', 1);

-- CREATE
create table salescars (
    sale_id int primary key,
    sale_date date not null,
    customer_id int,
    car_id int,
    sale_price number not null,
    foreign key (customer_id) references customers(customer_id),
    foreign key (car_id) references cars(car_id)
);


-- ALTER
alter table cars add (manufacture_year int);

-- DROP
drop table cars;

-- RENAME
rename table cars to vehicles;

-- TRUNCATE
truncate table cars;

-- COMMENT
comment on column cars.make is 'Car make (manufacturer)';

-- GRANT
grant select, insert, update, delete on cars to user_name;

-- REVOKE
revoke select, insert, update, delete on cars from user_name;

-- COMMIT
commit;

-- ROLLBACK
rollback;

-- SAVEPOINT
savepoint before_update;


--================================================ CAPITOLUL 2 ===================================================-------------
DESC hr.dual;

-- 1. Describe command:
show user; -- USER is "HR" -> Arata pe ce user suntem
describe employees; -- -> Descrie tabela impreuna cu coloanele si tipul acestora
desc hr.departments;
desc sys.dual;
describe jobs;
describe job_history;
describe locations;
describe countries;
describe regions;

-- 2. SELECT Command:
select * from regions;

select region_name 
from regions;

select job_id, department_id
from job_history;

select distinct job_id
from job_history;

select distinct department_id
from job_history;

select distinct job_id, department_id
from job_history;

select country_name, country_id, region_id from countries;
select city, location_id,
state_province, country_id
from locations
/ -- 23 linii

select city, location_id,
state_province, country_id
from locations
/ -- 23 linii

--Question 1: How many unique departments have employees currently working in them?
select count(distinct department_id) as total_departments
from employees; --11 linii

-- sau
select distinct department_id
from employees; -- 12 linii

--Question 2: How many countries are there in the Europe region?
select count(*) as total_countries_in_europe
from countries c
join regions r on c.region_id = r.region_id
where r.region_name = 'Europe'; -- 8 countries

-- sau
select region_id, country_name
from countries; -- 25 country

-- arithmetic operators:
select employee_id, job_id, start_date, end_date,
end_date-start_date + 1 as "days worked",
(end_date-start_date + 1) * 8 as "correct hours worked",
end_date - start_date + 1 * 8 as "incorrect hours worked"
from hr.job_history; -- 10 linii

-- use of the concatenation and arithmetic operators:
select 'The ' || region_name||' region is on Planet earth' "planetary location",
        region_id * 100/5 + 20/10 - 5 "meteor shower probability %",
        region_id "region id"
from regions;

select 'The ' || region_name||' region is on Planet earth' "planetary location",
        region_id * 100/5 + 20/ (10 - 5) "meteor shower probability %",
        region_id "region id"
from regions;

-- use of column and expression aliases:
select employee_id, job_id, start_date, end_date,
end_date-start_date + 1 as days worked,
(end_date-start_date + 1) * 8 as "correct hours worked",
end_date - start_date + 1 * 8 as "incorrect hours worked"
from hr.job_history; -- eroare

-- use of the AS keyword to specify column aliases:
select employee_id as "employee id",
job_id as "occupation",
start_date, end_date,
(end_date - start_date) + 1 "days worked"
from job_history; -- 10 linii

-- Using the DUAL table:
select 365.25 * 24 * 60 * 60 "seconds in a year"
from dual; -- 31557600 secunde intr un an

-- Error while dealing woth literals with implicit quotes:
select 'Plural's have one quote too many'
from dual; -- este gresit -> corect: select 'Plural''s '.

-- Use of two single quotes with literals with implicit quotes:
--pg 86/586 OCA
select 'Plural''s can be specified using two single quotes'
AS "Two single quotes" from dual;

-- The alternative Quote Operator:
SELECT q'<Test>' as "Testare"
from dual;

-- NULL values in the COMMISSION_PCT column:
DESC employees;

select first_name||''||last_name as "FullName",
       salary, commission_pct, manager_id
from employees
Order by commission_pct desc;

-- null arithmetic always returns a null value:
select first_name||NULL||last_name "FullName",
       commission_pct,salary,
       commission_pct + salary + 10 "Null Arithmetic",
       10/commission_pct "Division by Null"
from employees;

--=================================== EX 2 ===========================================================================--------
SELECT employee_id, job_id, start_date, end_date,
       ROUND(((end_date - start_date) + 1) / 365.25, 2) AS "Years Worked"
FROM job_history;

select 'The job Id for the '||job_title||'''s job is: '||job_id
AS "Job description"
from jobs;

SELECT (22/7) * (6000 * 6000) Area
FROM dual;

-- laborator cap 2:
-- Structural information for the PRODUCT_INFORMATION table
DESC OE.PRODUCT_INFORMATION;

-- Structural information for the ORDERS table
DESC OE.ORDERS;

-- Selecteaz? valorile SALES_REP_ID unice din tabela ORDERS ?i num?r? câ?i reprezentan?i de vânz?ri diferi?i au fost atribui?i comenzilor:
SELECT COUNT(DISTINCT SALES_REP_ID) AS num_sales_reps
FROM OE.ORDERS;

-- Creeaz? un set de rezultate bazat pe tabela ORDERS care include coloanele ORDER_ID, ORDER_DATE ?i ORDER_TOTAL:
SELECT ORDER_ID, ORDER_DATE, ORDER_TOTAL
FROM OE.ORDERS;

-- Produce un set de rezultate util pentru un agent de vânz?ri din tabela PRODUCT_INFORMATION:
SELECT 
    PRODUCT_NAME || ' with code: ' || PRODUCT_ID || ' has status of: ' || PRODUCT_STATUS AS "Product",
    LIST_PRICE,
    MIN_PRICE,
    LIST_PRICE - MIN_PRICE AS "Max Actual Savings",
    ((LIST_PRICE - MIN_PRICE) / LIST_PRICE) * 100 AS "Max Discount %"
FROM OE.PRODUCT_INFORMATION;

-- Calculeaz? suprafa?a P?mântului folosind tabela DUAL:
SELECT 4 * (22/7) * (3958.759 * 3958.759) AS "Earth's Area"
FROM DUAL;


--================================================ CAPITOLUL 3 ==================--------------------------------

SELECT country_name
FROM countries
WHERE region_id=3;

SELECT last_name, first_name
FROM employees
WHERE job_id='SA_REP';

SELECT last_name, salary
FROM employees
WHERE salary = 10000;

SELECT last_name, salary
FROM employees
WHERE salary = '10000';

SELECT last_name, salary, department_id
FROM employees
WHERE salary = department_id;

-- Using the WHERE clause with numeric expressions:

SELECT last_name, salary, department_id
FROM employees
WHERE salary = department_id; -- nimic

SELECT last_name, salary, department_id
FROM employees
WHERE salary = department_id * 100; -- 3 linii returnate

-- Using the WHERE clause with character data:
SELECT last_name
FROm employees
WHERE job_id = SA_REP; -- ORA-00904L invalid identifier

-- Character column-based WHERE clause:
SELECT employee_id, job_id, last_name, first_name
from employees
where last_name = first_name; -- nimic

-- Equivalence of conditional expressions:
select employee_id, job_id, last_name
from employees
where 'SA_REP'||'King' = job_id || last_name;

select employee_id, job_id, last_name
from employees
where job_id || last_name = 'SA_REP'||'King';

-- using there WHERE clause with numeric expressions:
SELECT start_date, employee_id
FROM job_history
WHERE start_date + 1 = '25-MAR-06'; -- 2 lini

SELECT start_date, employee_id
FROM job_history
WHERE start_date = '25-MAR-06'; -- nimic

-- Conditions based on the equality operator:
SELECT last_name, salary
from employees
where job_id='SA_REP'; -- 30 linii

SELECT last_name, salary
FROM employees
WHERE salary > 5000; -- 58 linii

SELECT last_name, salary
FROM employees
WHERE salary < 3000; -- 24 linii

SELECT last_name
FROM employees
WHERE last_name < 'King'; -- LastName pana in Ki%

SELECT last_name, hire_date
FROM employees
WHERE hire_date < '01-JAN-2003'; -- 8 linii

-- Conditions based on the inequality operators:
select last_name, hire_date
from employees
where hire_date < '01-JAN-2003'; -- 8 linii

SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 3400 AND 4000; -- 7 linii

SELECT last_name
FROM employees
WHERE salary >= 3400
AND salary <= 4000; -- 7 linii

SELECT first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '24-JUL-1994' AND '07-JUN-1996'; -- nimic

SELECT first_name, hire_date
FROM employees
WHERE hire_date > '01-JAN-1990'; -- 107 linii

SELECT first_name, hire_date
FROM employees
WHERE '24-JUL-2000' BETWEEN hire_date+30 AND '07-JUN-2024'; -- nimic

SELECT last_name, salary
FROM employees
WHERE salary IN (3000,4000,6000); -- 5 linii

SELECT last_name, salary
FROM employees
WHERE salary = 3000
OR salary = 4000
OR salary = 6000; -- 5 linii, similar cu cea de mai sus

SELECT last_name
FROM employees
WHERE last_name IN ('King','Garbharran','Ramklass'); -- 2 linii

SELECT last_name
FROM employees
WHERE hire_date IN ('01-JAN-1998','01-DEC-1999'); -- nimic

SELECT first_name
FROM employees
WHERE first_name LIKE 'A%'; -- nimic

-- The wildcard symbols of the LIKE operator:

select * 
from countries
where country_name like 'I%a%'; -- 3 linii

select *
from countries
where country_name like '____i%'; -- 4 linii

SELECT *
FROM jobs
WHERE job_id LIKE 'SA_%'; -- 2 linii

SELECT job_title
FROM jobs
WHERE job_id LIKE 'SA\_%' ESCAPE '\'; -- 2 linii similar cu cel de sus

SELECT job_id, job_title
FROM jobs
WHERE job_id LIKE 'SA$_%' ESCAPE '$'; -- 2 linii similar cu cel de mai sus

SELECT job_id
FROM jobs
WHERE job_id LIKE 'SA%MAN'; -- SA_MAN

SELECT job_id
FROM jobs
WHERE job_id LIKE 'SA\%MAN' ESCAPE '\'; -- nimic

select department_name
from departments
where department_name like '%ing'; -- 7 linii

-- Using the IS NULL operator:
select last_name, commission_pct
from employees
where commission_pct is NULL; -- 72 linii

select last_name, commission_pct
from employees
where commission_pct = NULL; -- nimic

-- Using the AND operator:
SELECT first_name, last_name, commission_pct, hire_date
FROM employees
WHERE first_name LIKE 'J%'
AND commission_pct > 0.1; -- 29 linii

select first_name, last_name, commission_pct, hire_date
from employees
where first_name like 'J%'
and commission_pct > 0.1
and hire_date > '01-JUN-1996'
and last_name like '%o%'; -- 7 linii

-- Using the OR operator:
select first_name, last_name, commission_pct, hire_date
from employees
where first_name like 'B%'
OR commission_pct > 0.35
OR hire_date > '01-MAR-2008'
OR last_name like 'B%'; -- 13 linii

select first_name, last_name, commission_pct, hire_date
from employees
where first_name like 'B%'
OR commission_pct > 0.35; -- 1 linie

SELECT first_name, last_name, commission_pct, hire_date
FROM employees
WHERE first_name NOT LIKE 'B%'
OR NOT (commission_pct > 0.35); -- 107 linii

SELECT last_name,salary,department_id,job_id,commission_pct
FROM employees
WHERE last_name LIKE '%a%' AND salary > department_id * 200
OR
job_id IN ('MK_REP','MK_MAN') AND commission_pct IS NOT NULL; -- 4 linii


SELECT last_name,salary,department_id,job_id,commission_pct
FROM employees
WHERE last_name LIKE '%a%'
AND salary > department_id * 100
AND commission_pct IS NOT NULL
OR
job_id = 'MK_MAN'; -- 6 linii

-- Operator precedence in the WHERE clause:
select last_name, salary, department_id, job_id, commission_pct
from employees
where last_name like '%a%'
and salary > department_id * 200
OR job_id IN ('MK_REP','MK_MAN')
AND commission_pct IS NOT NULL; -- 4 linii

select last_name, salary, department_id, job_id, commission_pct
from employees
where last_name like '%a%'
and salary > department_id * 200; -- 4 linii

select last_name, salary, department_id, job_id, commission_pct
from employees
where job_id IN ('MK_REP','MK_MAN')
AND commission_pct is not null; -- nimic

-- Effect of condition clause ordering due to precedence rules
select last_name, salary, department_id, job_id, commission_pct
from employees
where last_name like '%a%'
and salary > department_id * 100
and commission_pct is not null
or job_id = 'MK_MAN'; -- 6 linii

select last_name, salary, department_id, job_id, commission_pct
from employees
where last_name like '%a%'
and salary > department_id * 100
and commission_pct is not null; -- 5 linii

select last_name, salary, department_id, job_id, commission_pct
from employees
where job_id = 'MK_MAN'; -- 1 linie

--Sorting data using the ORDER BY clause:
SELECT last_name, salary, commission_pct
FROM employees
WHERE job_id IN ('SA_MAN','MK_MAN')
ORDER BY last_name; -- 6 linii

SELECT last_name, salary, hire_date, hire_date-(salary/10) emp_value
FROM employees
WHERE job_id IN ('SA_REP','MK_MAN')
ORDER BY emp_value; -- 31 linii

select last_name, salary, commission_pct
from employees
where job_id IN ('SA_MAN','MK_MAN')
ORDER BY commission_pct desc; -- 6 linii

select last_name, salary, commission_pct
from employees
where job_id in ('SA_MAN','MK_MAN')
order by commission_pct desc nulls last; -- 6 linii

-- Positional sorting:
SELECT last_name, hire_date, salary
FROM employees
WHERE job_id IN ('SA_REP','MK_MAN')
ORDER BY 2; -- 31 linii

-- Composite sorting:
SELECT job_id, last_name, salary, hire_date
FROM employees
WHERE job_id IN ('SA_REP','MK_MAN')
ORDER BY job_id DESC, last_name, 3 DESC; -- 31 linii

---=========================== EX 3-2 Sorting Data using the ORDER BY Clause:

SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY, (MAX_SALARY - MIN_SALARY) AS VARIANCE
FROM jobs
WHERE JOB_TITLE LIKE '%President%' OR JOB_TITLE LIKE '%Manager%'
ORDER BY VARIANCE DESC, JOB_TITLE DESC; -- 8 linii

-- Single Ampersand Substitution: (variabile care se introduc de la tastatura
SELECT employee_id, last_name, phone_number
FROM employees
WHERE last_name = &LASTNAME
OR employee_id = &EMPNO; -- eroare, nu vede LASTNAME: King

SELECT employee_id, last_name, phone_number
FROM employees
WHERE last_name = 'King'
OR employee_id = 0; -- 2 linii

SELECT employee_id, last_name, phone_number, email
FROM employees
WHERE last_name = '&LASTNAME'
OR employee_id = &EMPNO; -- 2 linii

-- Double Ampersand Substitution:
SELECT first_name, last_name
from employees
where last_name like '%&SEARCH%'
AND first_name like '%&SEARCH%'; -- nimic, cu SEARCH = King; nici cu K si S

-- Substituting Column Names:
SELECT first_name, job_id, &&col
FROM employees
WHERE job_id IN ('MK_MAN','SA_MAN')
ORDER BY &col; -- &col = last_name; -> 6 linii

-- substituting expressions and text:
select &rest_of_statement; -- continuarea expresiei SQL
SELECT department_name FROM departments; -- expresia SQL testata

-- SQL statement varianta cu substituiri:
SELECT &SELECT_CLAUSE
FROM &FROM_CLAUSE
WHERE &WHERE_CLAUSE
ORDER BY &ORDER_BY_CLAUSE; 

--exemplu sql statement cu substituiri ce a fost rulat:
select *
from regions
where region_id=2
order by region_name;

--the DEFINE and UNDEFINE Commands:
SELECT last_name, &&COLNAME
FROM employees
WHERE department_id=30
ORDER BY &COLNAME; -- &&COLNAME = salary

-- the DEFINE command:
DEFINE EMPNAME = King
select last_name, salary
from employees
where last_name= '&EMPNAME'; -- &EMPNAME = King

SELECT 'Coda & Sid' FROM dual;

SET DEFINE OFF
SELECT 'Coda & Sid' FROM dual;
SET DEFINE ON

-- The VERIFY command:
SET VERIFY OFF
SELECT last_name, salary
from employees
where last_name= '&EMPNAME'; -- 2 linii ; s a tinut cont de variabila declarata pt EMPNAME

SET VERIFY ON
SELECT last_name, salary
from employees
where last_name= '&EMPNAME'; -- acelasi rezultat ca si mai sus

-- =========================================== EX 3-3:
SELECT &&EMPLOYEE_ID EMPLOYEE_ID, FIRST_NAME, SALARY, SALARY * 12 AS "ANNUAL SALARY", &&TAX_RATE "TAX RATE", (&TAX_RATE * (SALARY * 12)) AS TAX
FROM EMPLOYEES
WHERE EMPLOYEE_ID = &EMPLOYEE_ID; -- nimic

--=============================================CAP 4. Single-Row Functions:

-- A single-row function:
select region_id, region_name, LENGTH (region_name)
from regions; -- 4 linii

-- Functions in SELECT, WHERE and ORDER BY clauses:
select region_id, region_name, LENGTH (region_name),
       substr(region_name, LENGTH(region_name),1)
from regions
where length(region_name) > 4
order by substr(region_name, LENGTH(region_name),1); -- 3 linii

-- the lower function:
SELECT lower(100) FROM dual;
SELECT lower(100+100) FROM dual;
SELECT lower('The SUM '||'100 + 100'||' = 200') FROM dual;
SELECT lower(SYSDATE) FROM dual;
SELECT lower(SYSDATE+2) FROM dual;

select first_name, last_name, lower(last_name) as "Nume cu litere mici"
from employees
where lower(last_name) like '%ur%'; -- 5 linii

SELECT first_name, last_name, lower(last_name) as "Nume cu litere mici"
FROM employees
WHERE last_name LIKE '%ur%'
OR last_name LIKE '%UR%'
OR last_name LIKE '%uR%'
OR last_name LIKE '%Ur%';

-- The UPPER Function:
SELECT upper(1+2.14) FROM dual;
SELECT upper(SYSDATE) FROM dual;

SELECT * FROM COUNTRIES
WHERE country_name LIKE '%u%s%a%' OR country_name LIKE '%u%s%A%'
OR country_name LIKE '%u%S%a%' OR country_name LIKE '%u%S%A%'
OR country_name LIKE '%U%s%a%' OR country_name LIKE '%U%s%A%'
OR country_name LIKE '%U%S%a%' OR country_name LIKE '%U%S%A%'; -- 2 linii

-- The INITCAP Function:
SELECT initcap(21/7) FROM dual;
SELECT initcap(SYSDATE) FROM dual;
SELECT initcap('init cap or init_cap or init%cap') FROM dual;

select initcap(last_name||' works as a : '|| job_id) "Job description"
from employees
where initcap(last_name) like 'H%'; -- 6 linii

--==================================================== Exercise 4 - Using the Case Conversion Functions=================

SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) LIKE '%li%'; -- nimic

-- The CONCAT function:
SELECT concat(1+2.14,' approximates pi') FROM dual; -- 3.14 approximates pi
SELECT concat('Today is: ',SYSDATE) FROM dual; -- Today is: 02-APR-24
SELECT concat('Outer1 ', concat('Inner1',' Inner2'))
FROM dual; -- Outer1 Inner1 Inner2

select concat (first_name, concat(' ', concat(last_name, concat(' earns ', salary)))) "Concat frunction Example"
from employees
where department_id=100; -- 6 linii

-- The LENGTH Function:
SELECT length(1+2.14||' approximates pi') FROM dual; -- 20 caractere
SELECT length(SYSDATE) FROM dual; -- 9 caractere

SELECT country_id, country_name, region_id, length(country_name) ken 
from countries
where length(country_name) > 10; -- 4 linii

-- the LPAD and RPAD functions:
SELECT lpad(1000+200.55,14,'*') FROM dual;
SELECT rpad(1000+200.55,14,'*') FROM dual;
SELECT lpad(SYSDATE,14,'$#') FROM dual;
SELECT rpad(SYSDATE,4,'$#') FROM dual;

select rpad(first_name || ' ' ||last_name,18) || ' earns ' || lpad(salary, 6, ' ') "LPAD RPAD Example"
from employees
where department_id=100; -- 6 linii

-- the TRIM function:
SELECT trim(TRAILING 'e' FROM 1+2.14||' is pie') FROM dual;
SELECT trim(BOTH '*' FROM '*******Hidden*******') FROM dual;
SELECT trim(1 from sysdate) FROM dual;

select last_name, phone_number
from employees
where trim(' ' || last_name||'      ') ='Smith'; -- 2 linii; nimic (5.04)

-- The INSTR Function (In-String):

SELECT instr(3+0.14,'.') FROM dual; -- 2
SELECT instr(sysdate, 'DEC') FROM dual; -- 0
SELECT instr('1#3#5#7#9#','#') FROM dual; -- 2
SELECT instr('1#3#5#7#9#','#',5) FROM dual; -- 6
SELECT instr('1#3#5#7#9#','#',3,4) FROM dual; -- 10

select * from departments
where instr(department_name, 'on')=2; -- 3 linii

-- The SUBSTR Function (Substring):
SELECT substr(10000-3,3,2) FROM dual; -- 97
SELECT substr(sysdate,4,3) FROM dual; -- APR
SELECT substr('1#3#5#7#9#',5) FROM dual; -- 5#7#9#
SELECT substr('1#3#5#7#9#',5,6) FROM dual; -- 5#7#9#
SELECT substr('1#3#5#7#9#',-3,2) FROM dual; -- #9

select 'Advertising Team Member: '||
       substr(first_name, 1,1)|| '. '||
       last_name "Initial and Last name"
from employees
where substr(job_id,1,2) = 'AD'; -- 4 linii

-- the REPLACE function:

SELECT replace(10000-3,'9','85') FROM dual; -- 8585857
SELECT replace(sysdate, 'DEC','NOV') FROM dual; -- 02-APR-24
SELECT replace('1#3#5#7#9#','#','->') FROM dual; -- 1->3->5->7->9->
SELECT replace('1#3#5#7#9#','#') FROM dual; -- 13579

select last_name, salary, REPLACE(salary,'0','000') "Dream Salary", job_id
from employees
where job_id = 'SA_MAN'; -- 5 linii

--=============================================== EX 4.2========================================---------------------------
SELECT FIRST_NAME, LAST_NAME, SUBSTR(FIRST_NAME,1,1)||' '||SUBSTR(LAST_NAME,1,14) FORMAL_NAME
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) + LENGTH(LAST_NAME) > 15; -- nimic


-- The Numeric ROUND Function:
SELECT round(1601.916718,1) FROM dual; -- 1601.9
SELECT round(1601.916718,2) FROM dual; -- 1601.92
SELECT round(1601.916718,-3) FROM dual; -- 2000
SELECT round(1601.916718) FROM dual; -- 1602

select last_name, salary, SYSDATE-hire_date, round(SYSDATE-hire_date) Bonus
from employees
where job_id = 'SA_MAN'; -- 5 linii

-- The Numeric TRUNC Function (Truncate)

SELECT trunc(1601.916718,1) FROM dual; -- 1601.9
SELECT trunc(1601.916718,2) FROM dual; -- 1601.91
SELECT trunc(1601.916718,-3) FROM dual; -- 1000
SELECT trunc(1601.916718) FROM dual; -- 1601

select job_id, salary, salary * 1.13123,
       trunc(salary*1.13123) "Proposed Salary Increment"
from employees
where job_id like 'FI%'; -- 6 linii

--The MOD Function (Modulus):

SELECT mod(6,2) FROM dual; -- 0
SELECT mod(5,3) FROM dual; -- 2
SELECT mod(7,35) FROM dual; -- 7
SELECT mod(5.2,3) FROM dual; -- 2.2

select first_name, last_name, employee_id, mod(employee_id,4) team#
from employees
where employee_id BETWEEN 100 and 111
order by employee_id; -- 12 linii

-- Date Storage in the Database:

select employee_id, start_date
from job_history; -- 10 linii

-- The SYSDATE function and date arithmetic:

select to_date('02-jun-2008 12:10:00', 'dd-mon-yyyy HH24:mi:ss') - 2 "Substract 2 Days", -- 31-MAY-08
       to_date('02-jun-2008 12:10:00', 'dd-mon-yyyy HH24:mi:ss') + 0.5 "Add half a day", -- 03-JUN-08
       to_date('02-jun-2008 12:10:00', 'dd-mon-yyyy HH24:mi:ss') + 6/24 "Add six hours" -- 02-JUN-08
from dual;

select last_name, hire_date, to_date('02-jun-2006 12:10','dd-mon-yyyy hh24:mi') - hire_date
from employees
where department_id=30; -- 6 linii

--The MONTHS_BETWEEN Function:

SELECT months_between(SYSDATE+31, SYSDATE),
months_between(SYSDATE+61, SYSDATE),
months_between(SYSDATE+92, SYSDATE)
FROM dual;

SELECT months_between('29-mar-2008','28-feb-2008')
FROM dual;

SELECT months_between('29-mar-2008','28-feb-2008') * 31
FROM dual;

select employee_id, end_date, start_date, months_between(end_date, start_date) duration
from job_history
order by duration desc; -- 10 linii

-- The ADD_MONTHS Function:

select add_months('07-apr-2009',1) from dual; -- 07-MAY-09
select add_months('31-dec-2008',2.5) from dual; -- 28-feb-09
select add_months('07-apr-2009',-12) from dual; -- 07-APR-08

--================================================ EX 4.3:
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE MONTHS_BETWEEN('01-JAN-2012', HIRE_DATE) > 100; -- 12 linii

-- The NEXT_DAY Function:

select next_day('01-jan-2009', 'tue')
from dual; -- 06-Jan-09

select next_day('01-jan-2009', 'WEDNE')
from dual; -- 07-jan-09

select next_day('01-jan-2009', 5)
from dual; -- 08-jan-09

--The LAST_DAY Function:

select last_day('01-jan-2009')
from dual; -- 31-jan-09

select last_name, hire_date, last_day(hire_date),
       last_day(hire_date)-hire_date "Days worked in first month"
from employees
where job_id = 'IT_PROG'; -- 5 linii

--The Date ROUND Function:

SELECT ROUND(TO_DATE('02-apr-2024 16:37','dd-mon-yyyy hh24:mi')) AS day,
       ROUND(TO_DATE('02-apr-2024','dd-mon-yyyy')) AS week,
       ROUND(TO_DATE('02-apr-2024','dd-mon-yyyy')) AS month,
       ROUND(TO_DATE('02-apr-2024','dd-mon-yyyy')) AS year
FROM dual;

-- the date trunc function:

SELECT TRUNC(TO_DATE('02-apr-2024 16:37','dd-mon-yyyy hh24:mi')) AS day,
       TRUNC(TO_DATE('02-apr-2024','dd-mon-yyyy')) AS week,
       TRUNC(TO_DATE('02-apr-2024','dd-mon-yyyy')) AS month,
       TRUNC(TO_DATE('02-apr-2024','dd-mon-yyyy')) AS year
FROM dual;

--========================================================CAP 5 - Using Conversion Functions and Conditional Expressions:
-- Implicit Data Type Conversion
SELECT length(1234567890) FROM dual; -- 10
SELECT length(SYSDATE) FROM dual; -- 9
SELECT mod('11',2) FROM dual; -- 1
SELECT mod('11.123',2) FROM dual; --1.123
SELECT mod('11.123.456',2) FROM dual; -- eroare
--corect:
SELECT MOD(ROUND(TO_NUMBER('11.123456')), 2) FROM dual; --1
SELECT mod('$11',2) FROM dual; -- eroare
-- corect:
SELECT MOD(TO_NUMBER(REPLACE('$11', '$', '')), 2) FROM dual; -- 1

--National language support (NLS) session parameters:
select *
from nls_session_parameters;

--TO_CHAR function:

SELECT to_char(00001)||' is a special number' FROM dual; -- 1 is a special number
SELECT to_char(00001,'0999999')||' is a special number' FROM dual; --  0000001 is a special number

-- CHAR function with numbers:
select job_title, max_salary, to_char(max_salary, '$99,999.99'),
       TO_CHAR(max_salary,'$9,999.99')
from jobs
where upper(job_title) like '%PRESIDENT%'; -- 2 linii

--Converting Dates to Characters Using the TO_CHAR Function:
SELECT to_char(sysdate)||' is today''s date' FROM dual; -- 02-APR-24 is today's date
SELECT to_char(sysdate,'Month')||' is a special time' FROM dual; --April     is a special time
SELECT to_char(sysdate,'fmMonth')||' is a special time' FROM dual; --April is a special time

-- TO_CHAR function with dates:
select 'Employee '||employee_id|| 'quit as '||job_id || ' on '||
       TO_CHAR(end_date,'fmDay "the " ddth "of" Month YYYY') "Quitting date"
from job_history
order by end_date; -- 10 linii

--=============================================== EX 5.1:Converting Dates into Characters Using the TO_CHAR Function
select first_name, last_name, to_char(hire_date, 'fmDay, "the "ddth "of" Month, yyyysp.') start_date
from employees
where to_char(hire_date,'fmDay')='Saturday'; -- 19 linii

-- Converting Characters to Dates Using the TO_DATE Function:

SELECT to_date('25-DEC-2010') FROM dual; -- 25-dec-10
SELECT to_date('25-DEC') FROM dual; -- eroare, nu este o data completa
SELECT to_date('25-DEC', 'DD-MON') FROM dual; --25-dec-24
SELECT to_date('25-DEC-2010 18:03:45', 'DD-MON-YYYY HH24:MI:SS') FROM dual; -- 25-dec-10
SELECT to_date('25-DEC-10', 'fxDD-MON-YYYY') FROM dual; -- eroare

-- the TO_DATE function:
select first_name, last_name, hire_date
from employees
where hire_date>to_date('01/12/2008','mm/dd/yyyy')
order by hire_date; -- 10 linii

-- Converting Characters to Numbers Using the TO_NUMBER Function
SELECT to_number('$1,000.55') FROM dual; --eroare
SELECT to_number('$1,000.55','$999,999.99') FROM dual; -- 1000.55

-- TO_NUMBER function:
select last_name, phone_number,
       to_number(substr(phone_number,-8),'999.9999')*10000 local_number
from employees
where department_id=30; -- 6 linii

-- The NVL function:
select last_name, salary, commission_pct, (nvl(commission_pct,0) *salary + 1000) monthly_commission
from employees
where last_name like 'E%'; -- 3 linii

select last_name, salary, commission_pct, (commission_pct *salary + 1000) monthly_commission
from employees
where last_name like 'E%'; -- la fel ca mai sus

-- The NVL2 function:
SELECT nvl2(1234,1,'a string') FROM dual; -- eroare
SELECT nvl2(null,1234,5678) FROM dual; -- 5678
SELECT nvl2(substr('abc',2),'Not bc','No substring') FROM dual; -- Not bc

select last_name, salary, commission_pct,
      nvl2(commission_pct,'Commission Earner', 'Not a Commission Earner') employee_type
from employees
where last_name like 'G%'; -- 8 linii

-- The NULLIF function:
SELECT nullif(1234,1234) FROM dual; -- null
SELECT nullif(1234,1233+1) FROM dual; -- null
SELECT nullif('24-JUL-2009','24-JUL-09') FROM dual; --24-JUL-2009

SELECT 
    first_name, 
    last_name, 
    email, 
    NVL2(
        NULLIF(SUBSTR(first_name, 1, 1) || UPPER(last_name), email), 
        'Email does not match pattern', 
        'March Found!'
    ) AS Pattern
FROM 
    employees
WHERE 
    LENGTH(first_name) = 4; -- 107 linii
    
--==============================================Ex 5.2: Using NULLIF and NVL2 for Simple Conditional Logic
SELECT FIRST_NAME, LAST_NAME, NVL2(NULLIF(LENGTH(LAST_NAME),
LENGTH(FIRST_NAME)), 'Different Length', 'Same Length') NAME_LENGTHS
FROM EMPLOYEES
WHERE DEPARTMENT_ID=100; -- 6 linii

--The COALESCE Function:
SELECT coalesce(null, null, null, 'a string') FROM dual; -- a string
SELECT coalesce(null, null, null) FROM dual; -- null
SELECT coalesce(substr('abc',4),'Not bc','No substring') FROM dual; -- Not bc

SELECT COALESCE (state_province, postal_code, city),
state_province, postal_code, city
FROM locations
WHERE country_id IN ('UK' , 'IT', 'JP'); -- 7 linii

--The DECODE Function:
SELECT decode(1234,123,'123 is a match') FROM dual; -- null
SELECT decode(1234,123,'123 is a match','No match') FROM dual; -- No match
SELECT decode('search','comp1','true1', 'comp2','true2','search','true3', substr('2search',2,6),'true4','false') -- true3
FROM dual;

SELECT DISTINCT country_id, decode(country_id, 'BR', 'Southern Hemisphere',
'AU', 'Southern Hemisphere','Northern Hemisphere') hemisphere
FROM locations
ORDER BY hemisphere; -- 14 linii

-- The CASE Expression:
SELECT
CASE substr(1234,1,3)
WHEN '134' THEN '1234 is a match'
WHEN '1235' THEN '1235 is a match'
WHEN concat('1','23') THEN concat('1','23')||' is a match'
ELSE 'no match'
END
FROM dual; -- 123 is a match

SELECT last_name, hire_date, department_id,
trunc (months_between('01-JAN-2013',hire_date)) months,
trunc (months_between('01-JAN-2013',hire_date) /24) "Months divided by 24",
CASE trunc(months_between('01-JAN-2013',hire_date) /24)
WHEN 1 THEN 'Intern'
WHEN 2 THEN 'Junior'
WHEN 3 THEN 'Intermediate'
WHEN 4 THEN 'Senior'
ELSE 'Furniture'
END loyalty
FROM employees
WHERE department_id NOT IN (50,80,90,100,110)
ORDER BY months; -- 16 linii

SELECT last_name, hire_date,
trunc(months_between('01-JAN-2013',hire_date)) months,
trunc(months_between('01-JAN-2013',hire_date)/24) "Months divided by 24",
CASE
WHEN trunc(months_between('01-JAN-2013',hire_date)/24) < 2 then 'Intern'
WHEN trunc(months_between('01-JAN-2013',hire_date)/24) < 3 then 'Junior'
WHEN trunc(months_between('01-JAN-2013',hire_date)/24) < 4 then 'Intermediate'
WHEN trunc(months_between('01-JAN-2013',hire_date)/24) < 5 then 'Senior'
ELSE 'Furniture'
END loyalty
FROM employees
where department_id NOT IN (50,80,90,100,110)
ORDER BY months; -- la fel ca si cel de sus ca output

--======================================================EX 5.3:
SELECT decode (state_province, 'Washington', 'Headquarters',
'Texas','Oil Wells',
'California',city,
'New Jersey',street_address) location_info,
state_province, city, street_address, country_id
FROM locations
WHERE country_id='US'
ORDER BY location_info; -- 4 linii

-- pg 271/586 - 03.04.2024

--==============================================================CAP 6.: Reporting Aggregated Data Using the Group Functions:
--Definition of Group Functions:
SELECT count (*) as "Numar angajati filtrati", department_id 
FROM employees
GROUP BY department_id
ORDER BY department_id; -- 12 linii

--Types and Syntax of Group Functions:
SELECT COUNT(*) AS total_employees
FROM employees; -- 97 angajati totali

SELECT COUNT(DISTINCT department_id) AS distinct_departments
FROM employees; -- 11

SELECT COUNT(salary) AS total_salaries
FROM employees; -- 97 salarii

-- The COUNT Function:
SELECT count(*) FROM employees; -- 97 angajati
SELECT count(commission_pct) FROM employees; -- 31
SELECT count(DISTINCT commission_pct) FROM employees; -- 7
SELECT count(hire_date), count(manager_id) FROM employees; -- hire_date: 97; manager_id: 96

select count(*) as total, count(Distinct nvl(department_id,0)), count(DISTINCT job_id)
from employees; -- 97 ; 11 ; 19

-- The SUM Function:
SELECT sum(2) FROM employees; -- 194
SELECT sum(salary) FROM employees; -- 970000
SELECT sum(DISTINCT salary) FROM employees; -- 10000
SELECT sum(commission_pct) FROM employees; -- 6.7

SELECT sum(to_date('31-DEC-2015', 'DD-MON-YYYY') - hire_date) / 365.25 "Years worked by End 2015"
FROM employees; -- 985.021218343600273785078713210130047912

SELECT sum(hire_date)
from employees; -- eroare : ORA-00932

-- The AVG Function:
SELECT avg(2) FROM employees; --2
SELECT avg(salary) FROM employees; -- 10000
SELECT avg(DISTINCT salary) FROM employees; --10000
SELECT avg(commission_pct) FROM employees; -- 0.2161290322580645161290322580645161290323
SELECT AVG(NVL(COMMISSION_PCT,0)) from employees; --0.0690721649484536082474226804123711340206 ; ce e cu null le face 0: NVL(COMMISSION_PCT,0)


SELECT last_name, job_id,
(to_date('31-DEC-2015','DD-MON-YYYY') - hire_date) / 365.25
"Years worked by End 2015 by IT"
FROM employees
WHERE job_id = 'IT_PROG'; -- 5 linii
    
-- The MAX and MIN Functions:
SELECT min(commission_pct), max(commission_pct) FROM employees; -- min: 0.1 ; max: 0.4
SELECT min(start_date),max(end_date) FROM job_history; -- start_date: 17-SEP-95 ; end_date: 03-APR-24
SELECT min(job_id),max(job_id) FROM employees; -- min: AC_ACCOUNT; MAX: ST_MAN

select min(hire_date), min(salary), max(hire_date), max(salary)
from employees
where job_id='SA_REP'; -- 30-jan-04; 10000; 21-apr-08; 10000

select last_name, hire_date, salary
from employees
where job_id='SA_REP'
and salary in (10000,10000)
or hire_date in ('30-jan-2004','21-apr-2008'); -- 25 linii (ne am folosit de datele de mai sus)

--==============================================EX 6.1: Using the Group functions:
SELECT ROUND(AVG( LENGTH(COUNTRY_NAME))) AVERAGE_COUNTRY_NAME_LENGTH
FROM COUNTRIES; -- 8

SELECT COUNT(*) Num_Employees,
SUM(SALARY) Tot_Salary_Cost,
MIN(SALARY) Lowest_Salary,
MAX(SALARY) Maximum_Salary
FROM EMPLOYEES; -- 97; 970000; 10000; 10000

SELECT COUNT(DISTINCT JOB_ID)
FROM EMPLOYEES; -- 19

-- Nested group functions:
select sum(commission_pct), nvl(department_id,0)
from employees
where nvl(department_id,0) in (40,80,0)
group by department_id; -- 2 linii

select avg(sum(commission_pct))
from employees
where nvl(department_id,0) in (40, 80,0)
group by department_id; -- 6.7

select sum(commission_pct)
from employees
where nvl(department_id,0) in (40, 80,0)
group by department_id; -- null, 6.7

select department_id, commission_pct, sum(commission_pct) as "Comisioane totale"
from employees
where department_id=80
group by department_id;

select COUNT(SUM(AVG(salary))) as "Test"
from employees; -- ORA-00935: group function is nested too deeply

 SELECT SUM(AVG(LENGTH(LAST_NAME))) FROM EMPLOYEES GROUP BY DEPARTMENT_ID; -- 65.73225806451612903225806451612903225806

--Unique DEPARTMENT_ID values in the EMPLOYEES table
select count(distinct nvl(department_id,0))
from employees; -- 11

select distinct department_id
from employees
order by department_id; -- 11 linii

--The GROUP BY Clause:
SELECT max(salary), count(*)
FROM employees
GROUP BY department_id
ORDER BY department_id; -- 11 linii

select end_date, count(*)
from job_history; -- eroare: not a single-group group function

select end_date, start_date, count(*)
from job_history
group by end_date; -- eroare: not a GROUP BY expression

select to_char(end_date,'yyyy') "Year",
       count(*) "Number of Employees"
from job_history
group by to_char(end_date,'yyyy')
order by count(*) desc; -- 5 linii

--Grouping by Multiple Columns:
SELECT department_id, sum(commission_pct)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id; -- 80; 6.7

SELECT department_id, job_id, sum(commission_pct)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id, job_id; -- 3 linii

select department_id, sum(commission_pct)
from employees
where commission_pct is not null
group by department_id; -- 80; 6.7

select department_id, job_id, sum(commission_pct)
from employees
where commission_pct is not null
group by department_id, job_id; -- 3 linii

--================================================EX 6.2: Grouping Data Based on Multiple Columns:
SELECT to_char (end_date, 'yyyy') "Quitting year" , job_id, count (*) "Number of Employees"
FROM job_history
GROUP BY to_char(end_date,'yyyy'), job_id
ORDER BY count (*) DESC; -- 9 linii

SELECT MIN(LENGTH(LAST_NAME)),
MAX(LENGTH(LAST_NAME)) FROM EMPLOYEES
WHERE JOB_ID='SA_REP';-- min: 3 ; max: 10

SELECT COUNT(*), TO_CHAR( HIRE_DATE, 'YYYY'), JOB_ID, SALARY 
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE,'YYYY') ,JOB_ID, SALARY; -- 97 linii

-- Restricting Group Results:
SELECT department_id
FROM job_history
WHERE department_id IN (50,60,80,110); -- 7 linii

SELECT department_id, count(*)
FROM job_history
WHERE department_id IN (50,60,80,110)
GROUP BY department_id; -- 4 linii

--The HAVING Clause:
SELECT department_id, count(*)
FROM job_history
WHERE department_id IN (50,60,80,110)
GROUP BY department_id
HAVING count(*) > 1
AND department_id > 50; -- 2 linii

select job_id, avg(salary), count(*)
from employees
group by job_id; -- 19 linii

select job_id, avg(salary), count(*)
from employees
group by job_id
having avg(salary) > 10000; -- 7 linii

select job_id, avg(salary), count(*)
from employees
group by job_id
having avg(salary) > 10000
and count(*) >1; -- 2 linii

--===========================================Ex 6.3: Using the HAVING Clause:
SELECT TO_CHAR(HIRE_DATE,'DAY'), COUNT(*)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE,'DAY')
HAVING COUNT(*) >= 18; -- 2 linii

--==============================================================================CAP.7: Displaying Data from Multiple Tables:

--Types of Joins:
SELECT *
FROM countries
WHERE country_id='CA'; -- Country_id: CA; Country_Name: Canada; Region_ID: 2

SELECT region_name
FROM regions
WHERE region_id=2; -- Region_Name: Americas

SELECT *
FROM regions
WHERE region_name='Americas'; -- region_id: 2

SELECT country_name
FROM countries
WHERE region_id=2; -- 5 linii

--1. Inner Joins:
---Natural joins and other inner joins:
select region_name
from regions
NATURAL JOIN countries
where country_name = 'Canada'; -- region_name: Americas

select country_name
from countries
NATURAL JOIN regions
where region_name='Americas'; -- 5 linii

select region_name
from regions
join countries
using (region_id)
where country_name = 'Canada'; -- Americas

select country_name 
from countries c 
join regions r 
on (c.region_id=r.region_id) 
where region_name ='Americas'; -- 5 linii

--2. Outer Joins:
--3. Cross Joins:
select count(*)
from countries; -- 25

select count(*)
from regions; -- 4

select count(*)
from regions
cross join countries; -- 100

select *
from regions
cross join countries
where country_id = 'CA'; -- 4 linii

--4. Oracle Join Syntax:
SELECT regions.region_name, countries.country_name
FROM regions, countries
WHERE regions.region_id=countries.region_id; -- 25 linii

SELECT last_name, department_name
FROM employees, departments
WHERE employees.department_id (+) = departments.
department_id; -- 122 linii

SELECT *
FROM regions,countries; -- 100 linii ( cel mai usor de legat 2 tabele)

--Joining Tables Using ANSI SQL Syntax:
---Sintaxele:
SELECT table1.column, table2.column
FROM table1
[NATURAL JOIN table2] |
[JOIN table2 USING (column_name)] |
[JOIN table2 ON (table1.column_name = table2.column_name)] |
[LEFT | RIGHT | FULL OUTER JOIN table2
ON (table1.column_name = table2.column_name)] |
[CROSS JOIN table2];

SELECT table1.column, table2.column
FROM table1, table2
[WHERE (table1.column_name = table2.column_name)] |
[WHERE (table1.column_name(+)= table2.column_name)] |
[WHERE (table1.column_name)= table2.column_name) (+)] ;

--Dot notation:
select emp.employee_id, department_id, emp.manager_id, departments.manager_id
from employees emp
join departments
using (department_id)
where department_id > 80; -- 11 linii

--The NATURAL JOIN Clause:
SELECT *
FROM locations
NATURAL JOIN countries; -- 23 linii

SELECT *
FROM locations, countries
WHERE locations.country_id = countries.country_id; -- 23 linii

SELECT *
FROM jobs
NATURAL JOIN countries; -- 500 linii

SELECT *
FROM jobs, countries; -- 500 lini

---The NATURAL JOIN:
desc countries;
desc regions;

select *
from regions
natural join countries
where country_id='US'; -- region_id: 2; Americas; US; United States of America

--=================================================EX: 7.1 - Using the NATURAL JOIN
SELECT employee_id, job_id, department_id,
emp.last_name, emp.hire_date, jh.end_date
FROM job_history jh
NATURAL JOIN employees emp; -- employee_id: 176; SA_REP; 90; Taylor; 24-mar-06; 31-dec-06

-- The JOIN USING Clause:
SELECT *
FROM locations
JOIN countries
USING (country_id); -- 23 linii

SELECT *
FROM locations, countries
WHERE locations.country_id = countries.country_id; -- 23 linii

-- Natural join using the JOIN..USING clause:
select emp.last_name, emp.department_id, jh.end_date, job_id, employee_id
from job_history jh
join employees emp
using (job_id, employee_id); -- 2 linii

-- The JOIN ON Clause:
SELECT *
FROM departments d
JOIN employees e ON (e.employee_id=d.department_id); -- 11 linii

SELECT *
FROM employees e, departments d
WHERE e.employee_id=d.department_id; --11 linii

SELECT e.employee_id, e. last_name, j.start_date, e.hire_date, j.end_date,
j.job_id previous_job, e.job_id current_job
FROM job_history j
JOIN employees e
ON (j.start_date=e.hire_date); -- 4 linii

--=================================================================EX 7.2: Using the NATURAL JOIN...ON Clause:
SELECT e.first_name||' '||e.last_name||' is manager of the '||
d.department_name||' department. ' "Managers"
FROM employees e
JOIN departments d
ON (e.employee_id=d.manager_id); -- 11 linii

--N-Way Joins and Additional Join Conditions:
SELECT r.region_name, c.country_name, l.city, d.department_name
FROM departments d
NATURAL JOIN locations l,
countries c, regions r; -- 2700 linii

SELECT region_id, country_id, c.country_name, l.city, d.department_name
FROM departments d
NATURAL JOIN locations l
NATURAL JOIN countries c
NATURAL JOIN regions r; -- 27 linii

SELECT r.region_name, c.country_name, l.city, d.department_name
FROM departments d
JOIN locations l ON (l.location_id=d.location_id)
JOIN countries c ON (c.country_id=l.country_id)
JOIN regions r ON (r.region_id=c.region_id); -- 27 linii

SELECT r.region_name, c.country_name, l.city, d.department_name
FROM departments d
JOIN locations l USING (location_id)
JOIN countries c USING (country_id)
JOIN regions r USING (region_id); -- 27 linii

SELECT d.department_name
FROM departments d
JOIN locations l
ON (l.LOCATION_ID=d.LOCATION_ID)
WHERE d.department_name LIKE 'P%'; -- 3 linii

SELECT d.department_name
FROM departments d
JOIN locations l
ON (l.LOCATION_ID=d.LOCATION_ID
AND d.department_name like 'P%'); -- 3 linii ( la fel ca mai sus)

SELECT r.region_name, c.country_name, l.city, d.department_name, e.last_name, e.salary
FROM employees e
JOIN departments d ON (d.department_id = e.department_id)
JOIN locations l ON (l.location_id = d.location_id)
JOIN countries c ON (c.country_id = l.country_id)
JOIN regions r ON (r.region_id = c.region_id)
WHERE e.salary > 12000; -- 8 linii

--Nonequijoins:
select e.job_id current_jon, 'The salary of '||last_name|| ' can be doubled by changing jobs to: '||
       j.job_id options, e.salary current_salary, j.max_salary potential_max_salary
from employees e
join jobs j 
on (2*e.salary < j.max_salary)
where e.salary > 11000
order by last_name; -- 16 linii

--Joining a Table to Itself Using the JOIN…ON Clause:

--=====================================EX 7.3 - Performing a Self-Join:

SELECT E.LAST_NAME EMPLOYEE, E.EMPLOYEE_ID, E.MANAGER_ID, M.LAST_NAME MANAGER, E.DEPARTMENT_ID
FROM EMPLOYEES E
JOIN EMPLOYEES M ON (E.MANAGER_ID=M.EMPLOYEE_ID)
WHERE E.DEPARTMENT_ID IN (10,20,30)
ORDER BY E.DEPARTMENT_ID; -- 9 linii

--Left Outer Joins:
SELECT e.employee_id, e.department_id EMP_DEPT_ID,
d.department_id DEPT_DEPT_ID, d.department_name
FROM departments d
LEFT OUTER JOIN employees e
ON (d.DEPARTMENT_ID=e.DEPARTMENT_ID)
WHERE d.department_name like 'P%'; -- 8 linii

SELECT e.employee_id, e.department_id EMP_DEPT_ID,
d.department_id DEPT_DEPT_ID, d.department_name
FROM departments d
JOIN employees e
ON (d.DEPARTMENT_ID=e.DEPARTMENT_ID)
WHERE d.department_name like 'P%'; -- 7 linii

SELECT city, L.location_id "L.location_id", d.location_id "d.location_id"
FROM locations L
LEFT OUTER JOIN departments d
ON (L.location_id=d.location_id); -- 43 linii

--Right Outer Joins:
SELECT e.last_name, d.department_name
FROM departments d
RIGHT OUTER JOIN employees e
ON (e.department_id=d.department_id)
WHERE e.last_name LIKE 'G%'; -- 8 linii

SELECT DISTINCT jh. job_id "Jobs in JOB_HISTORY", e. job_id "Jobs in EMPLOYEES"
FROM job_history jh
RIGHT OUTER JOIN employees e
ON (jh. job_id=e.job_id)
ORDER BY jh. job_id; -- 19 linii

--Full Outer Joins:
SELECT e.last_name, d. department_name
FROM departments d
FULL OUTER JOIN employees e
ON (e. department_id = d. department_id)
WHERE e.department_id IS NULL; -- 17 linii

--=======================================================Ex 7.4: Performing an Outer Join:
SELECT D.DEPARTMENT_NAME, D.DEPARTMENT_ID
FROM DEPARTMENTS D
LEFT OUTER JOIN EMPLOYEES E ON
E.DEPARTMENT_ID=D.DEPARTMENT_ID
WHERE E.DEPARTMENT_ID IS NULL; -- 16 linii

SELECT LAST_NAME, EMPLOYEE_ID, REGION_NAME 
FROM EMPLOYEES JOIN REGIONS ON
(MOD(EMPLOYEE_ID,4)+1= REGION_ID); -- 107 linii

SELECT DEPARTMENT_NAME, NVL(LAST_NAME,'No Employees') 
FROM EMPLOYEES
RIGHT OUTER JOIN DEPARTMENTS USING (DEPARTMENT_ID); -- 122 linii

--Creating Cartesian Products Using Cross Joins:
SELECT *
FROM jobs
CROSS JOIN job_history; -- 200 linii

SELECT *
FROM jobs j
CROSS JOIN job_history jh
WHERE j.job_id='AD_PRES'; -- 10 linii

--===============================================================EX 7.5: Performing a Cross Join:
SELECT COUNT(*)
FROM EMPLOYEES
CROSS JOIN DEPARTMENTS; --2889

SELECT r.region_name, c.country_name
FROM regions r
CROSS JOIN countries c
WHERE r.region_id in (3,4)
ORDER BY region_name, country_name; -- 50 linii

SELECT COUNT(*) FROM EMPLOYEES;
SELECT COUNT(*) FROM DEPARTMENTS;

-- SINTAXA:
-- Equijoins
SELECT *
FROM Tabela1
JOIN Tabela2 ON Tabela1.Coloan?1 = Tabela2.Coloan?1;

-- Join natural
SELECT *
FROM Tabela1
JOIN Tabela2 NATURAL JOIN Tabela2;

-- JOIN...USING
SELECT *
FROM Tabela1
JOIN Tabela2 USING (Coloan?1);

-- JOIN...ON
SELECT *
FROM Tabela1
JOIN Tabela2 ON Tabela1.Coloan?1 = Tabela2.Coloan?1;

-- Nonequijoin
SELECT *
FROM Tabela1, Tabela2
WHERE Tabela1.Coloan?1 > Tabela2.Coloan?2;

-- Self-Join
SELECT *
FROM Tabela1 T1
JOIN Tabela1 T2 ON T1.Coloan?1 = T2.Coloan?1;

-- Outer Joins
-- Left outer join
SELECT *
FROM Tabela1
LEFT OUTER JOIN Tabela2 ON Tabela1.Coloan?1 = Tabela2.Coloan?1;

-- Right outer join
SELECT *
FROM Tabela1
RIGHT OUTER JOIN Tabela2 ON Tabela1.Coloan?1 = Tabela2.Coloan?1;

-- Full outer join
SELECT *
FROM Tabela1
FULL OUTER JOIN Tabela2 ON Tabela1.Coloan?1 = Tabela2.Coloan?1;

-- Cartesian Product
SELECT *
FROM Tabela1
CROSS JOIN Tabela2;


--==============================================================CAP 8. - Using Subqueries to Solve Problems:

--=======================================================Ex 8.1- Types of Subqueries:
SELECT sysdate Today,
(SELECT count(*) FROM departments) Dept_count,
(SELECT count(*) FROM employees) Emp_count
FROM dual; -- today: 03-apr-2024 ; 27; 107

SELECT last_name
FROM employees
WHERE employee_id IN
(SELECT manager_id
FROM employees); -- 18 linii

SELECT max(salary),country_id
FROM (SELECT salary, country_id
FROM employees
NATURAL JOIN departments
NATURAL JOIN locations)
GROUP BY country_id; -- 3 linii

--Use of a Subquery Result Set for Comparison Purposes:
SELECT avg(salary)
FROM employees; --6461.831775700934579439252336448598130841

SELECT last_name
FROM employees
WHERE salary < 6461.831775700934579439252336448598130841; -- 56 linii

SELECT last_name
FROM employees
WHERE salary <
(SELECT avg(salary)
FROM employees); -- 56 linii (la fel ca pas 1+ pas 2 de mai sus)

SELECT department_name
FROM departments
WHERE department_id IN
(SELECT DISTINCT(department_id)
FROM employees); -- 11 linii

SELECT department_name
FROM departments
JOIN employees
ON employees.department_id = departments.department_id
GROUP BY department_name; --11 linii

--Generate a Table from Which to SELECT:

SELECT avg(salary),country_id
FROM (SELECT salary, country_id
FROM employees
NATURAL JOIN departments
NATURAL JOIN locations)
GROUP BY country_id; -- 3 linii

SELECT (SELECT max(salary) FROM employees) *
(SELECT max(commission_pct) FROM employees) / 100
FROM dual; -- 40

--Generate Rows to be Passed to a DML Statement:

UPDATE employees
SET salary = (SELECT avg(salary)
FROM employees); -- 107 linii actualizate

DELETE FROM departments
WHERE department_id NOT IN
(SELECT department_id
FROM employees
WHERE department_id is not null); -- 16 linii sterse

INSERT INTO dates
SELECT sysdate
FROM dual; -- ORA-00942: table or view does not exist



--====================================================EX 8.2 - More Complex Subqueries:

SELECT last_name
FROM employees
WHERE department_id IN
(SELECT department_id
FROM departments
WHERE location_id IN
(SELECT location_id
FROM locations
WHERE country_id =
(SELECT country_id
FROM countries
WHERE country_name='United Kingdom')
)); -- 35 linii

SELECT country_id
FROM countries
WHERE country_name='United Kingdom'; -- UK

SELECT location_id
FROM locations
WHERE country_id = 'UK'; -- 2400, 2500, 2600

SELECT department_id
FROM departments
WHERE location_id IN (2400,2500,2600); -- 40 , 80

SELECT last_name
FROM employees
WHERE department_id IN (40,80); -- 35 linii

SELECT last_name
FROM employees
WHERE department_id IN
(SELECT department_id
FROM departments
WHERE department_name LIKE 'IT%')
AND salary > (SELECT avg(salary)
FROM employees); -- nimic

--Correlated Subqueries:
SELECT last_name
FROM employees
WHERE salary <
(SELECT avg(salary)
FROM employees); -- nimic

SELECT p.last_name, p.department_id
FROM employees p
WHERE p.salary <
(SELECT avg(s.salary)
FROM employees s
WHERE s.department_id=p.department_id); -- nimic

--===================================================EX 8.3: Investigate the Different Types of Subqueries:
SELECT last_name
FROM employees
WHERE salary >
(SELECT salary
FROM employees
WHERE last_name='Tobias')
ORDER BY last_name; -- nimic

SELECT last_name
FROM employees
WHERE salary >
(SELECT salary
FROM employees
WHERE last_name='Taylor')
ORDER BY last_name; --ORA-01427: single-row subquery returns more than one row

SELECT count(last_name)
FROM employees
WHERE last_name='Tobias'; -- 1

SELECT count(last_name)
FROM employees
WHERE last_name='Taylor'; -- 2

SELECT last_name
FROM employees
WHERE salary > ALL
(SELECT salary
FROM employees
WHERE last_name='Taylor')
ORDER BY last_name; -- nimic

SELECT last_name
FROM employees
WHERE salary >
(SELECT max(salary)
FROM employees
WHERE last_name='Taylor')
ORDER BY last_name; -- nimic

--Write Single-Row and Multiple-Row Subqueries:
SELECT last_name
FROM employees
WHERE manager_id IN
(SELECT employee_id
FROM employees
WHERE department_id IN
(SELECT department_id
FROM departments
WHERE location_id IN
(SELECT location_id
FROM locations
WHERE country_id='UK'))); -- 30 linii

SELECT job_title
FROM jobs
NATURAL JOIN employees
GROUP BY job_title
HAVING avg(salary) =
(SELECT max(avg(salary))
FROM employees
GROUP BY job_id); -- 19 linii

SELECT last_name
FROM employees
WHERE salary > ALL
(SELECT salary
FROM employees
WHERE department_id=80); -- nimic

SELECT last_name
FROM employees
WHERE salary > (SELECT max(salary)
FROM employees
WHERE department_id=80); -- nimic

--====================================================Ex 8.4 - Write a Query That Is Reliable and User Friendly:

SELECT last_name
FROM employees
WHERE department_id =
(SELECT department_id
FROM departments
WHERE department_name = '&Department_name'); -- dep: Executive -> 3 linii

SELECT last_name
FROM employees
WHERE department_id =
(SELECT department_id
FROM departments
WHERE upper(department_name) LIKE upper('%&Department_name%')); -- 3 linii (dep: Executive)

SELECT last_name,department_name
FROM employees
JOIN departments
ON employees.department_id = departments.department_id
WHERE departments.department_id IN
(SELECT department_id
FROM departments
WHERE upper(department_name) LIKE upper('%&Department_name%')); -- se pot adauga chiar si prescurtari la dep

-- lab answer:

SELECT last_name
FROM employees
WHERE salary > ANY (SELECT salary
FROM employees
WHERE last_name='Taylor')
ORDER BY last_name; -- nimic

SELECT last_name
FROM employees
WHERE salary > (SELECT min(salary)
FROM employees
WHERE last_name='Taylor')
ORDER BY last_name; -- nimic

--=============================================================CAP 9: Usig The Set Operators:

--=================================Ex 9.1: Describe the Set operators:
SELECT region_name
FROM regions; -- 4 linii

SELECT region_name
FROM regions
UNION
SELECT region_name
FROM regions; -- 4 linii

SELECT region_name
FROM regions
UNION ALL
SELECT region_name
FROM regions; -- 8 linii duble (4*2)

SELECT region_name
FROM regions
INTERSECT
SELECT region_name
FROM regions; -- 4 linii

SELECT region_name
FROM regions
MINUS
SELECT region_name
FROM regions; -- 0 linii

-- A UNION ALL with data type conversions:
desc old_dept; -- nu exista tabela

--===========================================================Ex 9.2: Using the Set Operators:
SELECT department_id, count(1)
FROM employees
WHERE department_id IN (20,30,40)
GROUP BY department_id; -- 3 linii : 20,30,40

SELECT 20,count(1)
FROM employees
WHERE department_id=20
UNION ALL
SELECT 30,count(1)
FROM employees
WHERE department_id=30
UNION ALL
SELECT 40,count(1)
FROM employees
WHERE department_id=40; -- 20 30 40

SELECT manager_id
FROM employees
WHERE department_id=20
INTERSECT
SELECT manager_id
FROM employees
WHERE department_id=30
MINUS
SELECT manager_id
FROM employees
WHERE department_id=40; -- 100

SELECT department_id, NULL,sum(salary)
FROM employees
GROUP BY department_id
UNION
SELECT NULL, manager_id, sum(salary)
FROM employees
GROUP BY manager_id
UNION ALL
SELECT NULL, NULL,sum(salary)
FROM employees; -- 31 linii

--===================================================EX 9.3: Control the Order of Rows Returned:
SELECT department_id dept, NULL mgr, sum(salary)
FROM employees
GROUP BY department_id
UNION ALL
SELECT NULL, manager_id, sum(salary)
FROM employees
GROUP BY manager_id
UNION ALL
SELECT NULL, NULL, sum(salary)
FROM employees; -- 32 linii

SELECT department_id dept, NULL mgr, sum(salary)
FROM employees
GROUP BY department_id
UNION
SELECT NULL, manager_id, sum(salary)
FROM employees
GROUP BY manager_id
UNION
SELECT NULL, NULL, sum(salary)
FROM employees; -- 31 linii

SELECT 'DEP: ' || to_char(nvl(department_id, 0)) dept, 'MAN: 0' mgr, sum(salary)
FROM employees
GROUP BY department_id
UNION
SELECT 'DEP: 0', 'MAN: ' || to_char(nvl(manager_id, 0)), sum(salary)
FROM employees
GROUP BY manager_id
UNION
SELECT 'Overall ', 'Sum: ', sum(salary)
FROM employees; -- 31 linii

-- lab answer:
SELECT employee_id, last_name
FROM employees
MINUS
SELECT employee_id,last_name
FROM job_history
JOIN employees USING (employee_id); -- 100 linii

SELECT last_name,job_title
FROM employees
JOIN jobs USING (job_id)
INTERSECT
SELECT last_name,job_title
FROM job_history h
JOIN jobs j ON (h.job_id=j.job_id)
JOIN employees e ON (h.employee_id=e.employee_id); -- 2 linii

SELECT job_title
FROM jobs
JOIN employees USING (job_id)
WHERE employee_id=&&Who
UNION
SELECT job_title
FROM jobs
JOIN job_history USING (job_id)
WHERE employee_id=&&Who; -- nu stiu ce valoare sa dau aici

--=========================================================CAP 10. Manipulating Data:
select count(*)
FROM employees
Where hire_date='21-apr-08'; --2

select *
from nls_database_parameters
where parameter='NLS_DATE_FORMAT'; -- DD-MON-RR

select count(*)
from hr.employees
where hire_date = '21/04/2008'; -- Eroare: spune ca nu e valida luna

--Insert Rows into a Table:
INSERT INTO hr.regions
VALUES (10,'Great Britain');
INSERT INTO hr.regions (region_name, region_id)
VALUES ('Australasia',11);
INSERT INTO hr.regions (region_id)
VALUES(12);
INSERT INTO hr.regions
VALUES (13,null); -- 4 linii inserate

INSERT INTO emp_copy (employee_id, last_name, hire_date, email, job_id)
VALUES (1000,'WATSON','03-Nov-13', 'jwatson@hr.com', 'SA_REP'); -- nu exista tabela

INSERT INTO regions_copy
SELECT *
FROM hr.regions; -- nu exista tabela: regions_copy

--================================================================================Ex 10.1 - Use the INSERT command:

INSERT INTO regions
VALUES (101,'Great Britain'); -- 1 rand inserat

INSERT INTO regions
VALUES (&Region_number,'&Region_name');

INSERT INTO regions
VALUES
((SELECT max(region_id)+1
FROM regions),
'Oceania'); -- 1 rand inserat

--Update Rows in a Table:
UPDATE employees
SET salary=10000
WHERE employee_id=206; -- 1 rand actualizat

UPDATE employees
SET salary=salary*1.1
WHERE last_name='Cambrault'; -- 2 linii actualizate

UPDATE employees
SET salary=salary*1.1
WHERE department_id IN
(SELECT department_id
FROM departments
WHERE department_name LIKE '%&Which_department%'); -- pt dep IT: 5 linii actualizate

UPDATE employees
SET department_id=80,
commission_pct=
(SELECT min(commission_pct)
FROM employees
WHERE department_id=80)
WHERE employee_id=206; -- 1 rand actualizat

UPDATE employees
SET salary=
(SELECT salary
FROM employees
WHERE employee_id=206);
UPDATE employees
SET salary=
(SELECT salary
FROM employees
WHERE last_name='Abel'); -- 107 linii actualizate

UPDATE employees
SET salary=
(SELECT max(salary)
FROM employees
WHERE last_name='Abel'); -- 107 linii actualizate

UPDATE employees
SET salary=10000
WHERE department_id IN
(SELECT department_id
FROM departments
WHERE department_name LIKE '%IT%'); -- 5 linii actualizate

--==============================================================Ex 10.2: Use the UPDATE command:

UPDATE regions
SET region_name='Scandinavia'
WHERE region_id=101; -- 1 linie actualizata

UPDATE regions
SET region_name='Iberia'
WHERE region_id > 100; -- 2 linii actualizate

UPDATE regions
SET region_id=
(region_id +
(SELECT max(region_id)
FROM regions))
WHERE region_id IN
(SELECT region_id
FROM regions
WHERE region_id > 100); -- 2 linii actualizate

COMMIT; -- commit complete

--Removing Rows with DELETE:
DELETE FROM employees
WHERE employee_id=206;
DELETE FROM employees
WHERE last_name LIKE 'S%';
DELETE FROM employees
WHERE department_id=&Which_department;
DELETE FROM employees
WHERE department_id IS NULL; -- pt dep IT: 1 rand sters

DELETE FROM employees
WHERE department_id IN
(SELECT department_id
FROM departments
WHERE location_id IN
(SELECT location_id
FROM locations
WHERE country_id IN
(SELECT country_id
FROM countries
WHERE region_id IN
(SELECT region_id
FROM regions
WHERE region_name='Europe')))); --ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found

--===================================================================Ex 10.3: Use the DELETE command:
DELETE FROM regions
WHERE region_id=204; -- 1 rand sters

DELETE FROM regions; -- ORA-02292: integrity constraint (HR.COUNTR_REG_FK) violated - child record found

DELETE FROM regions
WHERE region_id IN
(SELECT region_id
FROM regions
WHERE region_name='Iberia'); -- 1 rand sters

COMMIT; -- Commit complete

-- MERGE:
MERGE INTO employees e
USING new_employees n
ON (e.employee_id = n.employee_id)
WHEN MATCHED THEN
UPDATE SET e.salary=n.salary
WHEN NOT MATCHED THEN
INSERT (employee_id, last_name, salary, email, job_id)
VALUES (n.employee_id, n.last_name, n.salary, n.email, n.job_id); -- EROARE: nu exista tabela: new_employees

-- lab answer:
desc customers;
INSERT INTO customers(customer_id, cust_first_name, cust_last_name)
VALUES(
(SELECT max(customer_id) + 1
FROM customers),
'John', 'Watson'); -- nu exsita cust_first_name, cust_last_name

UPDATE customers
SET credit_limit=
(SELECT avg(credit_limit)
FROM customers)
WHERE cust_last_name='Watson'; -- nu exsita cust_last_name

INSERT INTO customers(customer_id, cust_first_name, cust_last_name, credit_limit)
SELECT customer_id+1, cust_first_name, cust_last_name, credit_limit
FROM customers
WHERE cust_last_name='Watson'; -- erori similare ca mai sus

UPDATE customers
SET cust_last_name='Ramklass',
cust_first_name='Roopesh'
WHERE customer_id=
(SELECT max(customer_id)
FROM customers); -- nu exista cust_last_name

--==================================================================CAP 11. Using DDL Statements to Create and Manage Tables

--Object Types:
SELECT object_type, count(object_type)
FROM user_objects
GROUP BY object_type
ORDER BY object_type; -- nu exista tabela: dba_objects

--=======================================================Ex 11.1 - Determine What Objects Are Accessible to Your Session:
SELECT object_type, count(*)
FROM user_objects
GROUP BY object_type; -- 7 linii

SELECT object_type, count(*)
FROM all_objects
GROUP BY object_type; -- 32 linii permisiuni pt schema "HR"

SELECT DISTINCT owner
FROM all_objects; -- 26 linii

--=======================================================Ex 11.2 - Investigate Table Structures:
SELECT table_name, cluster_name, iot_type
FROM user_tables; -- 39 linii

SELECT column_name, data_type, nullable
FROM user_tab_columns
WHERE table_name='REGIONS'; -- 2 linii

-- Use of type casting functions and automatic type casting:
CREATE TABLE typecast (d_col DATE, n_col NUMBER, v_col VARCHAR2(20));  -- tabel TYPECAST created

ALTER SESSION
SET nls_date_format='dd-mm-yy'; -- Session altered.

INSERT INTO typecast
VALUES (to_date('23-11-13'), to_number(1000), 'done correctly'); -- 1 rand inserat

INSERT INTO typecast
VALUES ('23-11-13', '1000', 'automatic casting'); -- 1 rand inserat

SELECT *
FROM typecast; -- 2 randuri

--====================================================EX 11.3: Investigate the Data Types in the HR Schema:

DESCRIBE employees;
DESCRIBE departments;

SELECT column_name, data_type, nullable, data_length, data_precision,
data_scale
FROM user_tab_columns
WHERE table_name='EMPLOYEES'; -- 11 linii

--Creating Tables with Column Specifications:
CREATE TABLE HR.EMP
(EMPNO NUMBER(4),
ENAME VARCHAR2(10),
HIREDATE DATE DEFAULT TRUNC(SYSDATE),
SAL NUMBER(7,2),
COMM NUMBER(7,2) DEFAULT 0.03); --tabel creat

INSERT INTO hr.emp (empno, ename, sal)
VALUES (1000, 'John', 1000.789); -- un rand inserat

SELECT *
FROM hr.emp;

-- Creating Tables from Subqueries:
CREATE TABLE employees_copy_nou AS
SELECT *
FROM employees; -- tabel creat

CREATE TABLE emp_dept AS
SELECT last_name AS ename,
       department_name AS dname,
       ROUND(sysdate - hire_date) AS service
FROM employees
NATURAL JOIN departments
ORDER BY dname, ename; -- tabel creat

SELECT *
FROM emp_dept
WHERE rownum < 10; -- 9 linii

CREATE TABLE no_emps AS
SELECT *
FROM employees
WHERE 1=2; -- tabel creat

--------------Altering Table Definitions After Creation:
--Adding columns:
ALTER TABLE emp
ADD (job_id number);
--Modifying columns:
ALTER TABLE emp
MODIFY (comm number(4,2) DEFAULT 0.05); --ORA-01440: column to be modified must be empty to decrease precision or scale
--Dropping columns:
ALTER TABLE emp
DROP COLUMN comm;
--Marking columns as unused:
ALTER TABLE emp
SET UNUSED COLUMN job_id;
--Renaming columns:
ALTER TABLE emp
RENAME COLUMN hiredate TO recruited;
--Marking the table as read-only:
ALTER TABLE emp
READ ONLY;

ALTER TABLE tablename
DROP UNUSED COLUMNS; --ORA-00942: table or view does not exist

--=================================================================EX 11.4: Create Tables:
INSERT INTO emps
SELECT employee_id, last_name, salary, department_id
FROM employees; -- 97 linii inserate

ALTER TABLE emps
MODIFY (hired DEFAULT sysdate);

INSERT INTO emps (empno, ename)
VALUES (99, 'Newman');
SELECT hired, count(1)
FROM emps
GROUP BY hired;

DROP TABLE emps;

CREATE TABLE dept(deptno NUMBER(2,0) CONSTRAINT dept_deptno_pk PRIMARY KEY
CONSTRAINT dept_deptno_ck CHECK (deptno BETWEEN 10 AND 90),
dname VARCHAR2(20) CONSTRAINT dept_dname_nn NOT NULL);

CREATE TABLE emp2(empno NUMBER(4,0) CONSTRAINT emp_empno_pk PRIMARY KEY,
ename VARCHAR2(20) CONSTRAINT emp_ename_nn NOT NULL,
mgr NUMBER(4,0) CONSTRAINT emp_mgr_fk REFERENCES emp (empno),
dob DATE,
hiredate DATE,
deptno NUMBER(2,0) CONSTRAINT emp_deptno_fk REFERENCES
dept(deptno)
ON DELETE SET NULL,
email VARCHAR2(30) CONSTRAINT emp_email_uk UNIQUE,
CONSTRAINT emp_hiredate_ck CHECK(hiredate>= dob + 365*16),
CONSTRAINT emp_email_ck
CHECK ((instr(email,'@') > 0) AND (instr(email,'.') > 0)));

--===================================================================Ex 11.5 - Work with Constraints:
CREATE TABLE emp2 AS
SELECT employee_id empno, last_name ename, department_id deptno
FROM employees;

CREATE TABLE dept2 AS
SELECT department_id deptno, department_name dname
FROM departments;

ALTER TABLE emp2
ADD CONSTRAINT emp_pk PRIMARY KEY (empno);

ALTER TABLE dept2
ADD CONSTRAINT dept_pk PRIMARY KEY (deptno);

ALTER TABLE emp2
ADD CONSTRAINT dept_fk FOREIGN KEY (deptno) REFERENCES dept2 ON
DELETE SET NULL;

INSERT INTO dept2
VALUES (10,'New Department');

INSERT INTO emp2
VALUES (9999,'New emp',99);

DROP TABLE emp2;
DROP TABLE dept2;

-- lab answer:
CREATE TABLE subscribers
(id NUMBER(4,0) CONSTRAINT sub_id_pk PRIMARY KEY,
name VARCHAR2(20) CONSTRAINT sub_name_nn NOT NULL);

CREATE TABLE telephones
(telno NUMBER(7,0) CONSTRAINT tel_telno_pk PRIMARY KEY
CONSTRAINT tel_telno_ck CHECK (telno BETWEEN 2000000 AND 3999999),
activated DATE DEFAULT sysdate,
active VARCHAR2(1) CONSTRAINT tel_active_nn NOT NULL
CONSTRAINT tel_active_ck CHECK(active='Y' OR active='N'),
subscriber NUMBER(4,0) CONSTRAINT tel_sub_fk REFERENCES subscribers,
CONSTRAINT tel_active_yn CHECK((active='Y' AND subscriber IS NOT NULL)
OR (active='N' AND subscriber IS NULL))
);

CREATE TABLE calls
(telno NUMBER (7,0) CONSTRAINT calls_telno_fk REFERENCES telephones,
starttime DATE CONSTRAINT calls_start_nn NOT NULL,
endtime DATE CONSTRAINT calls_end_nn NOT NULL,
CONSTRAINT calls_pk PRIMARY KEY(telno, starttime),
CONSTRAINT calls_endtime_ck CHECK (endtime >= starttime));