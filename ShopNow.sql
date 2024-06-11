-- DROP DATABASE IF EXISTS shopnow;
CREATE DATABASE shopnow;

USE shopnow;
-- drop database shopnow;
CREATE TABLE customer (
    id VARCHAR(10) PRIMARY KEY NOT NULL,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(15) NOT NULL,
    street_number VARCHAR(20) NOT NULL,
    pincode VARCHAR(6) NOT NULL CHECK (pincode REGEXP '^[0-9]{6}$'),
    state VARCHAR(15) NOT NULL CHECK (state REGEXP '^[a-zA-Z ]+$'),
    email_id VARCHAR(50) NOT NULL CHECK (email_id LIKE '%_@_%._%'),
    phone_no VARCHAR(10) NOT NULL CHECK (phone_no REGEXP '^[0-9]{10}$'),
    dob DATE NOT NULL CHECK (dob >= '1900-01-01'
        AND dob <= '2024-01-01'),
    age INT NOT NULL CHECK (age > 0 AND age < 125)
);
-- drop table customer;

CREATE TABLE seller (
    id VARCHAR(10) PRIMARY KEY NOT NULL,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(15) NOT NULL,
    street_number VARCHAR(20) NOT NULL,
    pincode VARCHAR(6) NOT NULL CHECK (pincode REGEXP '^[0-9]{6}$'), -- 6 digits only
    state VARCHAR(15) NOT NULL CHECK (state REGEXP '^[a-zA-Z ]+$'), -- Alphabets and spaces only
    email_id VARCHAR(50) NOT NULL CHECK (email_id LIKE '%_@_%._%'), -- Email format validation
    phone_no VARCHAR(10) NOT NULL CHECK (phone_no REGEXP '^[0-9]{10}$'), -- 10 digits only
    dob DATE NOT NULL CHECK (dob >= '1900-01-01' AND dob <= '2024-01-01'), -- DOB range: 1900-01-01 to today
    age INT NOT NULL CHECK (age > 0 AND age < 125) -- Age range between 1 and 124
); 

CREATE TABLE admin (
    id VARCHAR(10) PRIMARY KEY NOT NULL,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(15) NOT NULL,
    street_number VARCHAR(20) NOT NULL,
    pincode VARCHAR(6) NOT NULL CHECK (pincode REGEXP '^[0-9]{6}$'), -- 6 digits only
    state VARCHAR(15) NOT NULL CHECK (state REGEXP '^[a-zA-Z ]+$'), -- Alphabets and spaces only
    email_id VARCHAR(50) NOT NULL CHECK (email_id LIKE '%_@_%._%'), -- Email format validation
    phone_no VARCHAR(10) NOT NULL CHECK (phone_no REGEXP '^[0-9]{10}$'), -- 10 digits only
    dob DATE NOT NULL CHECK (dob >= '1900-01-01' AND dob <= '2024-01-01'), -- DOB range: 1900-01-01 to today
    age INT NOT NULL CHECK (age > 0 AND age < 125) -- Age range between 1 and 124
); 

CREATE TABLE orders (
	id VARCHAR(10) PRIMARY KEY NOT NULL,
    order_date DATE NOT NULL, -- Store date in proper format
    order_time TIME NOT NULL,
	cust_id VARCHAR(10) NOT NULL,
    seller_id VARCHAR(10) NOT NULL,
	FOREIGN KEY(cust_id) REFERENCES customer(id) ON DELETE CASCADE,
    FOREIGN KEY(seller_id) REFERENCES seller(id) ON DELETE CASCADE
);

CREATE TABLE payment (
    id VARCHAR(10) PRIMARY KEY NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0), -- Ensure positive amount
    pay_date DATE NOT NULL, -- Store date in proper format
    pay_time TIME NOT NULL,
	cust_id VARCHAR(10) NOT NULL,
    order_id VARCHAR(10) NOT NULL,
    
    FOREIGN KEY(cust_id) REFERENCES customer(id) ON DELETE CASCADE,
    FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE
);

