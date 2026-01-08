
-- Checking all records from each table 
SELECT * from books
SELECT * from branch
SELECT * from members
SELECT * from employees
SELECT * from return_status
SELECT * from issued_status

-- Finding Null values in each table
select * from books 
where isbn is NULL
or book_title is NULL
or author is null or 
category is null or 
rental_price is null or 
status is null OR
author is null 
or publisher is NULL
-- No null values found in books table
-- the books is the biggest dataset.

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
insert into books (isbn,book_title,category,rental_price,status,author,publisher)values('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')
select * from books


-- -- Task 2: Update an Existing Member's Address
Update members
set member_address='123 main street'
where member_id = 'C106'
select * from members;

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
Delete from issued_status
where issued_id='IS125'
select * from issued_status

-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
select * from issued_status
where issued_emp_id = 'E102'


-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
select ist.issued_emp_id,e.emp_name from issued_status as ist
join employees as e 
on  ist.issued_emp_id=  e.emp_id
GROUP BY 1 ,2
HAVING count(ist.issued_id)>1


-- CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
Create table book_issued_cnt 
as
select b.isbn, b.book_title,count(ist.issued_id) 
from books as b 
join issued_status as ist
 on issued_book_isbn = b.isbn
GROUP BY 1,2

-- Task 8: Find Total Rental Income by Category:

select book.category, sum(book.rental_price) as total_income , count(*)
from books as book
join issued_status as ist
on ist.issued_book_isbn = book.isbn
GROUP BY 1


-- List Members Who Registered in the Last 180 Days:
select * from members
where reg_date >= current_date - interval '180 days' 


-- task 10 List Employees with Their Branch Manager's Name and their branch details:

select e.*, b.manager_id, e2.emp_name 
from employees as e
join branch as b 
on e.branch_id = b.branch_id
join employees e2 
on e2.emp_id = b.manager_id


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
Create table books_above_7usd
as
select * from books
where rental_price>7

select * from books_above_7usd

-- Task 12: Retrieve the List of Books Not Yet Returned
select ist.issued_book_name from issued_status as ist
 left join  return_status as rst
on ist.issued_id = rst.issued_id
where rst.return_id is null


select * from issued_status