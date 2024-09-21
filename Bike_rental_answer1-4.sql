-- 1
SELECT category, count(model) AS number_of_bikes 
FROM bike
GROUP BY category
HAVING count(model) > 2;


-- 2
SELECT c.name, count(m.id) AS membership_count
FROM customer AS c
LEFT JOIN membership AS m ON c.id = m.customer_id
GROUP BY c.name
ORDER BY count(0) DESC;
-- To identify the left and right tables:
-- Look at the table in the FROM clause: this is your left table.
-- Look at the table in the JOIN clause: this is your right table.

-- 3 
SELECT
    id, category,
    price_per_hour AS old_price_per_hour,
        CASE
            WHEN category = 'electric' THEN round(price_per_hour - (price_per_hour*0.1), 2)
            WHEN category = 'mountain bike' THEN round(price_per_hour -(price_per_hour*0.2), 2)
            ELSE round(price_per_hour - (price_per_hour*0.5), 2)
        END AS new_price_per_hour,
    price_per_day AS old_price_per_day,
        CASE
            WHEN category = 'electric' THEN round(price_per_day - (price_per_day*0.2), 2)
            WHEN category = 'mountain bike' THEN round (price_per_day - (price_per_day*0.5), 2)
            ELSE round(price_per_day - (price_per_day*0.5), 2)
        END AS new_price_per_day
FROM bike;

-- 4 
SELECT 
    category,
    COUNT(*) FILTER (WHERE status = 'available') AS available_bikes_count,
    COUNT(*) FILTER (WHERE status = 'rented') AS rented_bikes_count
FROM bike
GROUP BY category;
-- alternative
SELECT 
    category,
    COUNT(CASE WHEN status = 'available' THEN 1 END) AS available_bikes_count,
    COUNT(CASE WHEN status = 'rented' THEN 1 END) AS rented_bikes_count
FROM bike
GROUP BY category;