CREATE TABLE category (
    id VARCHAR(10) PRIMARY KEY NOT NULL,
    category_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE product (
    id VARCHAR(10) PRIMARY KEY NOT NULL,
    name VARCHAR(20) NOT NULL,
    category_id VARCHAR(10) NOT NULL,
    quan_avail INT NOT NULL CHECK (quan_avail >= 0), -- Ensure non-negative quantity
    price DECIMAL(10,2) NOT NULL CHECK (price > 0), -- Ensure positive price
    discount DECIMAL(5,2) CHECK (discount >= 0 AND discount <= 1), -- Discount between 0 and 1
    FOREIGN KEY(category_id) REFERENCES category(id) ON DELETE CASCADE
);

CREATE TABLE cart (
    cust_id VARCHAR(10) NOT NULL,
    prod_id VARCHAR(10) NOT NULL,
    quan INT NOT NULL CHECK (quan > 0), -- Ensure positive quantity
    cost DECIMAL(10,2) NOT NULL, -- Store cost with two decimal places
	PRIMARY KEY (cust_id, prod_id), -- Composite primary key
	FOREIGN KEY (cust_id) REFERENCES customer(id) ON DELETE CASCADE, -- Foreign key to customer
	FOREIGN KEY (prod_id) REFERENCES product(id) ON DELETE CASCADE
);

CREATE TABLE wishlist (
  product_id VARCHAR(10) NOT NULL,
  customer_id VARCHAR(10) NOT NULL,
  PRIMARY KEY (product_id, customer_id),
  FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE,
  FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE
);

INSERT INTO customer (id, first_name, last_name, street_number, pincode, state, email_id, phone_no, dob, age)
VALUES
    ('C0001', 'Rahul', 'Gupta', '123', '110001', 'Delhi', 'rahul.gupta@example.com', '9876543210', '1990-05-15', 31),
    ('C0002', 'Priya', 'Sharma', '456', '400001', 'Maharashtra', 'priya.sharma@example.com', '9876543211', '1985-08-20', 36),
    ('C0003', 'Amit', 'Patel', '789', '380001', 'Gujarat', 'amit.patel@example.com', '9876543212', '1980-12-10', 41),
    ('C0004', 'Neha', 'Singh', '1011', '700001', 'West Bengal', 'neha.singh@example.com', '9876543213', '1975-03-25', 47),
    ('C0005', 'Sandeep', 'Kumar', '1213', '600001', 'Tamil Nadu', 'sandeep.kumar@example.com', '9876543214', '1995-09-05', 26),
    ('C0006', 'Pooja', 'Verma', '1415', '500001', 'Telangana', 'pooja.verma@example.com', '9876543215', '1988-11-30', 33),
    ('C0007', 'Vivek', 'Yadav', '1617', '560001', 'Karnataka', 'vivek.yadav@example.com', '9876543216', '1992-07-18', 29),
    ('C0008', 'Anita', 'Rajput', '1819', '110002', 'Delhi', 'anita.rajput@example.com', '9876543217', '1983-04-12', 38),
    ('C0009', 'Rajesh', 'Mishra', '2021', '400002', 'Maharashtra', 'rajesh.mishra@example.com', '9876543218', '1987-06-08', 34),
    ('C0010', 'Sunita', 'Das', '2223', '700002', 'West Bengal', 'sunita.das@example.com', '9876543219', '1998-02-28', 23);
    


INSERT INTO seller (id, first_name, last_name, street_number, pincode, state, email_id, phone_no, dob, age)
VALUES
    ('S0001', 'Amit', 'Kumar', '123', '110001', 'Delhi', 'amit.kumar@example.com', '9876543210', '1990-05-15', 31),
    ('S0002', 'Priya', 'Sharma', '456', '400001', 'Maharashtra', 'priya.sharma@example.com', '9876543211', '1985-08-20', 36),
    ('S0003', 'Raj', 'Patel', '789', '380001', 'Gujarat', 'raj.patel@example.com', '9876543212', '1980-12-10', 41),
    ('S0004', 'Neha', 'Singh', '1011', '700001', 'West Bengal', 'neha.singh@example.com', '9876543213', '1975-03-25', 47),
    ('S0005', 'Sandeep', 'Kumar', '1213', '600001', 'Tamil Nadu', 'sandeep.kumar@example.com', '9876543214', '1995-09-05', 26),
    ('S0006', 'Pooja', 'Verma', '1415', '500001', 'Telangana', 'pooja.verma@example.com', '9876543215', '1988-11-30', 33),
    ('S0007', 'Vivek', 'Yadav', '1617', '560001', 'Karnataka', 'vivek.yadav@example.com', '9876543216', '1992-07-18', 29),
    ('S0008', 'Anita', 'Rajput', '1819', '110002', 'Delhi', 'anita.rajput@example.com', '9876543217', '1983-04-12', 38),
    ('S0009', 'Rajesh', 'Mishra', '2021', '400002', 'Maharashtra', 'rajesh.mishra@example.com', '9876543218', '1987-06-08', 34),
    ('S0010', 'Sunita', 'Das', '2223', '700002', 'West Bengal', 'sunita.das@example.com', '9876543219', '1998-02-28', 23);

select * from seller;

INSERT INTO admin (id, first_name, last_name, street_number, pincode, state, email_id, phone_no, dob, age)
VALUES
    ('A0001', 'Suresh', 'Kumar', '123', '110001', 'Delhi', 'suresh.kumar@example.com', '9876543210', '1990-05-15', 31),
    ('A0002', 'Anjali', 'Sharma', '456', '400001', 'Maharashtra', 'anjali.sharma@example.com', '9876543211', '1985-08-20', 36),
    ('A0003', 'Ravi', 'Patel', '789', '380001', 'Gujarat', 'ravi.patel@example.com', '9876543212', '1980-12-10', 41),
    ('A0004', 'Neha', 'Singh', '1011', '700001', 'West Bengal', 'neha.singh@example.com', '9876543213', '1975-03-25', 47),
    ('A0005', 'Sandeep', 'Kumar', '1213', '600001', 'Tamil Nadu', 'sandeep.kumar@example.com', '9876543214', '1995-09-05', 26),
    ('A0006', 'Pooja', 'Verma', '1415', '500001', 'Telangana', 'pooja.verma@example.com', '9876543215', '1988-11-30', 33),
    ('A0007', 'Vivek', 'Yadav', '1617', '560001', 'Karnataka', 'vivek.yadav@example.com', '9876543216', '1992-07-18', 29),
    ('A0008', 'Anita', 'Rajput', '1819', '110002', 'Delhi', 'anita.rajput@example.com', '9876543217', '1983-04-12', 38),
    ('A0009', 'Rajesh', 'Mishra', '2021', '400002', 'Maharashtra', 'rajesh.mishra@example.com', '9876543218', '1987-06-08', 34),
    ('A0010', 'Sunita', 'Das', '2223', '700002', 'West Bengal', 'sunita.das@example.com', '9876543219', '1998-02-28', 23);


INSERT INTO orders (id, order_date, order_time,cust_id,seller_id)
VALUES
    ('O000000001', '2024-02-09', '09:00:00','C0001','S0001'),
    ('O000000002', '2024-02-09', '09:30:00','C0001','S0001'),
    ('O000000003', '2024-02-09', '10:00:00','C0002','S0001'),
    ('O000000004', '2024-02-09', '10:30:00','C0002','S0001'),
    ('O000000005', '2024-02-09', '11:00:00','C0003','S0001'),
    ('O000000006', '2024-02-09', '11:30:00','C0003','S0001'),
    ('O000000007', '2024-02-09', '12:00:00','C0004','S0001'),
    ('O000000008', '2024-02-09', '12:30:00','C0004','S0001'),
    ('O000000009', '2024-02-09', '13:00:00','C0007','S0001'),
    ('O000000010', '2024-02-09', '13:30:00','C0007','S0001');

INSERT INTO payment (id, amount, pay_date, pay_time, cust_id, order_id)
VALUES
	('P0001', 50.00, '2024-02-09', '09:00:00', 'C0001', 'O000000001'),
    ('P0002', 150.50, '2024-02-09', '09:30:00', 'C0002', 'O000000002'),
    ('P0003', 200.75, '2024-02-09', '10:00:00', 'C0003', 'O000000003'),
    ('P0004', 75.25, '2024-02-09', '10:30:00', 'C0004', 'O000000004'),
    ('P0005', 300.00, '2024-02-09', '11:00:00', 'C0005', 'O000000005'),
    ('P0006', 50.00, '2024-02-09', '11:30:00', 'C0006', 'O000000006'),
    ('P0007', 225.25, '2024-02-09', '12:00:00', 'C0006', 'O000000007'),
    ('P0008', 175.75, '2024-02-09', '12:30:00', 'C0007', 'O000000008'),
    ('P0009', 400.50, '2024-02-09', '13:00:00', 'C0008', 'O000000009'),
    ('P0010', 125.00, '2024-02-09', '13:30:00', 'C0009', 'O000000010');


INSERT INTO category (id, category_name)
VALUES
    ('C000000001', 'Category 1'),
    ('C000000002', 'Category 2'),
    ('C000000003', 'Category 3'),
    ('C000000004', 'Category 4'),
    ('C000000005', 'Category 5'),
    ('C000000006', 'Category 6'),
    ('C000000007', 'Category 7'),
    ('C000000008', 'Category 8'),
    ('C000000009', 'Category 9'),
    ('C000000010', 'Category 10');

INSERT INTO product (id, name,category_id, quan_avail, price, discount)
VALUES
    ('P000000001', 'Product 1','C000000001', 100, 50.00, 0.10),
    ('P000000002', 'Product 2','C000000001', 150, 75.00, 0.15),
    ('P000000003', 'Product 3','C000000002', 200, 100.00, 0.20),
    ('P000000004', 'Product 4','C000000002', 75, 45.00, 0.05),
    ('P000000005', 'Product 5','C000000002', 300, 120.00, 0.25),
    ('P000000006', 'Product 6','C000000003', 50, 30.00, 0.10),
    ('P000000007', 'Product 7','C000000003', 225, 90.00, 0.15),
    ('P000000008', 'Product 8','C000000003', 175, 80.00, 0.20),
    ('P000000009', 'Product 9','C000000004', 400, 150.00, 0.30),
    ('P000000010', 'Product 10','C000000005', 125, 60.00, 0.10);


INSERT INTO cart (cust_id, prod_id, quan, cost)
VALUES
    ('C0001', 'P000000001', 2, 100.00),
    ('C0002', 'P000000002', 1, 75.00),
    ('C0002', 'P000000003', 3, 300.00),
    ('C0002', 'P000000004', 2, 90.00),
    ('C0003', 'P000000005', 1, 120.00),
    ('C0003', 'P000000006', 4, 120.00),
    ('C0004', 'P000000007', 2, 180.00),
    ('C0004', 'P000000008', 1, 80.00),
    ('C0005', 'P000000009', 3, 450.00),
    ('C0005', 'P000000010', 2, 120.00);

INSERT INTO wishlist (product_id, customer_id)
VALUES
    ('P000000001', 'C0001'),
    ('P000000002', 'C0001'),
    ('P000000003', 'C0002'),
    ('P000000004', 'C0002'),
    ('P000000005', 'C0003'),
    ('P000000006', 'C0003'),
    ('P000000007', 'C0004'),
    ('P000000008', 'C0004'),
    ('P000000009', 'C0005'),
    ('P000000010', 'C0005');
    
    
-- SELECT * FROM customer;
-- SELECT * FROM admin;
-- SELECT * FROM seller;
-- SELECT * FROM cart;
-- SELECT * FROM wishlist;
-- SELECT * FROM product;
-- SELECT * FROM payment;
-- SELECT * FROM orders;


-- selection
SELECT * FROM customer WHERE state = 'Delhi';

-- union
SELECT cust_id FROM orders UNION SELECT cust_id FROM payment;

-- projection
SELECT id, email_id FROM customer;

-- intersection
SELECT cust_id FROM orders INTERSECT SELECT cust_id FROM payment;

-- cartesian product

SELECT c.id AS customer_id, s.id AS seller_id FROM customer c, seller s;


-- joins (customers who made orders and payments with their total payment amount)

SELECT c.id, c.first_name, c.last_name, SUM(p.amount) AS total_amount_paid FROM customer c
INNER JOIN payment p ON c.id = p.cust_id
INNER JOIN orders o ON c.id = o.cust_id
GROUP BY c.id, c.first_name, c.last_name;

-- aggregate (total number of products ordered by each customer)

SELECT cust_id, COUNT(*) AS total_products_ordered FROM orders GROUP BY cust_id;


-- nested (all the customer with order higher than average)

SELECT name, price FROM product WHERE price > (SELECT AVG(price) FROM product);

-- all the items not present in the wish list

SELECT name,price FROM product WHERE id NOT IN(SELECT product_id FROM wishlist);

-- top 5 customer on the basis of amount spent

SELECT c.id, c.first_name, c.last_name, SUM(p.amount) AS total_amount_spent
FROM customer c
INNER JOIN payment p ON c.id = p.cust_id
GROUP BY c.id, c.first_name, c.last_name
ORDER BY total_amount_spent DESC
LIMIT 5;

-- updating the quantity available for the id = P000000001

UPDATE product
SET quan_avail = quan_avail - 3
WHERE id = 'P000000001';

-- total revenue generated

SELECT SUM(p.amount) AS total_revenue
FROM payment p
INNER JOIN orders o ON p.order_id = o.id;




SELECT p.id, p.name, p.category_id, p.quan_avail, p.price, p.discount 
FROM wishlist w JOIN product p ON w.product_id = p.id 
WHERE w.customer_id = 'C0003';

select * from wishlist inner join product;

DELIMITER //

CREATE TRIGGER calcPrice_Product_in_Cart
BEFORE INSERT
ON cart
FOR EACH ROW
BEGIN
    DECLARE product_price DECIMAL(10,2);
    DECLARE product_discount DECIMAL(5,2);
    
    -- Get the price and discount of the product being added to the cart
    SELECT price, discount INTO product_price, product_discount
    FROM product
    WHERE id = NEW.prod_id;
    
    -- Calculate the new price in the cart based on the discount
    SET NEW.cost = product_price * NEW.quan * (1 - product_discount);
END;
//
DELIMITER ;

-- drop trigger calcPrice_Product_in_Cart;


-- Trigger for updating products in a specific category
-- DELIMITER //

-- CREATE TRIGGER update_category_product_price
-- AFTER UPDATE ON category
-- FOR EACH ROW
-- BEGIN
--     DECLARE category_id INT;
--     DECLARE factor FLOAT;

--     -- Get the category ID and the increment factor
--     SET category_id = NEW.id;
--     SET factor = NEW.price_increment_factor;

--     -- Update the price of products in the category
--     UPDATE product
--     SET price = price * factor
--     WHERE category_id = category_id;
-- END;
-- //
-- DELIMITER ;






DELIMITER //

CREATE TRIGGER update_product_quantity
AFTER INSERT ON cart
FOR EACH ROW
BEGIN
    DECLARE new_quan_avail INT;
    
    -- Get the new quantity available for the product after adding to the cart
    SELECT quan_avail - NEW.quan INTO new_quan_avail
    FROM product
    WHERE id = NEW.prod_id;
    
    -- If the new quantity available is less than 0, raise an error
    IF new_quan_avail < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough quantity available for the product in stock.';
    ELSE
        -- Update the quantity available for the product in the product table
        UPDATE product
        SET quan_avail = new_quan_avail
        WHERE id = NEW.prod_id;
    END IF;
END;
//
DELIMITER ;



-- drop trigger update_product_quantity;



DELIMITER //

CREATE TRIGGER prevent_duplicate_email_customer
BEFORE INSERT ON customer
FOR EACH ROW
BEGIN
    DECLARE email_count INT;
    
    -- Check if the email already exists in the customer table
    SELECT COUNT(*) INTO email_count
    FROM customer
    WHERE email_id = NEW.email_id;
    
    -- If email already exists, raise an error
    IF email_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email already exists in the customer table. Cannot add customer.';
    END IF;
END;
//
DELIMITER ;

-- Transaction 1: Customer A attempts to purchase Product X
-- Assume Product X has a quantity of 5 available initially

-- Begin Transaction 1
START TRANSACTION;

-- Attempt to update the product quantity in the cart and decrease the available quantity by 2 for Customer A
UPDATE product
SET quan_avail = quan_avail - 2
WHERE id = 'P000000001'; -- Assuming 'P000000001' represents Product X

-- Assuming 'C0001' represents Customer A, and 'P000000001' represents Product X in the cart
INSERT INTO cart (cust_id, prod_id, quan, cost)
VALUES ('C0001', 'P000000001', 2, 100.00);

-- Commit Transaction 1
COMMIT;

-- Transaction 2: Customer B also tries to purchase Product X at the same time
-- Begin Transaction 2
START TRANSACTION;

-- Attempt to update the product quantity in the cart and decrease the available quantity by 3 for Customer B
UPDATE product
SET quan_avail = quan_avail - 3
WHERE id = 'P000000001'; -- Assuming 'P000000001' represents Product X

-- Assuming 'C0002' represents Customer B, and 'P000000001' represents Product X in the cart
INSERT INTO cart (cust_id, prod_id, quan, cost)
VALUES ('C0002', 'P000000001', 3, 150.00);

-- Commit Transaction 2
COMMIT;


-- drop trigger prevent_duplicate_phone_customer;


-- Contributions: 
-- Apaar(2022089) -> selection from the Tables
-- Piyush Narula(2022354) -> unions , joins cartesian product
-- Nabh Rajput (2021170) -> rest of commands
