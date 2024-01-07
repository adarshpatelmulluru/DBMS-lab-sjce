create database enrollment;

use enrollment;

create table student(
regno varchar(50) not null,
name varchar(50) not null,
major varchar(50),
bdate date,
primary key(regno)
);
desc student;

create table course(
course_id int not null primary key,
cname varchar(50) not null,
dept varchar(50)
);
desc course;

create table enroll(
regno varchar(50),
course_id int not null,
sem int not null,
marks int not null default 20,
foreign key (regno) references student(regno) on delete cascade,
foreign key (course_id) references course(course_id) on delete cascade
);
desc enroll;

create table text(
book_isbn int not null primary key,
book_title varchar(50),
publisher varchar(50),
author varchar(50)
);

desc text;

create table bookadoption(
course_id int not null,
sem int,
book_isbn int not null,
foreign key (course_id) references course(course_id) on delete cascade,
foreign key (book_isbn) references text(book_isbn) on delete cascade
);
desc bookadoption;

insert into student values
("s01","abhuday","computer science","2003-2-2"),
("s02","abhinava","electronics","2003-12-03"),
("s03","bimani","polymer science","2003-01-14"),
("s04","bhargavi","mathematics","2003-01-01"),
("s05","sharamni","quantum chemistry","2003-03-03");

insert into course values
(01,"DBMS","CSE"),
(02,"analog signals","ECE"),
(03,"polymers","PSE"),
(04,"geometry","Math"),
(05,"networks","CSE");

insert into enroll values
("s01",01,5,75),
("s02",02,7,88),
("s03",03,3,60),
("s04",04,7,55),
("s05",05,5,99);

insert into text values
(01234,"adavnced computing","pearson","pushkar"),
(02345,"signals","mckinsey","jeorge bailey"),
(02347,"monomers","dharma","R.D.sharma"),
(02357,"euclid's axioms","arihant","D.C.pandey"),
(02378,"higgs boson network","pearson","damodardas");

insert into bookadoption values
(01,5,01234),
(02,7,02345),
(03,3,02347),
(04,7,02357),
(05,5,02378);

update bookadoption set course_id = 01 where book_isbn = 02378;

-- 1.	Demonstrate how you add a new text book to the database and make this book be adopted by some department.  

insert into text values
(02395,"qunatum computimg","brian co","tsang-ma-un");
insert into bookadoption values
(01,5,02395);


-- 2. Produce a list of text books (include Course #, Book-ISBN, Book-title) in alphabetical order for courses offered by the ‘CS’ department that use more than two books.
SELECT ba.course_id, ba.book_isbn, t.book_title
FROM bookadoption ba
JOIN course c ON ba.course_id = c.course_id
JOIN text t ON ba.book_isbn = t.book_isbn
WHERE c.dept = 'CSE' and
2<(select count(book_isbn)
from bookadoption b
where c.course_id = b.course_id)
order by t.book_title;

-- 3.	List any department that has all its adopted books published by a specific publisher. 
select c.dept,count(distinct ba.book_isbn) as book_count
from bookadoption ba
join course c on ba.course_id = c.course_id
join text t on ba.book_isbn = t.book_isbn
where t.publisher = 'pearson'
group by c.dept
having count(ba.book_isbn) = (select count(book_isbn) from text where publisher ='pearson');

-- 4.	List the students who have scored maximum marks in ‘DBMS’ course. 

select s.name,s.regno 
from enroll e
join student s on e.regno = s.regno
join course c on e.course_id = c.course_id
where c.cname='DBMS' and e.marks = (select max(marks) from enroll e where e.course_id = c.course_id);

-- 5.	Create a view to display all the courses opted by a student along with marks obtained.

create view Display as
select s.regno,s.name,c.cname,e.marks
from student s,course c,enroll e
where e.regno=s.regno and e.course_id=c.course_id;

-- or by using joins 

create view students as
select s.regno,s.name,c.cname,e.marks
from student s
join enroll e on s.regno = e.regno
join course c on  e.course_id=c.course_id;

-- 6.	Create a trigger that prevents a student from enrolling in a course if the marks prerequisite is less than  40

delimiter //

 create trigger checkandinsert
before insert on enroll
for each row
begin
 if(new.marks<40)
 then
 signal sqlstate '45000' set message_text='u have less marks cannot be admitted';
 end if;
 end;//
 
 delimiter ;
 
 insert into enroll values
 ("s03",5,7,22);				-- throws an error because marks < 40
