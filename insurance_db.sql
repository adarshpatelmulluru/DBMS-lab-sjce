create database if not exists insurance; 
use insurance;

create table person(
driver_id varchar(50) not null,
name varchar(50) not null,
address varchar(50) not null,
primary key (driver_id)
);

create table car(
regno varchar(50) not null,
model varchar(50) not null,
year int not null,
primary key (regno)
);

create table accident(
report_no int not null,
acc_date date,
location varchar(50),
primary key (report_no)
);

create table owns(
driver_id varchar(100) not null,
regno varchar(100) not null,
foreign key (driver_id) references person(driver_id) on delete cascade,
foreign key (regno) references car(regno) on delete cascade
);

create table participated (
driver_id varchar(100) not null,
regno varchar(50) not null,
report_no int not null,
damage_amt int not null,
foreign key (driver_id) references person(driver_id) on delete cascade,
foreign key (regno) references car(regno) on delete cascade,
foreign key (report_no) references accident(report_no)  -- avoid delete cascade for report_no
);

insert into person values
("d001","karthik","mulluru,mysuru"),
("d002","kramani","bomsandra,bengaluru"),
("d003","jyothika","j.p.nagar,bengaluru"),
("d004","ramana","kunthinagar, mysuru"),
("d005","jenamma","krupanagar,mysuru");

insert into car values
("KA-01-1234","maruti alto 800",2000),
("KA-02-2345","tata nexon",2018),
("KA-03-3456","nissan gtr",2010),
("KA-04-4567","hyundai creta",2019),
("KA-05-5678","wolksvagen polo",2017);

insert into accident values
(1234,"2023-01-01","mysuru"),
(1235,"2023-01-02","mysuru"),
(1236,"2023-01-03","benagluru"),
(1237,"2023-01-04","bengaluru"),
(1238,"2023-01-05","mysuru");

insert into owns values
("d001","KA-01-1234"),
("d002","KA-02-2345"),
("d002","KA-03-3456"),
("d003","KA-04-4567"),
("d004","KA-05-5678");

insert into participated values 
("d001","KA-01-1234",1234,450000),
("d002","KA-02-2345",1235,500000),
("d002","KA-03-3456",1236,550000),
("d003","KA-04-4567",1237,650000),
("d004","KA-05-5678",1238,800000);

update person set name = "smith" where driver_id = "d002";
update accident set acc_date = "2021-01-01" where report_no = 1234;
update accident set acc_date = "2021-03-13" where report_no = 1236;

-- 1.	Find the total number of people who owned cars that were involved in accidents in 2021.

select count(distinct p.driver_id)
from participated ptd
join person p on ptd.driver_id = p.driver_id
join accident a on ptd.report_no = a.report_no
where a.acc_date like "2021%";

-- 2.	Find the number of accidents in which the cars belonging to “Smith” were involved.  

 select count(ptd.report_no) as "no of accidents", ptd.driver_id ,p.name
 from participated ptd 
 join person p on ptd.driver_id = p.driver_id
 where p.name = 'smith'
 group by ptd.driver_id;
 
 -- 3.	Add a new accident to the database; assume any values for required attributes.  
 
 insert into accident values
 (1239,"2021-06-06","ballary");
 
 update car set model = "mazda" where regno = "KA-02-2345";
 
 -- 4.	Delete the Mazda belonging to “Smith”.
 
delete from car 
where model = 'mazda' and  regno in
(select car.regno from person p,owns o where p.driver_id = o.driver_id and o.regno = car.regno and p.name = "smith");
-- or
DELETE FROM car
WHERE model = 'Mazda' AND regno IN (SELECT regno FROM owns WHERE driver_id IN (SELECT driver_id FROM PERSON WHERE name = 'Smith'));

-- 5.	Update the damage amount for the car with license number “KA09MA1234” in the accident with report. 

update participated set damage_amt = 900000 where report_no = 1236 and regno = "KA-03-3456";

-- 6.	A view that shows models and year of cars that are involved in accident. 

-- drop view accidentdata;

create view accidentdata as
select c.model,c.year,c.regno,ptd.report_no
from car c
join participated ptd on c.regno = ptd.regno
;

select * from accidentdata;

-- 7.	A trigger that prevents a driver from participating in more than 3 accidents in a given year.
-- drop trigger avoiddriver;

delimiter //
create trigger avoiddriver
before insert on participated
for each row
begin
if 3<=(select count(*) from participated where participated.driver_id = new.driver_id)
then
signal sqlstate '45000' set message_text = 'u cannot man';
end if;
end;//

delimiter ;

insert into participated values
("d002","KA-03-3456",1239,688800);

insert into participated values
("d002","KA-03-3456",1240,688800); -- throws an error

