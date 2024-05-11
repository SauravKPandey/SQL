CREATE TABLE CUSTOMER_LOGINS (
    customer_id INT,
    login_date DATE
);
w
SELECT * FROM CUSTOMER_LOGINS;
with rankedLogins(Customer,login_date,rnk_date) as
	(select CUSTOMER_LOGINS.customer_id, CUSTOMER_LOGINS.login_date, DENSE_RANK() over (partition by CUSTOMER_LOGINS.customer_id order by CUSTOMER_LOGINS.login_date) as rnk 
		from CUSTOMER_LOGINS)
	Select Customer,login_date,rnk_date,CAST(DATEDIFF(day, rnk_date, login_date) AS date) as date_group from rankedLogins
	
	WITH ranked_logins AS (
    SELECT
        customer_id
        , login_date
        , DENSE_RANK() OVER (
            PARTITION BY customer_id
            ORDER BY login_date
        ) AS rnk
    FROM
        CUSTOMER_LOGINS
)
SELECT
    customer_id
    , login_date
    -- Subract `rnk` from `login_date`
    , login_date - INTERVAL '1' DAY * rnk AS grp_date
FROM
    ranked_logins;


	dataGroup(date_group, Customer) as
	( select (rankedLogins.login_date-rankedLogins.rnk_date ) as date_group, Customer from rankedLogins) 
	select r.Customer,r.login_date,r.rnk_date, d.date_group  from rankedLogins r join dataGroup d on r.Customer=d.Customer 
		group by d.date_group



WITH rankedLogins AS (
    SELECT 
        CUSTOMER_LOGINS.customer_id as Customer, 
        CUSTOMER_LOGINS.login_date, 
        DENSE_RANK() OVER (PARTITION BY CUSTOMER_LOGINS.customer_id ORDER BY CUSTOMER_LOGINS.login_date) AS rnk_date 
    FROM 
        CUSTOMER_LOGINS
)
SELECT 
    Customer,
    login_date,
    rnk_date,
    DATEDIFF(day, rnk_date, login_date) AS date_group 
FROM 
    rankedLogins;

CREATE TABLE orders (
    OrderID INT,
    OrderDate DATE,
    CustomerID INT
);

INSERT INTO orders (OrderID, OrderDate, CustomerID)
VALUES
    (1, '2023-06-20', 1),
    (2, '2023-06-21', 2),
    (3, '2023-06-22', 3),
    (4, '2023-06-21', 1),
    (5, '2023-06-23', 3),
    (6, '2023-06-22', 1),
    (7, '2023-06-26', 4),
    (8, '2023-06-27', 4),
    (9, '2023-06-29', 4),
    (10, '2023-06-29', 5),
    (11, '2023-06-30', 5);
	
select * from orders

select orders.OrderID, orders.OrderDate, orders.CustomerID from orders groupby orders.OrderID,orders.CustomerID

select COUNT(OrderID) AS Total_Orders,OrderDate,CustomerID from orders group by OrderDate, CustomerID

with date_rank(order_id,order_date,customer_id,rnk) as
	(select OrderID,OrderDate,CustomerID, DENSE_RANK() over (partition by CustomerID order by OrderDate) as rnk  from orders)
	select * from date_rank
