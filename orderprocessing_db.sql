create database if not exists orderProcessing;

use orderprocessing;

create table customer(
cust_id int not null,
cname varchar(50) not null,
city varchar(50) not null,
primary key (cust_id)
);

desc customer;

create table orders(
order_id int not null,
odate date,
cust_id int not null,
order_amt int,
primary key (order_id),
foreign key (cust_id) references customer(cust_id) on delete cascade
);

create table items(
item int not null,
unitprice  int not null,
primary key (item)
);

create table orderitem(
order_id int not null,
item int not null,
qty int not null,
foreign key (order_id) references orders(order_id) on delete cascade,
foreign key (item) references items(item) on delete cascade
);

create table warehouse (
warehouse_id int not null,
city varchar(50) not null,
primary key(warehouse_id)
);

create table shipment(
order_id int not null,
warehouse_id int not null,
ship_date date not null default "2000-01-01",
foreign key (order_id) references orders(order_id) on delete cascade,
foreign key (warehouse_id) references warehouse(warehouse_id) on delete cascade
);

insert into customer values
(1,"arjun","mulluru,mysuru"),
(2,"kumar","mulluru,H.D.kote"),
(3,"pandu","rajarajeshwarinagar,bengaluru"),
(4,"ranga","electronic city,bengaluru"),
(5,"marthanda verma","travancore");

insert into orders values
(101,"2023-01-01",1,4500),
(102,"2023-01-12",2,7000),
(103,"2023-02-13",3,6000),
(104,"2023-03-04",4,8900),
(105,"2023-03-28",2,12000),
(106,"2023-04-11",2,13000);

insert into items values
(5,20),
(6,10),
(7,50),
(8,80),
(9,35),
(10,88);

insert into orderitem values
(101,5,10),
(102,6,12),
(103,7,5),
(104,8,8),
(105,9,13),
(106,10,4);

insert into warehouse values
(1001,"mysuru"),
(1002,"H.D.kote"),
(1003,"bengaluru"),
(1004,"benagluru"),
(1005,"travancore");

insert into shipment values
(101,1001,"2023-08-08"),
(102,1002,"2023-09-19"),
(103,1003,"2023-10-10"),
(104,1005,"2024-01-01"),
(105,1004,"2024-01-10"),
(106,1002,"2023-12-31");

-- 1.	List the Order# and Ship_date for all orders shipped from Warehouse# "W2". 

select order_id as orderid, ship_date as "shipment date"
from shipment 
where warehouse_id = 1002;

-- 2.	List the Warehouse information from which the Customer named "Kumar" was supplied his orders. Produce a listing of Order#, Warehouse#. 

select s.order_id,s.warehouse_id
from shipment s
join orders o on s.order_id=o.order_id
join customer c on o.cust_id = c.cust_id
where c.cname ="kumar"
order by warehouse_id;

-- 3.	Produce a listing: Cname, #ofOrders, Avg_Order_Amt, where the middle column is the total number of orders by the customer and the last column is the average order amount for that customer. (Use aggregate functions)

select c.cname,count(order_id) as nooforders,avg(order_amt) as avg_of_order_amount
from customer c
join orders o on c.cust_id = o.cust_id
group by c.cust_id;

-- 4.	Delete all orders for customer named "Kumar". 

delete from orders where cust_id = (select cust_id from customer where cname = "kumar");

-- 5.	Find the item with the maximum unit price.
select item as "item with max unit price",unitprice
from items
group by item
order by unitprice desc
limit 1;

-- or can solved as

select item ,unitprice
from items 
where unitprice = (select max(unitprice) from items);

-- 7.	Create a view to display orderID and shipment date of all orders shipped from a warehouse 5. 

drop view warehouse_1005;

create view warehouse_1005 as
select order_id,ship_date
from shipment
where warehouse_id = 1005
;

select * from warehouse_1005;

-- 6.	A trigger that updates order_amout based on quantity and unitprice of order_item
-- drop trigger autoupdater; use only when u had a trigger named autoupdater
delimiter //

create trigger autoupdater
after insert on orderitem
for each row
begin
update orders set order_amt = (new.qty*(select distinct unitprice from items where items.item = new.item)) where orders.order_id = new.order_id;
end;//

delimiter ;

insert into orders values
(108,"2023-12-12",2,4900);

insert into orderitem values
(108,9,10); -- this shall update orders table order_id =108 to new value


