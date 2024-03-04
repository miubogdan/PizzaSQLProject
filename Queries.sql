-- Total orders

SELECT COUNT(*) AS total_orders FROM orders;

-- Total sales

SELECT SUM(item_price * quantity) AS total_sales
FROM orders
JOIN item ON orders.item_id = item.item_id;

-- Total items

SELECT COUNT(*) AS total_items FROM item;

-- Average order value

SELECT AVG(item_price * quantity) AS average_order_value
FROM orders
JOIN item ON orders.item_id = item.item_id;

-- Sales by category

SELECT item_cat, SUM(item_price * quantity) AS sales
FROM orders
JOIN item ON orders.item_id = item.item_id
GROUP BY item_cat;

-- Top selling items

SELECT item_id, SUM(quantity) AS total_quantity_sold
FROM orders
GROUP BY item_id
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- Orders by hour

SELECT HOUR(created_at) AS order_hour, COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour;

-- Sales by hour

SELECT HOUR(created_at) AS order_hour, SUM(item_price * quantity) AS total_sales
FROM orders
JOIN item ON orders.item_id = item.item_id
GROUP BY order_hour;

-- Orders by address id

SELECT add_id, COUNT(*) AS orders_count
FROM orders
GROUP BY add_id
ORDER BY orders_count desc;

-- Orders by delivery/pick up

SELECT delivery, COUNT(*) AS orders_count
FROM orders
GROUP BY delivery;

-- Calculated cost of pizza

SELECT item.sku, item.item_name, SUM(ingredient.ing_price/ingredient.ing_weight * recipe.quantity) AS cost_of_pizza
FROM item
JOIN recipe ON item.sku = recipe.recipe_id
JOIN ingredient ON recipe.ing_id = ingredient.ing_id
GROUP BY item.sku, item.item_name;

-- Top 5 customers by revenue

SELECT
    customers.cust_id,
    customers.cust_firstname,
    customers.cust_lastname,
    SUM(item.item_price * orders.quantity) AS total_spent
FROM orders
JOIN customers ON orders.cust_id = customers.cust_id
JOIN item ON orders.item_id = item.item_id
GROUP BY customers.cust_id
ORDER BY total_spent DESC
LIMIT 5;

