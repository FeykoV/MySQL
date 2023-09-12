DROP DATABASE IF EXISTS lesson_4;
CREATE DATABASE lesson_4;
USE lesson_4;

-- пользователи
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

INSERT INTO users (id, firstname, lastname, email) VALUES 
(1, 'Reuben', 'Nienow', 'arlo50@example.org'),
(2, 'Frederik', 'Upton', 'terrence.cartwright@example.org'),
(3, 'Unique', 'Windler', 'rupert55@example.org'),
(4, 'Norene', 'West', 'rebekah29@example.net'),
(5, 'Frederick', 'Effertz', 'von.bridget@example.net'),
(6, 'Victoria', 'Medhurst', 'sstehr@example.net'),
(7, 'Austyn', 'Braun', 'itzel.beahan@example.com'),
(8, 'Jaida', 'Kilback', 'johnathan.wisozk@example.com'),
(9, 'Mireya', 'Orn', 'missouri87@example.org'),
(10, 'Jordyn', 'Jerde', 'edach@example.com');


/* Создайте таблицу users_old, аналогичную таблице users.
 Создайте процедуру, с помощью которой можно переместить любого (одного)
 пользователя из таблицы users в таблицу users_old. (использование транзакции
 с выбором commit или rollback – обязательно). */
 
 
 DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

DROP PROCEDURE IF EXISTS user_transfer;
DELIMITER //
CREATE PROCEDURE user_transfer(u_id int,
OUT  tran_result varchar(100))

BEGIN
	
	DECLARE `_rollback` BIT DEFAULT 0;
	DECLARE code varchar(100);
	DECLARE error_string varchar(100); 

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
 		SET `_rollback` = 1;
 		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
	END;

	START TRANSACTION;
	
    INSERT INTO users_old (id, firstname, lastname, email)
	SELECT id, firstname, lastname, email FROM users WHERE id = u_id;

	DELETE FROM users
	WHERE id=u_id;
     
	IF `_rollback` THEN
		SET tran_result = concat('Ой! Ошибка: ', code, ' Текст ошибки: ', error_string);
		ROLLBACK;
	ELSE
		SET tran_result = 'OK';
		COMMIT;
	END IF;
END//
DELIMITER ;

CALL user_transfer(1, @tran_result);
SELECT  @tran_result;
SELECT id, firstname, lastname, email FROM users_old;


/* Создайте хранимую функцию hello(), которая будет возвращать приветствие,
 в зависимости от текущего времени суток.
 С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
 с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
 с 18:00 до 00:00 — "Добрый вечер", 
 с 00:00 до 6:00 — "Доброй ночи". */
 


DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()

RETURNS TEXT NO SQL
BEGIN
	DECLARE `hour` INT;
	SET `hour` = HOUR(NOW());
	CASE
		WHEN `hour` BETWEEN 0 AND 5 THEN RETURN "Доброй ночи";
		WHEN `hour` BETWEEN 6 AND 11 THEN RETURN "Доброе утро";
		WHEN `hour` BETWEEN 12 AND 17 THEN RETURN "Добрый день";
		WHEN `hour` BETWEEN 18 AND 23 THEN RETURN "Добрый вечер";
	END CASE;
END//
DELIMITER ;
SELECT hello();


