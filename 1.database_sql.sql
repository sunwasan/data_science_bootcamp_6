-- Restaurant Owners
--5 Tables
--1x Fact , 4x Dimension
-- search google , how to add foreign key
--write SQL 3 queries analyze data
--1x subquery / with


--dimension table
CREATE TABLE menu (
  menu_id INT PRIMARY KEY,
  menu_name TEXT,
  menu_price FLOAT
);

INSERT INTO menu VALUES
  (1,'Chinese Dragon Fried',249.00),
  (2,'Nessi Grilled with BBQ Sauce ',299.00),
  (3,'Pizza Godzilla Fried',449.00),
  (4,'Instant Noodle',1999.99),
  (5,'Tum Bak hung',2000.00);

CREATE TABLE location (
  location_id INT PRIMARY KEY,
  location TEXT
);
INSERT INTO location values
  (1,'Bangkok'),
  (2,'Chiang Mai'),
  (3,'Pattaya'),
  (4,'Phuket');

CREATE TABLE payment_options (
  po_id INT UNIQUE PRIMARY KEY,
  po TEXT
);
INSERT INTO payment_options VALUES
  (1,'Cash'),
  (2,'Mobile payments'),
  (3,'Debit cards'),
  (4,'Electronic bank transfers');

CREATE TABLE order_method (
  ordmthd_id INT PRIMARY KEY,
  ordmthd TEXT
);

INSERT INTO order_method  VALUES
  (1,'Website'),
  (2,'Phone'),
  (3,'At Restaurant'),
  (4,'Application');

-- facts
CREATE TABLE orders (
  ORDER_ID INT PRIMARY KEY NOT NULL,
  menu_id INT NOT NULL ,
  location_id INT NOT NULL,
  ordmthd_id INT NOT NULL,
  po_id INT NOT NULL,
  FOREIGN KEY (menu_id) REFERENCES menu(menu_id),
  FOREIGN KEY (location_id) REFERENCES location(loction_id),
  FOREIGN KEY (ordmthd_id) REFERENCES  order_method(ordmthd_id),
  FOREIGN KEY (po_id) REFERENCES payment_options(po_id)
  );
-- 2022-08-27 order
INSERT INTO orders  VALUES 
  (1,5,2,4,3),
  (2,3,4,3,2),
  (3,2,3,2,1),
  (4,3,4,3,1),
  (5,2,1,4,4),
  (6,1,3,1,3),
  (7,4,4,3,2),
  (8,1,1,4,4),
  (9,2,2,3,4),
  (10,5,4,2,3);

--sqlite command
.mode markdown
.header on 

WITH sub AS (
  SELECT 
     men.menu_name AS menu,
     men.menu_price AS price,
     loc.location AS location,
     met.ordmthd AS order_method,
     pay.po AS payment_option
  FROM orders AS ord
  JOIN menu AS men USING(menu_id)
  JOIN location AS loc USING(location_id)
  JOIN order_method AS met USING (ordmthd_id)
  JOIN payment_options AS pay USING(po_id)
)


-- where make the most profit to day
-- assume that make 10% profit from each menu
/*
SELECT 
  ROUND((SUM(price))*0.10,2) AS sales_THB,
  location
FROM sub
GROUP BY location
ORDER BY SUM(price)*0.10 DESC
LIMIT 1
*/


-- TOP3 popular buying method
/*
SELECT 
  count(*) AS n_time,
  order_method
FROM sub
GROUP BY order_method 
ORDER BY count(*) DESC 
LIMIT 3
*/

-- TOP 3 popular menu 
/*
SELECT
  COUNT(*) AS n_times,
  menu,
  SUM(price) AS total_sales_THB
FROM sub
GROUP BY menu
ORDER BY COUNT(*) DESC 
LIMIT 3
*/







