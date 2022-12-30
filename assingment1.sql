-- 1
SELECT sportinggoods_name, list_price, date_added
FROM sportinggoods_inventory
WHERE list_price > 500 AND list_price < 2000 
ORDER BY date_added DESC; 

-- 2 
SELECT
item_id, item_price,
discount_amount, quantity,
item_price * quantity AS price_total,
discount_amount * quantity AS discount_total,
(item_price - discount_amount) * quantity AS item_total
FROM athlete_order_items
WHERE (item_price - discount_amount) * quantity > 500
ORDER BY item_total DESC; 

-- 3 
SELECT
NOW() AS 'today_unformatted',
DATE_FORMAT(NOW(), '%d-%b-%Y') AS 'today_formatted'; 

-- 4 
SELECT first_name, last_name, line1, city, state, zip_code
FROM athletes JOIN athlete_addresses
ON athletes.athlete_id = athlete_addresses.athlete_id
WHERE email_address='david.goldstein@hotmail.com';

-- 5 
SELECT first_name, last_name, line1, city, state, zip_code
FROM athletes Ath JOIN athlete_addresses Addr
ON Ath.athlete_id = Addr.athlete_id
AND Ath.billing_address_id = Addr.address_id; 
											 
-- 6 																												
SELECT Ath.last_name, Ath.first_name, Od.order_date, Pro.sportinggoods_name, 
It.item_price, It.discount_amount, It.quantity
FROM athletes Ath
JOIN athlete_orders Od
ON Ath.athlete_id=Od.athlete_id
JOIN athlete_order_items It
ON Od.order_id=It.order_id
JOIN sportinggoods_inventory Pro
ON It.sportinggoods_id=Pro.sportinggoods_id
ORDER BY Ath.last_name, Od.order_date, Pro.sportinggoods_name; 

-- 7 
SELECT p1.sportinggoods_name , p1.list_price
FROM sportinggoods_inventory AS p1, sportinggoods_inventory AS p2
WHERE p1.list_price=p2.list_price AND p1.sportinggoods_id != p2.sportinggoods_id
ORDER BY sportinggoods_name; 

-- 8 
(SELECT 'SHIPPED' AS ship_status, order_id, order_date
FROM athlete_orders 
Where ship_date IS NOT NULL)
UNION
(SELECT 'NOT SHIPPED' AS ship_status, order_id, order_date
FROM athlete_orders 
Where ship_date IS NULL)
ORDER BY order_date

