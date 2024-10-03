--Task 3. Aggregate functions, Having, Order By, GroupBy and Joins

--1. Write an SQL query to retrieve a list of all orders along with customer information (e.g.,
--customer name) for each order.
select 
orders.orderid,
orders.orderdate,
customers.firstname,
customers.lastname,
customers.email,
customers.phone
from orders
join customers on orders.customerid = customers.customerid


--2. Write an SQL query to find the total revenue generated by each electronic gadget product.
--Include the product name and the total revenue.

select 
products.productname,
sum(orderdetails.quantity * products.price) as totalrevenue
from orderdetails
join products on orderdetails.productid = products.productid
group by products.productname


--3. Write an SQL query to list all customers who have made at least one purchase. Include their
--names and contact information.

select distinct customers.firstname, customers.lastname, customers.email, customers.phone
from customers
join orders on customers.customerid = orders.customerid


--4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest
--total quantity ordered. Include the product name and the total quantity ordered.

select products.productname, sum(orderdetails.quantity) as totalquantityordered
from orderdetails
join products on orderdetails.productid = products.productid
group by products.productname
order by totalquantityordered desc


--5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding
--categories.

create table categories (
categoryid int primary key identity(1,1),
categoryname varchar(100)
)
insert into categories (categoryname)
values ('electronics'),
('wearables'),
('audio'),
('computers'),
('home appliances')
create table productcategories (
productcategoryid int primary key identity(1,1),
productid int foreign key references products(productid),
categoryid int foreign key references categories(categoryid)
)

insert into productcategories (productid, categoryid)
values (1, 1),
(2, 3), (3, 2), (4, 3), (5, 1), 
(6, 3), (7, 1), (8, 1), (9, 3), 
(10, 2), (11, 3) 

select 
products.productname,
categories.categoryname
from 
products
inner join 
productcategories on products.productid = productcategories.productid
inner join 
categories on productcategories.categoryid = categories.categoryid;


--6. Write an SQL query to calculate the average order value for each customer. Include the
--customer's name and their average order value.

select customers.firstname, customers.lastname, avg(orders.totalamount) as averageordervalue
from customers
join orders on customers.customerid = orders.customerid
group by customers.customerid, customers.firstname, customers.lastname


--7. Write an SQL query to find the order with the highest total revenue. Include the order ID,
--customer information, and the total revenue.

select top 1 orders.orderid, customers.firstname, customers.lastname, orders.totalamount
from orders
join customers on orders.customerid = customers.customerid
order by orders.totalamount desc


--8. Write an SQL query to list electronic gadgets and the number of times each product has been
--ordered.

select products.productname, sum(orderdetails.quantity) as timesordered
from orderdetails
join products on orderdetails.productid = products.productid
group by products.productname


--9. Write an SQL query to find customers who have purchased a specific electronic gadget product.
--Allow users to input the product name as a parameter.

declare @productname nvarchar(100) = 'laptop'
select distinct customers.firstname, customers.lastname, customers.email
from customers
join orders on customers.customerid = orders.customerid
join orderdetails on orders.orderid = orderdetails.orderid
join products on orderdetails.productid = products.productid
where products.productname = @productname


--10. Write an SQL query to calculate the total revenue generated by all orders placed within a
--specific time period. Allow users to input the start and end dates as parameters.

declare @startdate date = '2024-09-02'
declare @enddate date = '2024-09-06'
select sum(totalamount) as totalrevenue
from orders
where orderdate between @startdate and @enddate