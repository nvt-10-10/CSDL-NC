/*create database btvn_01*/
create table productlines(
   productLine int identity(1,1) not null,
   textDescription nvarchar(255),
   htmlDescription nvarchar(255),
   image nvarchar(255),
   primary key(productLine)
)

create table products
(
   productCode int identity(1,1) not null,
   productLine int ,
   productName nvarchar(255),
   productScale nvarchar(255),
   productVendor nvarchar(255),
   productDescription nvarchar(255),
   quantityInStock int,
   buyPrice float,
   MSRP nvarchar(255),
   primary key(productCode),
   foreign key (productLine) 
   references productlines(productLine)
)

create table offices(
	officeCode int identity(1,1) not null,
	city nvarchar(45),
	phone varchar(15),
	addressLine1 nvarchar(255),
	addressLine2 nvarchar(255),
	state nvarchar(45),
	country nvarchar(45),
	postalCode nvarchar(45),
	territory nvarchar(45),
	primary key(officeCode)
)

create table employees(
	employeeNumber int not null identity(1,1),
	lastName nvarchar(45),
	firstName nvarchar(45),
	extension nvarchar(255),
	officeCode int ,
	reportsTo int ,
	jobTitle nvarchar(255),
	primary key (employeeNumber),
	foreign key (reportsTo) references employees(employeeNumber),
	foreign key (officeCode) references offices(officeCode)
)

create table customers(
	customerNumber int identity(1,1) not null,
	customerName nvarchar(45),
	contactLastName nvarchar(45),
	contactFirstName nvarchar(45),
	phone varchar(15),
	addressLine1 nvarchar(255),
	addressLine2 nvarchar(255),
	city nvarchar(45),
	state  nvarchar(45),
	postalCode nvarchar(45),
	country nvarchar(45),
	salesRepEmployeeNumber int ,
	crediLimit float ,
	primary key(customerNumber),
	foreign key (salesRepEmployeeNumber) references employees(employeeNumber),
)

create table payments(
    customerNumber int not null,
	checkNumber int not null,
	paymentDate date,
	amount int,
	primary key(customerNumber,checkNumber),
	foreign key(customerNumber) references customers(customerNumber)
)

create table orders(
   orderNumber int identity (1,1) not null,
   orderDate date,
   requiedDate date,
   shippedDate date,
   status nvarchar(45),
   comments nvarchar(255),
   customerNumber int,
   primary key(orderNumber),
   foreign key(customerNumber) references customers(customerNumber)
)
create table orderdetails(
   orderNumber int not null,
   productCode int not null,
   quantityOrdered float,
   prceEach int,
   orderLineNumber int,
   primary key(orderNumber,productCode),
   foreign key(orderNumber) references orders(orderNumber),
   foreign key(productCode) references products(productCode)
)
--  MySQL INSERT – simple INSERT example
INSERT into offices(city,phone)  values(N'city A','123')
select * from offices


--	INSERT – Inserting dates into the table example
INSERT into offices(city,phone)  values(N'city A',DEFAULT)
select * from offices
--	Inserting dates into the table example
insert into orders(orderDate) values('2023-2-14')
select * from orders

--	Inserting multiple rows exampleinsert into orders(orderDate) values('2023-2-14'),('2023-2-12'),('2023-2-13')select * from orders
-- Using MySQL UPDATE to update rows returned by a SELECT statement example
select * from orders
update orders set orderDate='2023-2-14' where 
orderNumber in (select top 3 orderNumber from orders   )
select * from orders
--	MySQL DELETE and LIMIT clause
select * from orders
delete orders where orderNumber =1
select * from orders 
delete orders where orderNumber in (
	select  orderNumber from orders 
	order by orderNumber  asc
	offset  1 rows
	fetch  first 1 rows only
)
select * from orders