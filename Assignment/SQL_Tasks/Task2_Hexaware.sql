--Tasks 2: Select, Where, Between, AND, LIKE:

use Techshop

--1. Write an SQL query to retrieve the names and emails of all customers. 

select firstname, lastname, email from customers

--2. Write an SQL query to list all orders with their order dates 
--and corresponding customer names.

select orders.orderid, orders.orderdate, customers.firstname
from orders inner join customers on orders.customerid = customers.customerid

--3. Write an SQL query to insert a new customer record into the "Customers" table. 
--Include customer information such as name, email, and address.

insert into customers (customerid, firstname, lastname, email, phone, address)
values (11, 'ravi', 'kumar', 'ravi.kumar@example.com', '9998887776', '123, mg road, bangalore, karnataka')

--4. Write an SQL query to update the prices of all electronic gadgets in the
--"Products" table by increasing them by 10%.

update products
set price = price * 1.10

--5. Write an SQL query to delete a specific order and its associated order details from the
--"Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.

declare @orderid int
set @orderid = 7
delete from orderdetails
where orderid = @orderid
delete from orders
where orderid = @orderid

--6. Write an SQL query to insert a new order into the "Orders" table. Include the customer ID,
--order date, and any other necessary information

insert into orders (orderid, customerid, orderdate, totalamount)
values (11, 1, '2024-09-11', 7500.00)  

--7. Write an SQL query to update the contact information (e.g., email and address) of a specific
--customer in the "Customers" table. Allow users to input the customer ID and new contact information.

declare @customerid int = 6  
declare @newemail varchar(100) = 'new.email@example.com'
declare @newaddress varchar(255) = '456, new avenue, pune, maharashtra'
update customers
set email = @newemail, address = @newaddress
where customerid = @customerid

--8. Write an SQL query to recalculate and update the total cost of each order in the "Orders"
--table based on the prices and quantities in the "OrderDetails" table.

update orders
set totalamount = (select sum(orderdetails.quantity * products.price)
from orderdetails
inner join products on orderdetails.productid = products.productid
where orderdetails.orderid = orders.orderid);

--9. Write an SQL query to delete all orders and their associated order details for a specific
--customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID
--as a parameter.

declare @customeridtodelete int = 1 
delete from orderdetails
where orderid in (select orderid from orders where customerid = @customeridtodelete)
delete from orders
where customerid = @customeridtodelete

--10. Write an SQL query to insert a new electronic gadget product into the "Products" table,
--including product name, category, price, and any other relevant details.

insert into products (productid, productname, description, price)
values (11, 'smart speaker', 'voice-controlled smart speaker with bluetooth and wi-fi connectivity', 15000.00)

--11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from
--"Pending" to "Shipped"). Allow users to input the order ID and the new status.

declare @orderidtoupdate int = 5  
declare @neworderdate date = '2024-09-30'
update orders
set orderdate = @neworderdate
where orderid = @orderidtoupdate

--12. Write an SQL query to calculate and update the number of orders placed by each customer
--in the "Customers" table based on the data in the "Orders" table.

alter table customers
add numorders int;
update customers
set numorders = (select count(*) from orders where orders.customerid = customers.customerid);

select * from customers
