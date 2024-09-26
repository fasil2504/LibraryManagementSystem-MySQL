/*
Create a database named library and following TABLES in the database: 
*/
create database library;
use library;

/*
Create TABLE in the database:
1. Branch 
*/
create table branch(
Branch_no int auto_increment PRIMARY KEY,
Manager_Id int,
Branch_address varchar(250),
Contact_no char(10));

INSERT INTO branch (Branch_no, Manager_Id, Branch_address, Contact_no) 
VALUES (1,101,'Mongam','6576436786'),
(2,123,'Valluvambram','5765767654'),
(3,654,'Thrippanchi','273t767574'),
(4,323,'Edavanna','2456743344'),
(5,222,'Areekkode','3242345323');

select * from branch;

/*
Create TABLE in the database:
2. Employee 
*/
create table employee(
Emp_Id int PRIMARY KEY auto_increment,
Emp_name varchar(50),
Position varchar(50),
Salary decimal(10,2),
Branch_no int,
FOREIGN KEY(Branch_no) references library.branch(Branch_no)
);

INSERT INTO employee (Emp_Id, Emp_name, Position, Salary, Branch_no) 
VALUES (6,'Akib sadin','Manager',65000.00,1),
(7,'Lami p','Accountant',25000.00,3),
(8,'Minha','Security',10000.00,3),
(9,'Favas p','Accountant',20000.00,1),
(10,'Fayis p','Accountant',55000.00,5),
(11,'Unni','Security',12000.00,3),
(12,'Keshav','manager',52000.00,3),
(13,'Anu','Sales man',18000.00,3),
(14,'Jafer','Sales man',14000.00,3);

select * from employee;
/*
Create TABLE in the database:
3. Books
*/
create table books( 
ISBN int PRIMARY KEY auto_increment,
Book_title varchar(50),
Category varchar(20),
Rental_Price decimal(5,2),
Status char(5),
Author varchar(50),
Publisher varchar(50)
);

INSERT INTO books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) 
VALUES (1,'Making India Awesome','Categ1',25.00,'yes','Chetan Bhagat','fasil'),
(2,'One Indian Girl history','Categ2',15.00,'yes','Chetan Bhagat','fasil'),
(3,'A Million Mutinies Now','Categ2',30.00,'yes','V.S. Naipaul','savad'),
(4,'A Brush with Life','Categ1',20.00,'yes','Satish Gujral','savad'),
(5,'Half Girlfriend','Categ1',49.00,'no','Chetan Bhagat','fasil'),
(6,'History of Mahathma gandhi','categ4',34.00,'no','Bh.ayartas','binu');

select * from books;
/*
Create TABLE in the database:
4. Customer
*/
create table Customer( 
Customer_Id int PRIMARY KEY auto_increment,
Customer_name varchar(50),
Customer_address varchar(200),
Reg_date date
);

INSERT INTO customer (Customer_Id, Customer_name, Customer_address, Reg_date) 
VALUES (1,'Jan maunu','calicut, kerala','2023-02-03'),
(2,'Abhi ashok','checnnai,thamilnadu','2023-02-03'),
(3,'Kasim mansoor','malappuram,kerala','2021-03-11'),
(4,'Keyath manu','kannur, kerala','2023-02-05'),
(5,'Minu ava','kochi kerala','2021-03-11');

select * from Customer;
/*
Create TABLE in the database:
5. IssueStatus
*/
create table IssueStatus( 
Issue_Id int PRIMARY KEY auto_increment, 
Issued_cust_id int,
Issued_book_name varchar(50),
Issue_date date,
Isbn_book int, 
FOREIGN KEY(Issued_cust_id) references library.Customer(customer_id),
FOREIGN KEY(Isbn_book) references library.books(ISBN)
);

INSERT INTO issuestatus (Issue_Id, Issued_cust_id, Issued_book_name, Issue_date, Isbn_book) 
VALUES (1,1,'One Indian Girl','2022-10-12',2),
(2,2,'A Brush with Life','2023-06-02',4),
(3,4,'A Million Mutinies Now','2022-10-20',3),
(4,5,'A Million Mutinies Now','2022-10-22',3),
(5,2,'One Indian Girl','2022-10-21',2);

select * from issuestatus;
/*
Create TABLE in the database:
6. ReturnStatus 
*/
create table ReturnStatus( 
Return_Id int PRIMARY KEY auto_increment, 
Return_cust varchar(50),
Return_book_name varchar(50),
Return_date date,
Isbn_book2 int,
FOREIGN KEY(Isbn_book2) references library.books(ISBN)
);

INSERT INTO returnstatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) 
VALUES (1,'1','One Indian Girl','2022-10-12',2),
(2,'5','A Million Mutinies Now','2022-10-12',3),
(3,'2','One Indian Girl','2022-10-12',2);

select * from returnstatus;
/*
1. Retrieve the book title, category, and rental price of all available books. 
*/
select Book_title,Category,Rental_Price from library.books
where Status='yes';
/*
2. List the employee names and their respective salaries in descending order of salary. 
*/
select Emp_name,Salary from library.employee
order by Salary desc;
/*
3. Retrieve the book titles and the corresponding customers who have issued those books. 
*/
select i.Issue_Id,b.Book_title,c.Customer_name from library.issuestatus as i left join library.books as b on i.Isbn_book=b.ISBN
left join library.customer as c on i.Issued_cust_id=c.Customer_Id;

/*
4. Display the total count of books in each category. 
*/
select Category,count(*) as Total_count from library.books 
group by Category;
/*
5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
*/
select Emp_name from library.employee
where Salary>50000;
/*
6. List the customer names who registered before 2022-01-01 and have not issued any books yet. 
*/
select Customer_name from library.customer
where Reg_date<date('2022-01-01') and Customer_Id not in(select Issued_cust_id from library.issuestatus);
/*
7. Display the branch numbers and the total count of employees in each branch. 
*/
select Branch_no,count(Branch_no) as Total_empoyees from library.employee
group by  Branch_no;
/*
8. Display the names of customers who have issued books in the month of June 2023.
*/
select Customer_name from library.customer 
where Customer_Id in (
select Issued_cust_id from library.issuestatus 
where year(Issue_date)=2023 and month(Issue_date)=6);

/*
9. Retrieve book_title from book table containing history. 
*/
select Book_title from library.books
where Book_title like '%history%';

/*
10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
*/
select Branch_no,count(Branch_no) as Count_of_employess from library.employee group by Branch_no
having count(Branch_no)>5;

/*
11. Retrieve the names of employees who manage branches and their respective branch addresses.
*/
select e.Emp_name,b.Branch_address from library.employee as e left join library.branch as b on e.Branch_no=b.Branch_no;
/*
12.  Display the names of customers who have issued books with a rental price higher than Rs. 25.
*/
select Customer_name from library.customer where Customer_Id in (
select Issued_cust_id from library.issuestatus where Isbn_book in(
select ISBN from library.books where Rental_Price>25));



