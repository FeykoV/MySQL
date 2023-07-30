SELECT * FROM model_mobile.mobile;

/* Задание 2*/
/* Выведите название, производителя и цену для товаров, количество которых 
превышает 2 */

SELECT ProductName, Manufacturer, Price FROM mobile WHERE ProductCount > 2;


/* Задание 3 */
/* Выведите весь ассортимент товаров марки "Samsung" */

SELECT * FROM mobile WHERE Manufacturer = "Samsung";


/* Задание 4.1*/
/* С помощью регулярных выражений найти товары, в которых есть упоминание iphone */

SELECT * FROM mobile WHERE ProductName LIKE "iPhone%";


/* Задание 4.2*/
/* С помощью регулярных выражений найти товары, в которых есть упоминание Samsung */

SELECT * FROM mobile WHERE Manufacturer = "Samsung";


/* Задание 4.3*/
/* С помощью регулярных выражений найти товары, в которых есть ЦИФРЫ */

SELECT * FROM mobile WHERE ProductName REGEXP '[0-9]';


/* Задание 4.4*/
/* С помощью регулярных выражений найти товары, в которых есть ЦИФРА 8 */

SELECT * FROM mobile WHERE ProductName LIKE '%8%';