--Task 1 Database Design

--1. Create the database named "TechShop"

create database Techshop
use Techshop

--2. Define the schema for the Customers, Products, Orders, OrderDetails and Inventory tables based on the provided schema.
--4. Create appropriate Primary Key and Foreign Key constraints for referential integrity.

create table customers (
customerid int identity(1,1) primary key,
firstname varchar(50) not null,
lastname varchar(50) not null,
email varchar(100) not null unique,
phone varchar(15) not null,
address varchar(255)
)

create table products (
productid int primary key,
productname varchar(100) not null,
Description Text,
price decimal(10, 2) not null
)

create table orders (
orderid int primary key,
customerid int not null,
orderdate date not null,
totalamount decimal(10, 2) not null,
foreign key (customerid) references customers(customerid)
)

create table orderdetails (
orderdetailid int primary key,
orderid int not null,
productid int not null,
quantity int not null,
foreign key (orderid) references orders(orderid),
foreign key (productid) references products(productid)
)

create table inventory (
inventoryid int primary key,
productid int not null,
quantityinstock int not null,
laststockupdate date not null,
foreign key (productid) references products(productid)
)

--5. Insert at least 10 sample records into each of the following tables.

insert into customers (customerid, firstname, lastname, email, phone, address)
values 
(1,'amit', 'sharma', 'amit.sharma@example.com', '9876543210', '12, mg road, mumbai, maharashtra'),
(2,'sneha', 'patel', 'sneha.patel@example.com', '9123456789', '34, park street, ahmedabad, gujarat'),
(3,'rahul', 'mehta', 'rahul.mehta@example.com', '9988776655', '78, nehru nagar, delhi'),
(4,'priya', 'nair', 'priya.nair@example.com', '9876543211', '56, brigade road, bangalore, karnataka'),
(5,'arjun', 'reddy', 'arjun.reddy@example.com', '9234567890', '89, jubilee hills, hyderabad, telangana'),
(6,'neha', 'singh', 'neha.singh@example.com', '9112345678', '22, civil lines, jaipur, rajasthan'),
(7,'vikram', 'kumar', 'vikram.kumar@example.com', '9321654987', '11, mg road, pune, maharashtra'),
(8,'suman', 'das', 'suman.das@example.com', '9001234567', '90, salt lake, kolkata, west bengal'),
(9,'ravi', 'verma', 'ravi.verma@example.com', '9432123456', '45, rajendra nagar, patna, bihar'),
(10,'anjali', 'joshi', 'anjali.joshi@example.com', '9198765432', '67, connaught place, delhi')


insert into products (productid, productname, description, price)
values 
(1,'smartphone', 'latest model with 5g connectivity and 128gb storage', 25000.00),
(2,'laptop', '14-inch display, 8gb ram, 256gb ssd', 55000.00),
(3,'smartwatch', 'water-resistant with heart rate monitor', 10000.00),
(4,'headphones', 'noise-cancelling over-ear headphones', 5000.00),
(5,'tablet', '10-inch display, 64gb storage, 4g connectivity', 20000.00),
(6,'bluetooth speaker', 'portable with 12-hour battery life', 3000.00),
(7,'gaming console', 'next-gen console with 1tb storage', 45000.00),
(8,'external hard drive', '1tb storage, usb 3.0', 4000.00),
(9,'wireless mouse', 'ergonomic design, rechargeable battery', 1500.00),
(10,'fitness band', 'activity tracker with heart rate monitor', 2500.00)


insert into orders (orderid, customerid, orderdate, totalamount)
values 
(1, 1, '2024-09-01', 45000.00),
(2, 2, '2024-09-02', 25000.00),
(3, 3, '2024-09-03', 3000.00),
(4, 4, '2024-09-04', 10000.00),
(5, 5, '2024-09-05', 55000.00),
(6, 6, '2024-09-06', 4000.00),
(7, 7, '2024-09-07', 5000.00),
(8, 8, '2024-09-08', 2500.00),
(9, 9, '2024-09-09', 1500.00),
(10, 10, '2024-09-10', 20000.00)

insert into orderdetails (orderdetailid, orderid, productid, quantity)
values 
(1, 1, 7, 1),
(2, 3, 1, 1),
(3, 2, 6, 1),
(4, 4, 3, 1),
(5, 5, 2, 1),
(6, 7, 8, 1),
(7, 6, 4, 1),
(8, 8, 10, 1),
(9, 10, 9, 1),
(10, 9, 5, 1)


insert into inventory (inventoryid, productid, quantityinstock, laststockupdate)
values 
(1, 1, 100, '2024-08-01'),
(2, 2, 50, '2024-08-02'),
(3, 3, 75, '2024-08-03'),
(4, 4, 200, '2024-08-04'),
(5, 5, 30, '2024-08-05'),
(6, 6, 150, '2024-08-06'),
(7, 7, 20, '2024-08-07'),
(8, 8, 80, '2024-08-08'),
(9, 9, 120, '2024-08-09'),
(10, 10, 60, '2024-08-10')
