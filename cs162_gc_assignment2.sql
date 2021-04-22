#HEADER
#Program Name: Assignment 2
#Author: Grayson Cordie
#Class: CS162 Spring 2021
#Date: 4/22/2021
#Description: MySQL script for assignment 2 database.

/*PSUEDOCODE(?)
	1. Create database. Always drops previous before creating.
    2. Use business database.
    3. Create tables. Always drop tables if exist beforehand, despite drop of whole database. 
    4. Insert data into tables.
    5. Select id, name, email, orderId, orderDate, decription, price, and quintity from tables customer; joined with order_, order_line, and product.
    6. Restraint given on line 69 should cause related order lines to be deleted with order.
*/


DROP DATABASE IF EXISTS business; #Resets entire database every run to bypass foreign key constraint
CREATE DATABASE IF NOT EXISTS business;
USE business;


DROP TABLE IF EXISTS customer;
CREATE TABLE IF NOT EXISTS customer (
	id int PRIMARY KEY AUTO_INCREMENT,
    email varchar(50) NOT NULL,
    phone varchar(15),
    name varchar(30) NOT NULL
);

DROP TABLE IF EXISTS address;
CREATE TABLE IF NOT EXISTS address (
	id INT PRIMARY KEY AUTO_INCREMENT,
	custId int NOT NULL,
	line_1 varchar(50) NOT NULL, 
	line_2 varchar(50) NULL, 
    city varchar(30) NOT NULL,
    state varchar(30) NOT NULL,
    zip int NOT NULL
);

DROP TABLE IF EXISTS order_;
CREATE TABLE IF NOT EXISTS order_ (
	id int PRIMARY KEY AUTO_INCREMENT,
    custId int NOT NULL,
    orderDate date NOT NULL
);

DROP TABLE IF EXISTS order_line;
CREATE TABLE IF NOT EXISTS order_line (
	orderId int NOT NULL,
    productId int NOT NULL,
    quantity int NOT NULL,
    PRIMARY KEY(orderId, productId)
);

DROP TABLE IF EXISTS product;
CREATE TABLE IF NOT EXISTS product (
	id int PRIMARY KEY AUTO_INCREMENT,
    description varchar(255),
    price int NOT NULL
);


ALTER TABLE address ADD CONSTRAINT FOREIGN KEY (custId) REFERENCES customer (id);

ALTER TABLE order_ ADD CONSTRAINT FOREIGN KEY (custId) REFERENCES customer (id);

ALTER TABLE order_line ADD CONSTRAINT FOREIGN KEY (orderId) REFERENCES order_ (id) ON DELETE CASCADE;
ALTER TABLE order_line ADD CONSTRAINT FOREIGN KEY (productId) REFERENCES product (id);


INSERT INTO customer (name, email)
VALUES 
	('Billy','Billy@Billy.com'),
	('Bobby','Bobby@Billy.com'),
	('Barbara','Barbara@Billy.com'),
    ('Bonny','Bonny@Billy.com'),
    ('Bartholomue','Bartholomue@Billy.com'),
    ('Ben','Ben@Billy.com');
    
INSERT INTO address (custId, line_1, line_2, city, state, zip)
VALUES
	('1', '456 HighTower Street', NULL, 'Hong Kong', 'China', '999077'),
	('2', '465 HighTower Road', NULL, 'Kong Hong', 'Australia', '99999'),
	('3', '654 LowTower Street', NULL, 'Kong', 'New Zealand', '770999'),
	('4', '564 Tower Street', NULL, 'Hong', 'Japan', '99907'),
	('5', '645 High Street', NULL, 'ong ong', 'Indonesia', '99077'),
	('6', '546 Tower Road', NULL, 'Hon Kon', 'India', '99977'),
	('1', '45 High Road', NULL, 'Hng Kng', 'United States', '99079'),
	('4', '56 Tower', NULL, 'Hog Kog', 'Oregon', '97097'),
	('3', '46 Street', NULL, 'og og', 'Ohio', '99007');
    
INSERT INTO order_ (custId, orderDate)
VALUES
	('1', '1999-11-04'),
    ('2', '2000-11-04'),
    ('3', '2001-11-04'),
    ('4', '2002-11-04'),
    ('5', '2003-11-04'),
    ('6', '2004-11-04'),
    ('5', '2005-11-04'),
    ('3', '2006-11-04'),
    ('2', '2007-11-04');
    
INSERT INTO product (description, price)
VALUES
	('Pencil','3.00'),
    ('Eraser','1.50'),
    ('Sharpener','8.00'),
    ('Pen','500.00'),
    ('Marker','0.50'),
    ('Crayon',' 50.00'),
    ('Turkey','0.99');
    
INSERT INTO order_line (orderId, productId, quantity)
VALUES
	('1','1','100'),
    ('1','2','200'),
    ('1','3','5'),
    ('2','4','23'),
    ('3','7','10000'),
    ('4','5','56'),
    ('5','4','12'),
    ('6','6','7'),
    ('5','3','65'),
    ('3','1','111'),
    ('2','3','444');
    
    
    
SELECT 
	customer.id, customer.name, customer.email,
    order_line.orderId,
    order_.orderDate,
    product.description, product.price,
	order_line.quantity
FROM customer
    JOIN order_ ON order_.custId = customer.id
    JOIN order_line ON order_.id = order_line.orderId
    JOIN product ON order_line.productId = product.id
	



/* FOOTER
id  name    email                    orderId orderDate   description $    quantity 
1	Billy	Billy@Billy.com             1	 1999-11-04	 Pencil	     3	  100
3	Barbara	Barbara@Billy.com           3	 2001-11-04	 Pencil	     3	  111
1	Billy	Billy@Billy.com	            1	 1999-11-04	 Eraser	     2	  200
1	Billy	Billy@Billy.com	            1	 1999-11-04	 Sharpener	 8	  5
2	Bobby	Bobby@Billy.com	            2	 2000-11-04	 Sharpener	 8	  444
5	Bartholomue	Bartholomue@Billy.com	5	 2003-11-04	 Sharpener	 8	  65
2	Bobby	Bobby@Billy.com	            2	 2000-11-04	 Pen	     500  23
5	Bartholomue	Bartholomue@Billy.com	5	 2003-11-04	 Pen	     500  12
4	Bonny	Bonny@Billy.com	            4	 2002-11-04	 Marker	     1	  56
6	Ben	Ben@Billy.com	                6	 2004-11-04	 Crayon	     50	  7
3	Barbara	Barbara@Billy.com	        3	 2001-11-04	 Turkey	     1	  10000
*/
	
    


