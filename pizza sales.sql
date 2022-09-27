-- Use Database Pizza_Sales
USE pizza_sales;

-- Select Top 100 row from orders, order_details, pizza_types and Pizzas table
SELECT TOP 100 * FROM dbo.orders;
SELECT TOP 100 * FROM dbo.order_details;
SELECT TOP 100 * FROM dbo.pizza_types;
SELECT TOP 100 * FROM dbo.pizzas;

-- Count row for each table
SELECT COUNT (*) FROM dbo.orders;
SELECT COUNT(*) FROM dbo.order_details;
SELECT COUNT(*) FROM dbo.pizza_types;
SELECT COUNT(*) FROM dbo.pizzas;

-- select distinct year to know year in table
SELECT DISTINCT YEAR(date) FROM  dbo.orders;

-- select month group by month
SELECT MONTH(date) AS 'month' 
FROM dbo.orders
GROUP BY MONTH(date)
ORDER BY MONTH(date);

-- join orders table and order_details table
SELECT 
	SUM(order_details.quantity) AS quantity
FROM orders LEFT JOIN order_details 
	ON orders.order_id = order_details.order_id;

-- sum order quantity
SELECT 
	MONTH(orders.date) AS 'month',
	SUM(order_details.quantity) AS quantity
FROM orders LEFT JOIN order_details 
	ON orders.order_id = order_details.order_id
GROUP BY MONTH(orders.date)
ORDER BY quantity DESC;

-- sum pizza price based on order
SELECT 
	SUM(pizzas.price) AS price
FROM orders 
	LEFT JOIN order_details 
		ON orders.order_id = order_details.order_id
	LEFT JOIN pizzas 
		ON pizzas.pizza_id = order_details.pizza_id;

-- sum quantity, sum price group by month
SELECT 
	MONTH(orders.date) AS 'month',
	SUM(order_details.quantity) AS quantity,
	SUM(pizzas.price) AS price
FROM orders 
	LEFT JOIN order_details 
		ON orders.order_id = order_details.order_id
	LEFT JOIN pizzas 
		ON pizzas.pizza_id = order_details.pizza_id
GROUP BY MONTH(orders.date)
ORDER BY quantity DESC,price DESC;


-- select top 5 pizza name with the mos quantity orders
SELECT TOP 5 
	pizza_types.name,
	SUM(order_details.quantity) AS quantity
FROM orders 
	LEFT JOIN order_details 
		ON orders.order_id = order_details.order_id
	LEFT JOIN pizzas 
		ON pizzas.pizza_id = order_details.pizza_id
	LEFT JOIN pizza_types
		ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.name,pizza_types.category
ORDER BY quantity DESC;

-- select top 5 pizza name with the most revenue based on orders table
SELECT TOP 5 
	pizza_types.name,
	SUM(pizzas.price) AS price
FROM orders 
	LEFT JOIN order_details 
		ON orders.order_id = order_details.order_id
	LEFT JOIN pizzas 
		ON pizzas.pizza_id = order_details.pizza_id
	LEFT JOIN pizza_types
		ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.name,pizza_types.category
ORDER BY price DESC;

-- sum quantity based on pizza size
SELECT
	pizzas.size,
	SUM(order_details.quantity) AS quantity
FROM orders 
	LEFT JOIN order_details 
		ON orders.order_id = order_details.order_id
	LEFT JOIN pizzas 
		ON pizzas.pizza_id = order_details.pizza_id
	LEFT JOIN pizza_types
		ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizzas.size
ORDER BY quantity DESC;

-- find percentage for each category by quantity order
SELECT
	COUNT(CASE WHEN pizza_types.category = 'Classic' THEN order_details.quantity ELSE NULL END),
	COUNT(CASE WHEN pizza_types.category = 'Supreme' THEN order_details.quantity ELSE NULL END),
	COUNT(CASE WHEN pizza_types.category = 'Chicken' THEN order_details.quantity ELSE NULL END),
	COUNT(CASE WHEN pizza_types.category = 'Veggie' THEN order_details.quantity ELSE NULL END)
FROM orders 
	LEFT JOIN order_details 
		ON orders.order_id = order_details.order_id
	LEFT JOIN pizzas 
		ON pizzas.pizza_id = order_details.pizza_id
	LEFT JOIN pizza_types
		ON pizza_types.pizza_type_id = pizzas.pizza_type_id;















