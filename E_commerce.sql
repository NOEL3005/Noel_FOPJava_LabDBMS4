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

create table Orders (
ord_id int primary key,
ord_date date not null,
ord_amt int not null,
cus_id int,
pricing_id int,
foreign key (cus_id) references customers(cus_id),
foreign key (pricing_id) references Suppliers_Pricing(pricing_id));
    

INSERT INTO Orders (ord_id,ord_amt,ord_date, cus_id, pricing_id) VALUES
(101, 1500 ,'2021-10-06', 2, 1),
(102, 1000,'2021-10-12', 3, 5),
(103, 30000,'2021-09-16', 5, 2),
(104, 1500,'2021-10-05', 1, 1),
(105, 3000,'2021-08-16', 4, 3),
(106, 1450,'2021-08-18', 1, 4),
(107, 789,'2021-09-01', 3, 5),
(108,780,'2021-09-07', 5, 5),
(109, 3000,'2021-10-10', 5, 3),
(110, 2500,'2021-09-10', 2, 4),
(111,1000,'2021-09-15', 4, 5),
(112,789 ,'2021-09-16', 4, 4),
(113,31000 ,'2021-09-16', 1, 3),
(114,1000 ,'2021-09-16', 3, 5),
(115,3000,'2021-09-16', 5, 3),
(116,99,'2021-09-17', 2, 1);


create table ratings(
rating_id int primary key,
rat_ratstarts int,
ord_id int,
foreign key (ord_id) references Orders(ord_id));


INSERT INTO ratings (rating_ID, ord_id,rat_ratstarts) VALUES
(1 ,101, 4),
(2 ,102 ,3),
(3, 103, 1),
(4 ,104 ,2),
(5, 105, 4),
(6, 106, 3),
(7, 107, 4),
(8, 108, 4),
(9, 109, 3),
(10, 110, 5),
(11, 111 ,3),
(12, 112, 4),
(13, 113, 2),
(14, 114, 1),
(15, 115, 1),
(16, 116, 0);


/*4) Display the total number of customers based on gender who have placed individual orders of worth at least Rs. 3000:*/

SELECT c.cus_gender, COUNT(DISTINCT o.cus_id) AS total_customers
FROM customers c
JOIN orders o ON c.CUS_ID = o.CUS_ID
WHERE o.ord_amt >= 3000
GROUP BY c.cus_gender;

/*5) Display all the orders along with product name ordered by a customer having Customer_Id=2:*/

SELECT o.ord_id, o.ord_amt, o.ord_date, p.pro_name
FROM orders o
JOIN suppliers_pricing sp ON o.pricing_id = sp.pricing_id 
JOIN products p ON sp.pro_id = p.pro_id
WHERE o.cus_id = 2;

/*6) Display the Supplier details who can supply more than one product:*/

SELECT s.supp_id, s.supp_name, s.supp_city,s.supp_phone
FROM suppliers s
JOIN suppliers_pricing sp ON s.supp_id = sp.supp_id
GROUP BY s.supp_id, s.supp_name, s.supp_city, s.supp_phone
HAVING COUNT(DISTINCT sp.pro_id) > 1;

/*7) Find the least expensive product from each category and print the table with category id, name, product name, and price of the product:*/

SELECT c.cat_id, c.cat_name, p.pro_name, sp.supp_price
FROM category c
JOIN products p ON c.cat_id = p.cat_id
JOIN suppliers_pricing sp ON p.pro_id= sp.pro_id
WHERE sp.supp_price = (SELECT MIN(supp_price) FROM suppliers_pricing WHERE pro_id = p.pro_id)
ORDER BY c.cat_id;


/*8) Display the Id and Name of the Product ordered after “2021-10-05”:*/

SELECT p.pro_id, p.pro_name
FROM orders o
JOIN suppliers_pricing sp ON o.pricing_id= sp.pricing_id
JOIN products p ON sp.pro_id= p.pro_id
WHERE o.ord_date > '2021-10-05';

/*9) Display customer name and gender whose names start or end with character 'A':*/

SELECT cus_name, cus_gender
FROM customers
WHERE cus_name LIKE 'A%';

/*10) Create a stored procedure to display supplier id, name, Rating(Average rating of all the products sold by every customer) and
Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average
Service” else print “Poor Service”. Note that there should be one rating per supplier*/

 SELECT s.supp_id, s.supp_name, AVG(r.rat_ratstarts) AS AvgRating,
           CASE 
               WHEN AVG(r.rat_ratstarts) = 5 THEN 'Excellent Service'
               WHEN AVG(r.rat_ratstarts) > 4 THEN 'Good Service'
               WHEN AVG(r.rat_ratstarts) > 2 THEN 'Average Service'
               ELSE 'Poor Service'
           END AS Type_of_Service
    FROM suppliers s
    JOIN suppliers_pricing sp ON s.supp_id = sp.supp_id
    JOIN products p ON sp.pro_id= p.pro_id
    JOIN orders o ON sp.pricing_id = o.pricing_id
    LEFT JOIN ratings r ON o.ord_id = r.ord_id
    GROUP BY s.supp_id, s.supp_name;
    
    /*EXTRA QUERYS*/
    
    select count(*)
    from
    customers
    inner join
    orders
    using (cus_id)
    where cus_name ="AAKASH"
    or
    cus_name="AMAAN";
    
    select count(*)
    from
    customers
    inner join 
    orders
    on
    customers.cus_id=orders.cus_id
    where
    cus_name="AAKASH";
    
    select cus_city, count(*)
    from customers
    group by cus_city
    having count(*)>1;
    
    select *
    from customers
    order by cus_city,cus_name  desc;
    
    select*
    from customers left join
    orders
    on
    customers.cus_id=orders.cus_id;
    
    select supp_name,sum(supp_price)
    from suppliers inner join
    suppliers_pricing
    using (supp_id)
    group by supp_name;
    
    select cus_name
    from customers crossinner join
    orders o using (cus_id)
    group by cus_id
    having
    count(ord_id)>3;
    
    select pro_name, supp_price
    from suppliers s 
    inner join
    suppliers_pricing sp
    using(supp_id)
    inner join
    products using(pro_id)
    where supp_name ="Rajesh Retails";
    
    select supp_name, sum(supp_price)
    from suppliers 
    inner join
    suppliers_pricing
    using (supp_id)
    group by supp_name
    having sum(supp_price)>=3000;
    
    select ord_id,pro_name 
    from customers
    inner join orders
    using (cus_id)
    inner join suppliers_pricing
   using (pricing_id)
    inner join products
    using (pro_id)
    where cus_name ="AAKASH";
    
    
    