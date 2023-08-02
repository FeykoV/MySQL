CREATE DATABASE IF NOT EXISTS home_work;

USE home_work;



-- 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными

DROP TABLE IF EXISTS sales;

CREATE TABLE IF NOT EXISTS sales (
  id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  order_date DATE,
  count_product INT UNSIGNED
);

DESC sales;

INSERT sales 
(order_date, count_product)
  VALUES
  ('2022-01-01', 156),
  ('2022-01-02', 180),
  ('2022-01-03', 21),
  ('2022-01-04', 124),
  ('2022-01-05', 341);
  
SELECT * FROM sales;



-- 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.


SELECT id, 
CASE
	WHEN count_product < 100 THEN "Маленький заказ"
    WHEN count_product BETWEEN 100 AND 300 THEN "Средний заказ"
    ELSE "Большой заказ"
END AS "Тип заказа"
FROM sales;


-- 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE


CREATE TABLE IF NOT EXISTS orders (
  id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  employee_id VARCHAR(45) NOT NULL,
  amount DECIMAL(7, 2) NOT NULL,
  order_status ENUM ('OPEN', 'CLOSED', 'CANCELLED') NOT NULL
);


DESC orders;

INSERT orders 
(employee_id, amount, order_status )
  VALUES
  ('e03', 15.00, 'OPEN'),
  ('e01', 25.50, 'OPEN'),
  ('e05', 100.70, 'CLOSED'),
  ('e02', 22.18, 'OPEN'),
  ('e04', 9.50, 'CANCELLED');
  
SELECT * FROM orders;
  
  
SELECT id, employee_id, amount, order_status,
CASE
	WHEN order_status = 'OPEN' THEN "Order is in open state"
    WHEN order_status = 'CLOSED'THEN "Order is closed"
    ELSE "Order is cancelled"
END AS "full_order_status"
FROM orders;


-- Чем NULL отличается от 0?

/* NULL - это отсутствие значения у ячейки, а '0' это число.