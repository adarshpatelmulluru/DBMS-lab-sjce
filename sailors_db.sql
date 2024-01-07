create database if not exists sailors;
use sailors;

create table if not exists Sailors(
	sid int primary key,
	sname varchar(35) not null,
	rating float not null,
	age int not null
);

create table if not exists Boat(
	bid int primary key,
	bname varchar(35) not null,
	color varchar(25) not null
);

create table if not exists reserves(
	sid int not null,
	bid int not null,
	sdate date not null,
	foreign key (sid) references Sailors(sid) on delete cascade,
	foreign key (bid) references Boat(bid) on delete cascade
);

insert into Sailors values
(1,"Albert", 5.0, 40),
(2, "Nakul", 5.0, 49),
(3, "Darshan", 9, 18),
(4, "Astorm Gowda", 2, 68),
(5, "Armstormin", 7, 19);


insert into Boat values
(1,"Boat_1", "Green"),
(2,"Boat_2", "Red"),
(103,"Boat_3", "Blue");

insert into reserves values
(1,103,"2023-01-01"),
(1,2,"2023-02-01"),
(2,1,"2023-02-05"),
(3,2,"2023-03-06"),
(5,103,"2023-03-06"),
(1,1,"2023-03-06");

update boat set bname ="hail storm" where bid = 103;

-- 1.	Find the colours of boats reserved by Albert 
select distinct b.color
from reserves r
join Boat b on r.bid = b.bid
join Sailors s on r.sid = s.sid
where s.sname = "Albert";

-- 2.	Find all sailor id’s of sailors who have a rating of at least 8 or reserved boat 103

select s.sid , s.sname
from sailors s 
left join reserves r on s.sid = r.sid
left join boat b on r.bid = b.bid
where s.rating >=8 or b.bid = 103;

-- 3.	 Find the names of sailors who have not reserved a boat whose name contains the string “storm”. Order the names in ascending order. 
select distinct s.sname,s.sid
from Sailors s
join reserves r on s.sid = r.sid
join boat b on r.bid = b.bid
where b.bname not like "%storm%"
order by s.sname;

-- 4.	Find the names of sailors who have reserved all boats.

select s.sname ,s.sid
from Sailors s
where not exists(
select b.bid 
from boat b
where not exists(
select *
from reserves r 
where r.sid=s.sid and r.bid = b.bid));

-- 5.	Find the name and age of the oldest sailor. 

select Sailors.sname,Sailors.age 
from Sailors
where age = (select max(age) from Sailors);

-- 6.	For each boat which was reserved by at least 5 sailors with age >= 40, find the boat id and the average age of such sailors.

insert into reserves values
(1,103,"2023-11-13"),
(2,103,"2023-01-01"),
(5,103,"2023-04-04");

insert into reserves values(4,103,"2023-05-05");
update sailors set age = 55 where sid = 5;

insert into reserves values(3,103,"2023-06-05");
insert into reserves values(5,103,"2024-05-05");


select r.bid,avg(s.age)
from Sailors s
join reserves r on s.sid=r.sid
where age >=40 
group by r.bid
having count(s.sid) >= 5;

-- Create a view that shows the names and colors of all the boats that have been reserved by a sailor with a specific rating:

-- drop view cumilateddata;
create view cumilateddata as
select distinct b.bname, b.color
from boat b
join reserves r on b.bid = r.bid
join sailors s on r.sid = s.sid
where s.rating = 5;

-- 8.	A trigger that prevents boats from being deleted If they have active reservations. 

delimiter //

create trigger chechkanddelete
before delete on boat
for each row
begin
if exists(select * from reserves where reserves.bid = old.bid)
then
signal sqlstate '45000' set message_text = "u cannot delete it , it is reserved";
end if;
end;//

delimiter ;

delete from boat where bid = 1; -- shall throw an error
