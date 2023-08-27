.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students WHERE color = "blue" AND pet = "dog";

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song FROM students WHERE color = "blue" AND pet = "dog";


CREATE TABLE smallest_int_having AS
  SELECT time, smallest FROM students GROUP BY smallest HAVING COUNT(1) = 1;


CREATE TABLE matchmaker AS
  SELECT stu1.pet, stu1.song, stu1.color, stu2.color FROM students stu1, students stu2
    WHERE stu1.pet = stu2.pet AND stu1.song = stu2.song AND stu1.time < stu2.time;


CREATE TABLE sevens AS
  SELECT stu.seven FROM students stu, numbers num
    WHERE stu.time = num.time AND stu.number = 7 AND num.'7' = 'True';


CREATE TABLE average_prices AS
  SELECT category, AVG(MSRP) AS average_price FROM products GROUP BY category;


CREATE TABLE lowest_prices AS
  SELECT store, item, MIN(price) FROM inventory GROUP BY item;


CREATE TABLE shopping_list AS
  SELECT name, store FROM
    (SELECT item.name AS name, inventory.store AS store, MIN(inventory.price)
      FROM (SELECT name, MIN(MSRP / rating) FROM products GROUP BY category) item 
      JOIN inventory ON item.name = inventory.item
      GROUP BY item.name);


CREATE TABLE total_bandwidth AS
  SELECT SUM(stores.Mbs) FROM shopping_list s JOIN stores ON s.store = stores.store;

