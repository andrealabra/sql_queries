-- 1 
SELECT category_name, count(sportinggoods_id), max(list_price)
FROM sportinggoods_categories, sportinggoods_inventory
WHERE 
sportinggoods_categories.category_id = sportinggoods_inventory.category_id
GROUP BY category_name
ORDER BY count(sportinggoods_id) desc; 

-- 2 
SELECT email_address,
SUM(item_price * Quantity) AS item_price_total,
SUM(discount_amount * Quantity) AS discount_amount_total
FROM athletes  c
JOIN athlete_orders o ON c.athlete_id = o.athlete_id
JOIN athlete_order_items oi ON o.order_id = oi.order_id
GROUP BY email_address
ORDER BY item_price_total DESC; 

-- 3 
SELECT 
    c.email_address,
    COUNT(o.order_id) AS count,
    SUM(o.item_price - o.discount_amount) * COUNT(o.order_id) AS order_total
FROM athletes AS c
INNER JOIN 
    athlete_orders AS ord ON c.athlete_id = ord.athlete_id
INNER JOIN
    athlete_order_items AS o ON o.order_id = ord.order_id
GROUP BY c.athlete_id
HAVING count > 1
ORDER BY order_total DESC; 

-- 4 
SELECT 
    c.email_address,
    COUNT(o.order_id) AS count,
    SUM(o.item_price - o.discount_amount) * COUNT(o.order_id) AS order_total
FROM athletes AS c
INNER JOIN 
    athlete_orders AS ord ON c.athlete_id = ord.athlete_id
INNER JOIN
    athlete_order_items AS o ON o.order_id = ord.order_id
WHERE o.item_price>400 
GROUP BY c.athlete_id
HAVING count > 1
ORDER BY order_total DESC; 

-- 5
SELECT sportinggoods_name, SUM((item_price-discount_amount)*quantity) AS "total amount" 
FROM sportinggoods_inventory, athlete_order_items
WHERE sportinggoods_inventory.sportinggoods_id=athlete_order_items.sportinggoods_id
GROUP BY sportinggoods_name WITH ROLLUP; 

-- 6 
SELECT email_address, COUNT(*)
FROM athletes, athlete_orders
WHERE athletes.athlete_id = athlete_orders.athlete_id
GROUP BY email_address
HAVING COUNT(*)>1
ORDER BY email_address ASC;


-- 7 (skipped number 7, this is number 8)
SELECT order_id,
SUM( (item_price - discount_amount) * quantity) AS total_amount,
SUM( (item_price - discount_amount) * quantity) OVER(PARTITION BY order_id) AS order_amount
FROM athlete_order_items
GROUP BY order_id, item_id
ORDER BY order_id ASC; 

-- 8 (number 9)
SELECT order_id,
SUM( (item_price - discount_amount) * quantity) AS total_amount,
SUM( (item_price - discount_amount) * quantity) OVER(PARTITION BY order_id) AS order_amount
FROM athlete_order_items
GROUP BY order_id, item_id
ORDER BY order_id ASC; 

-- 9  (number 10) 
SELECT ao.athlete_id, ao.order_id,
SUM((item_price - discount_amount) * quantity) AS total_amount,
SUM((item_price - discount_amount) * quantity) OVER(PARTITION BY ao.athlete_id) AS athlete_amount,
SUM((item_price - discount_amount) * quantity) OVER(PARTITION BY ao.athlete_id
ORDER BY ao.order_date)
AS athlete_amount_by_date
FROM athlete_orders ao, athlete_order_items aoi
WHERE ao.order_id = aoi.order_id
GROUP BY ao.athlete_id, sportinggoods_id
ORDER BY ao.athlete_id, athlete_amount; 
