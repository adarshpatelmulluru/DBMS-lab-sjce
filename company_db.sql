use company;

create table if not exists employee(
	ssn varchar(35) primary key,
	name varchar(35) not null,
	address varchar(255) not null,
	sex varchar(7) not null,
	salary int not null,
	super_ssn varchar(35),
	d_no int,
	foreign key (super_ssn) references Employee(ssn) on delete set null
);

create table if not exists department(
	d_no int primary key,
	dname varchar(100) not null,
	mgr_ssn varchar(35),
	mgr_start_date date,
	foreign key (mgr_ssn) references Employee(ssn) on delete cascade
);

create table if not exists dLocation(
	d_no int not null,
	d_loc varchar(100) not null,
	foreign key (d_no) references Department(d_no) on delete cascade
);

create table if not exists project(
	p_no int primary key,
	p_name varchar(25) not null,
	p_loc varchar(25) not null,
	d_no int not null,
	foreign key (d_no) references Department(d_no) on delete cascade
);

create table if not exists worksOn(
	ssn varchar(35) not null,
	p_no int not null,
	hours int not null default 0,
	foreign key (ssn) references Employee(ssn) on delete cascade,
	foreign key (p_no) references Project(p_no) on delete cascade
);

INSERT INTO employee VALUES
("01NB235", "Chandan_Krishna","Siddartha Nagar, Mysuru", "Male", 1500000, "01NB235", 5),
("01NB354", "Employee_2", "Lakshmipuram, Mysuru", "Female", 1200000,"01NB235", 2),
("02NB254", "Employee_3", "Pune, Maharashtra", "Male", 1000000,"01NB235", 4),
("03NB653", "Employee_4", "Hyderabad, Telangana", "Male", 2500000, "01NB354", 5),
("04NB234", "Employee_5", "JP Nagar, Bengaluru", "Female", 1700000, "01NB354", 1);


INSERT INTO department VALUES
(001, "Human Resources", "01NB235", "2020-10-21"),
(002, "Quality Assesment", "03NB653", "2020-10-19"),
(003,"System assesment","04NB234","2020-10-27"),
(005,"Production","02NB254","2020-08-16"),
(004,"Accounts","01NB354","2020-09-4");


INSERT INTO dLocation VALUES
(001, "Jaynagar, Bengaluru"),
(002, "Vijaynagar, Mysuru"),
(003, "Chennai, Tamil Nadu"),
(004, "Mumbai, Maharashtra"),
(005, "Kuvempunagar, Mysuru");

INSERT INTO project VALUES
(241563, "System Testing", "Mumbai, Maharashtra", 004),
(532678, "IOT", "JP Nagar, Bengaluru", 001),
(453723, "Product Optimization", "Hyderabad, Telangana", 005),
(278345, "Yeild Increase", "Kuvempunagar, Mysuru", 005),
(426784, "Product Refinement", "Saraswatipuram, Mysuru", 002);

INSERT INTO worksOn VALUES
("01NB235", 278345, 5),
("01NB354", 426784, 6),
("04NB234", 532678, 3),
("02NB254", 241563, 3),
("03NB653", 453723, 6);

	
alter table employee
add constraint foreign key (d_no) references department(d_no) on delete cascade;	

select * from employee;
select * from department;
select * from dlocation;
select * from project;
select * from workson;

update employee set name = "scott" where employee.ssn = "01NB354";

update employee set name = "dharma scott" where ssn = "03NB653";

-- displays the project no ,project name which are undertaken by scott
-- 1.	Make a list of all project numbers for projects that involve an employee whose last name is ‘Scott’, either as a worker or as a manager of the department that controls the project.  

select distinct p.p_no,p.p_name
from project p
left join workson w on p.p_no = w.p_no
left join employee e on w.ssn=e.ssn
where e.name like "%scott%"
group by p.p_no
order by p.p_name;

-- displays new salary after hike of 10% in the IOT department employees 
-- 2.	Show the resulting salaries if every employee working on the ‘IoT’ project is given a 10 percent raise.  

select e.ssn,e.name, 1.1 * e.salary as "as10% raise in salary"
from employee e
left join workson w on e.ssn = w.ssn
left join project p on w.p_no = p.p_no
where p.p_name = 'IOT';

-- query which displays employees with sum of salaries,max salary,min salary,avg salary of accounts department
-- 3.	Find the sum of the salaries of all employees of the ‘Accounts’ department, as well as the maximum salary, the minimum salary, and the average salary in this department  

select e.name , sum(e.salary) as "sum of salaries" , max(e.salary) as "maximum salary",min(e.salary) as "minimum salry",avg(e.salary) as "average salary"
from employee e join department d on e.d_no = d.d_no
where d.dname = 'Accounts'
group by e.name;

-- query that select employee details who work on all projects under the d_no 2
-- 4.	Retrieve the name of each employee who works on all the projects controlled by department number 2 (use NOT EXISTS operator).

select e.name,e.ssn,e.d_no
from employee e
where not exists(
select p.p_no
from project p
where p.d_no=5
and not exists(
select *
from workson w
where e.ssn = w.ssn and p.p_no=w.p_no));

-- query which shows department no , count of employees of a department having atleast 2 employees in it having salary above 6Lacks
-- 5.	For each department that has more than five employees, retrieve the department number and the number of its employees who are making more than Rs. 6,00,000. 

select e.d_no , count(e.ssn) 
from employee e
join department d on e.d_no = d.d_no
where e.salary >=600000
group by d.d_no
having count(d.d_no)>=2;

SELECT d_no, COUNT(*) AS EmployeeCount
FROM employee
WHERE d_no in(
    SELECT d_no
    FROM employee
    GROUP BY d_no
    HAVING COUNT(ssn) >=2
) AND salary > 600000
GROUP BY d_no;

--  view which shows employee name , department name and ,department location
-- 6.	Create a view that shows name, dept name and location of all employees. 

create view Details as
select e.name,d.dname,dl.d_loc
from employee e
left join department d on e.d_no = d.d_no
left join dlocation dl on d.d_no = dl.d_no;

select * from Details;

-- 7.	Create a trigger that prevents a project from being deleted if it is currently being worked by any employee.

delimiter //

create trigger checkbeforeonce
before delete on project
for each row
begin
if exists (select * from workson where p_no=old.p_no)
then
signal sqlstate '45000' set message_text = 'employee is working on this !';
end if;
end;//

delimiter ;

delete from Project where p_no=241563; 
-- this shall throw error