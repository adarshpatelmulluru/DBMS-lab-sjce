# DBMS-lab-sjce
Program 1. Consider the database schemas given below. 
Write ER diagram and schema diagram. The primary keys are underlined and the data types
are specified. <br>
Create tables for the following schema listed below by properly specifying the primary keys 
and foreign keys. <br>
Enter at least five tuples for each relation. <br>
Sailors database <br>
SAILORS (sid, sname, rating, age) <br>
BOAT(bid, bname, color) <br>
RSERVERS (sid, bid, date) <br>
Queries, View and Trigger <br>
1. Find the colours of boats reserved by Albert <br>
2. Find all sailor id’s of sailors who have a rating of at least 8 or reserved boat 103 <br>
3.  Find the names of sailors who have not reserved a boat whose name contains the string 
  “storm”. Order the names in ascending order. <br>
4. Find the names of sailors who have reserved all boats.<br>
5. Find the name and age of the oldest sailor. <br>
6. For each boat which was reserved by at least 5 sailors with age >= 40, find the boat id and 
  the average age of such sailors. <br>
7. Create a view that shows the names and colours of all the boats that have been reserved by
   a sailor with a specific rating. <br>
8. A trigger that prevents boats from being deleted If they have active reservations.<br>

Program 2. Consider the database schemas given below. 
Write ER diagram and schema diagram. The primary keys are underlined and the data types are 
specified.<br>
Create tables for the following schema listed below by properly specifying the primary keys and 
foreign keys. <br>
Enter at least five tuples for each relation. <br>
Insurance database <br>
PERSON (driver id#: string, name: string, address: string) <br>
CAR (regno: string, model: string, year: int) <br>
ACCIDENT (report_ number: int, acc_date: date, location: string) <br>
OWNS (driver id#: string, regno: string) <br>
PARTICIPATED(driver id#:string, regno:string, report_ number: int,damage_amount: int) <br>
1. Find the total number of people who owned cars that were involved in accidents in 2021.  <br>
2. Find the number of accidents in which the cars belonging to “Smith” were involved.<br>
3. Add a new accident to the database; assume any values for required attributes. <br>
4. Delete the Mazda belonging to “Smith”.   <br>
5. Update the damage amount for the car with license number “KA09MA1234” in the accident 
with report.<br>
6. A view that shows models and year of cars that are involved in accident.<br>
7. A trigger that prevents a driver from participating in more than 3 accidents in a given year.<br>

Program 3. Consider the database schemas given below. 
Write ER diagram and schema diagram. The primary keys are underlined and the data types are 
specified. <br>
Create tables for the following schema listed below by properly specifying the primary keys and 
foreign keys. <br>
Enter at least five tuples for each relation. <br>
Order processing database <br>
Customer (Cust#:int, cname: string, city: string) <br>
Order (order#:int, odate: date, cust#: int, order-amt: int) <br>
Order-item (order#:int, Item#: int, qty: int) <br>
Item (item#:int, unitprice: int) <br>
Shipment (order#:int, warehouse#: int, ship-date: date) <br>
Warehouse (warehouse#:int, city: string) <br>
1. List the Order# and Ship_date for all orders shipped from Warehouse# "W2". <br>
2. List the Warehouse information from which the Customer named "Kumar" was supplied his 
orders. Produce a listing of Order#, Warehouse#.<br>
3. Produce a listing: Cname, #ofOrders, Avg_Order_Amt, where the middle column is the total 
number of orders by the customer and the last column is the average order amount for that 
customer. (Use aggregate functions)  <br>
4. Delete all orders for customer named "Kumar".<br>
5. Find the item with the maximum unit price. <br>
6. A trigger that updates order_amout based on quantity and unitprice of order_item <br>
7. Create a view to display orderID and shipment date of all orders shipped from a warehouse <br>

Program 4: Consider the database schemas given below. <br>
Write ER diagram and schema diagram. The primary keys are underlined and the data types are 
specified. <br>
Create tables for the following schema listed below by properly specifying the primary keys and 
foreign keys. <br>
Enter at least five tuples for each relation. <br>
Student enrollment in courses and books adopted for each course <br>
STUDENT (regno: string, name: string, major: string, bdate: date) <br>
COURSE (course#:int, cname: string, dept: string) <br>
ENROLL(regno:string, course#: int,sem: int,marks: int)<br> 
BOOK-ADOPTION (course#:int, sem: int, book-ISBN: int) <br>
TEXT (book-ISBN: int, book-title: string, publisher: string,author: string) <br>
1. Demonstrate how you add a new text book to the database and make this book be 
adopted by some department.   <br>
2. Produce a list of text books (include Course #, Book-ISBN, Book-title) in the alphabetical 
order for courses offered by the ‘CS’ department that use more than two books.<br>
3. List any department that has all its adopted books published by a specific publisher.
4. List the students who have scored maximum marks in ‘DBMS’ course.<br>
5. Create a view to display all the courses opted by a student along with marks obtained.
6. Create a trigger that prevents a student from enrolling in a course if the marks 
prerequisite is less than  40.<br>

Program 5. Consider the database schemas given below. 
Write ER diagram and schema diagram. The primary keys are underlined and the data types are 
specified. <br>
Create tables for the following schema listed below by properly specifying the primary keys and 
foreign keys. <br>
Enter at least five tuples for each relation. <br>
Company Database: <br>
EMPLOYEE (SSN, Name, Address, Sex, Salary, SuperSSN, DNo) <br>
DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate) <br>
DLOCATION (DNo,DLoc) <br>
PROJECT (PNo, PName, PLocation, DNo) <br>
WORKS_ON (SSN, PNo, Hours) <br>
1. Make a list of all project numbers for projects that involve an employee whose last name <br>
is ‘Scott’, either as a worker or as a manager of the department that controls the project. <br>
2. Show the resulting salaries if every employee working on the ‘IoT’ project is given a 10 
percent raise.   <br>
3. Find the sum of the salaries of all employees of the ‘Accounts’ department, as well as the 
maximum salary, the minimum salary, and the average salary in this department   <br>
4. Retrieve the name of each employee who works on all the projects controlled by 
department number 5 (use NOT EXISTS operator).  <br>
5. For each department that has more than five employees, retrieve the department 
number and the number of its employees who are making more than Rs. 6,00,000.  <br>
6. Create a view that shows name, dept name and location of all employees.  
7. Create a trigger that prevents a project from being deleted if it is currently being worked 
by any employee.  <br>
   


  

  
  
  
   


