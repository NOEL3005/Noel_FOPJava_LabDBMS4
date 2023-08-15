drop database if exists E_commerce;
create database E_commerce;
use E_commerce;

create table Category(
cat_id int primary key, 
cat_name varchar(20) not null);

INSERT INTO Category (cat_id, cat_name) VALUES
    (1, 'BOOKS'),
    (2, 'GAMES'),
    (3, 'GROCERIES'),
    (4, 'ELECTRONICS'),
    (5, 'CLOTHES');
    select * from Category;
    
    CREATE TABLE Products (
    pro_id INT PRIMARY KEY,
    pro_name VARCHAR(20) NOT NULL,
    pro_desc VARCHAR(60),
    cat_id INT,
    FOREIGN KEY (cat_id) REFERENCES Category(cat_id));
    
     INSERT INTO Products (pro_id, pro_name, pro_desc, cat_id) VALUES
    (1, 'GTA V', 'Windows 7 and above with i5 processor and 8GB RAM', 2),
    (2, 'TSHIRT', 'SIZE-L with Black, Blue and White variations', 5),
    (3, 'ROG LAPTOP', 'Windows 10 with 15inch screen, i7 processor, 1TB SSD', 4),
    (4, 'OATS', 'Highly Nutritious from Nestle', 3),
    (5, 'HARRY POTTER', 'Best Collection of all time by J.K Rowling', 1),
    (6, 'MILK', '1L Toned MIlk', 3),
    (7, 'Boat Earphones', '1.5Meter long Dolby Atmos', 4),
    (8, 'Jeans', 'Stretchable Denim Jeans with various sizes and color', 5),
    (9, 'Project IGI', 'compatible with windows 7 and above', 2),
    (10, 'Hoodie', 'Black GUCCI for 13 yrs and above', 5),
    (11, 'Rich Dad Poor Dad', 'Written by RObert Kiyosaki', 1),
    (12, 'Train Your Brain', 'By Shireen Stephen', 1);
select * from Products;

create table Suppliers (
supp_id int primary key, 
supp_name varchar(50) not null, 
supp_city varchar(50) not null,
supp_phone varchar(50) not null);


INSERT INTO Suppliers (supp_id, supp_name, supp_city, supp_phone) VALUES
(1, 'Rajesh Retails', 'Delhi', '1234567890'),
(2, 'Appario Ltd.', 'Mumbai', '2589631470'),
(3, 'Knome products', 'Bangalore', '9785462315'),
(4, 'Bansal Retails', 'Kochi', '8975463285'),
(5, 'Mittal Ltd.', 'Lucknow', '7898456532');
 select * from Suppliers;   
 
 create table Suppliers_Pricing(
pricing_id int primary key,
pro_id int,
supp_id int,
supp_price INT DEFAULT 0,
FOREIGN KEY (pro_id) REFERENCES products(pro_id),
FOREIGN KEY (supp_id) REFERENCES suppliers(Supp_id));

INSERT INTO Suppliers_Pricing (pricing_id, pro_id, supp_id, supp_price) VALUES
(1, 1, 2, 1500),
(2, 3, 5, 30000),
(3, 5, 1, 3000),
(4, 2, 3, 2500),
(5, 4, 1, 1000),
(6, 12, 2, 780),
(7, 12, 4, 789),
(8, 3, 1, 31000),
(9, 1, 5, 1450),
(10, 4, 2, 999),
(11, 7, 3, 549),
(12, 7, 4, 529),
(13, 6, 2, 105),
(14, 6, 1, 99),
(15, 2, 5, 2999),
(16, 5, 2, 2999);
SELECT * FROM suppliers_pricing;

create table customers(
cus_id int primary key, 
cus_name varchar(20) not null,
cus_city varchar(30) not null,
cus_phone varchar(10) not null,
cus_gender char(30));


INSERT INTO Customers (cus_id, cus_name, cus_phone, cus_city, cus_gender) VALUES
    (1, 'AAKASH', '9999999999', 'DELHI', 'M'),
    (2, 'AMAN', '9785463215', 'NOIDA', 'M'),
    (3, 'NEHA', '9999999999', 'MUMBAI', 'F'),
    (4, 'MEGHA', '9994562399', 'KOLKATA', 'F'),
    (5, 'PULKIT', '7895999999', 'LUCKNOW', 'M');
select * from Customers;

create table Orders (
ord_id int primary key,
ord_date date not null,
cus_id int,
pricing_id int,
foreign key (cus_id) references customers(cus_id),
foreign key (pricing_id) references Suppliers_Pricing(pricing_id));
    

INSERT INTO Orders (ord_id,ord_date, cus_id, pricing_id) VALUES
(101, '2021-10-06', 2, 1),
(102, '2021-10-12', 3, 5),
(103, '2021-09-16', 5, 2),
(104, '2021-10-05', 1, 1),
(105, '2021-08-16', 4, 3),
(106,'2021-08-18', 1, 4),
(107, '2021-09-01', 3, 5),
(108,'2021-09-07', 5, 5),
(109, '2021-10-10', 5, 3),
(110, '2021-09-10', 2, 4),
(111,'2021-09-15', 4, 5),
(112, '2021-09-16', 4, 4),
(113, '2021-09-16', 1, 3),
(114, '2021-09-16', 3, 5),
(115,'2021-09-16', 5, 3),
(116,'2021-09-17', 2, 1);
select * from Orders;

create table ratings(
rating_id int primary key,
rat_ratstarts int,
ord_id int,
foreign key (ord_id) references Orders(ord_id));


INSERT INTO ratings (rating_ID, ord_id,rat_ratstarts) VALUES
(1, 101, 4),
(2, 102, 3),
(3, 103, 1),
(4, 104, 2),
(5, 105, 4),
(6, 106, 3),
(7, 107, 4),
(8, 108, 4),
(9, 109, 3),
(10, 110, 5),
(11, 111, 3),
(12, 112, 4),
(13, 113, 2),
(14, 114, 1),
(15, 115, 1),
(16, 116, 0);
select* from ratings;

select*
from customers
left join
orders
on
customers.cus_id=orders.cus_id;

select cus_name
from customers
left join orders on customers.cus_id= orders.cus_id
where ord_id is null;

select  cat_name
from products
right join category
using (cat_id)
where pro_id is null ;

select *
from customers
order by cus_city,cus_name desc;

select cus_city, count(*)
from customers
group by cus_city;

select cus_city, count(*)
from customers
group by cus_city
having count(*) > 1;

select  count(*)
from
customers 
inner join
orders
on
customers.cus_id= orders.cus_id
where
cus_name='AAKASH';

select count(*)
from customers c
inner join orders o on c.cus_id= o.cus_id
where cus_name='AAKASH';

select count(*)
from customers c
inner join orders 
using (cus_id)
where cus_name='AAKASH';

select count(*)
from customers 
inner join orders 
 using (cus_id)
where cus_name='AAKASH'
or
cus_name='AMAAN'
;
select count(*)
from customers
inner join orders
using (cus_id)
where cus_name in ('AAKASH','AMAAN')
;

select supp_name,sum(supp_price)
from suppliers inner join suppliers_pricing
using (supp_id)
group by supp_name;

select supp_name,sum(supp_price)
from suppliers inner join suppliers_pricing
using (supp_id)
group by supp_name
having sum(supp_price)>=3000;

select pro_name,supp_price
from
suppliers
inner join 
suppliers_pricing sp 
using(supp_id)
inner join
products
using (pro_id)
where supp_name='RAJESH RETAILS';

select cus_name
from
customers c
inner join
orders o using (cus_id)
group by cus_id
having count(ord_id)>3;

select ord_id ,pro_name
from customers
inner join orders using
(cus_id)
inner join suppliers_pricing
using(pricing_id)
inner join products 
using (pro_id)
where cus_name='AAKASH';

select distinct(pro_name)
from customers
inner join orders 
using (cus_id)
inner join suppliers_pricing
using(pricing_id)
inner join products 
using (pro_id)
where cus_name='AAKASH';

select pro_id, pro_name
from products
inner join suppliers_pricing
using (pro_id)
inner join orders 
using (pricing_id)
where  ord_date > '2021-10-05';

select cus_name
from customers
where cus_name like'A%';

SELECT
s.supp_id,
s.supp_name,
r.rat_ratstarts,
CASE
	WHEN r.rat_ratstarts = 5 THEN 'Excellent Service'
	WHEN r.rat_ratstarts > 4 THEN 'Good Service'
	WHEN r.rat_ratstarts > 2 THEN 'Average Service'
	ELSE 'Poor Service'
END AS Type_of_Service
FROM Suppliers s
JOIN Suppliers_Pricing sp ON s.supp_id = sp.supp_id
JOIN Products p ON sp.pro_id = p.pro_id
JOIN Orders o ON sp.pricing_id = o.pricing_id
LEFT JOIN ratings r ON o.ord_id = r.ord_id;