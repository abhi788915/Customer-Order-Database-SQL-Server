 
 
 ---------------------------------------- // PROJECT 1 // ----------------------------------------------
 -------------------------------------- CUSTOMERS ORDER DATABASE  --------------------------------------
 
 Create Database Customers_Orders_Products 

CREATE TABLE Customers (CustomerID INT, Name VARCHAR(max), Email VARCHAR(max))
INSERT INTO Customers VALUES
  (1, 'John Doe', 'johndoe@example.com'),
  (2, 'Jane Smith', 'janesmith@example.com'),
  (3, 'Robert Johnson', 'robertjohnson@example.com'),
  (4, 'Emily Brown', 'emilybrown@example.com'),
  (5, 'Michael Davis', 'michaeldavis@example.com'),
  (6, 'Sarah Wilson', 'sarahwilson@example.com'),
  (7, 'David Thompson', 'davidthompson@example.com'),
  (8, 'Jessica Lee', 'jessicalee@example.com'),
  (9, 'William Turner', 'williamturner@example.com'),
  (10, 'Olivia Martinez', 'oliviamartinez@example.com')

CREATE TABLE Orders(OrderID INT, CustomerID INT, ProductName VARCHAR(max), OrderDate DATE, Quantity INT)
INSERT INTO Orders VALUES
  (1, 1, 'Product A', '2023-07-01', 5),
  (2, 2, 'Product B', '2023-07-02', 3),
  (3, 3, 'Product C', '2023-07-03', 2),
  (4, 4, 'Product A', '2023-07-04', 1),
  (5, 5, 'Product B', '2023-07-05', 4),
  (6, 6, 'Product C', '2023-07-06', 2),
  (7, 7, 'Product A', '2023-07-07', 3),
  (8, 8, 'Product B', '2023-07-08', 2),
  (9, 9, 'Product C', '2023-07-09', 5),
  (10, 10, 'Product A', '2023-07-10', 1)

CREATE TABLE Products(ProductID INT, ProductName VARCHAR(max), Price DECIMAL(10, 2))
INSERT INTO Products VALUES
  (1, 'Product A', 10.99),
  (2, 'Product B', 8.99),
  (3, 'Product C', 5.99),
  (4, 'Product D', 12.99),
  (5, 'Product E', 7.99),
  (6, 'Product F', 6.99),
  (7, 'Product G', 9.99),
  (8, 'Product H', 11.99),
  (9, 'Product I', 14.99),
  (10, 'Product J', 4.99)


-----------------------------------------------------------------------------------------------------------------------
select*from Customers
select*from Orders
select*from Products
--------------------------------------------- // Task 1 :- // ----------------------------------------------------------

-- 1.Write a query to retrieve all records from the Customers table..
select*from Customers


-- 2.Write a query to retrieve the names and email addresses of customers whose names start with 'J'.
select Name, Email from Customers where Name like 'J%'


-- 3.Write a query to retrieve the order details (OrderID, ProductName, Quantity) for all orders..
select OrderID, ProductName, Quantity from Orders


-- 4.Write a query to calculate the total quantity of products ordered.
select sum(Quantity) 'Total Qantity' from Orders


-- 5.Write a query to retrieve the names of customers who have placed an order.
select C.Name from Customers C
join Orders O
on C.CustomerID = O.CustomerID
group by Name


-- 6.Write a query to retrieve the products with a price greater than $10.00.
select ProductName from Products where Price>10.00


-- 7.Write a query to retrieve the customer name and order date for all orders placed on or after '2023-07-05'.
select C.Name, O.OrderDate from Customers C
join Orders O
on C.CustomerID = O.CustomerID
where OrderDate>= '2023-07-05'


-- 8.Write a query to calculate the average price of all products.
select AVG(Price)'Average Price' from Products


-- 9.Write a query to retrieve the customer names along with the total quantity of products they have ordered.
select C.Name, sum(O.Quantity)'Total Quantity' from Customers C
join Orders O
on C.CustomerID = O.CustomerID
group by Name


-- 10.Write a query to retrieve the products that have not been ordered.
select ProductName from Products where ProductName not in (select ProductName from Orders) order by ProductName

select ProductName from Products
except
Select ProductName from Orders
order by ProductName

---------------------------------------------------------------------------------------------------------------------------
select*from Customers
select*from Orders
select*from Products
------------------------------------------------ // Task 2 :- // ----------------------------------------------------------

-- 1.Write a query to retrieve the top 5 customers who have placed the highest total quantity of orders.
select top(5) C.Name, sum(O.Quantity)'Total Quantity' from Customers C
join Orders O
on C.CustomerID = O.CustomerID
group by Name
order by [Total Quantity] desc


-- 2.Write a query to calculate the average price of products for each product category.
SELECT O.ProductName , AVG(P.Price) AS AveragePrice FROM Products P
JOIN Orders O 
ON P.ProductName = O.ProductName
GROUP BY O.ProductName


-- 3.Write a query to retrieve the customers who have not placed any orders.
select C.CustomerId, C.Name, C.Email from Customers C
Left join Orders O
on C.CustomerID = O.CustomerID
where O.OrderId is null 
-- In this case, all customers have placed orders, so the result is empty. 
-- If there were customers who had not placed any orders, they would be listed here.


-- 4.Write a query to retrieve the order details (OrderID, ProductName, Quantity) for orders placed by customers whose names start with 'M'.
select C.Name ,O.OrderID, O.ProductName, O.Quantity from Orders O
join Customers C
on O.CustomerID=C.CustomerID
where C.Name like 'M%'


-- 5.Write a query to calculate the total revenue generated from all orders.
select sum(P.Price * O.Quantity) 'Total Revenue' from Orders O
join Products P
on O.ProductName = P.ProductName

-- 6.Write a query to retrieve the customer names along with the total revenue generated from their orders.
select C.Name ,sum(P.Price * O.Quantity) 'Total Revenue' from Orders O
join Products P
on O.ProductName = P.ProductName
join Customers C
on C.CustomerID = O.CustomerID
group by C.Name
order by [Total Revenue] asc


-- 7.Write a query to retrieve the customers who have placed at least one order for each product category.
WITH TotalProducts AS (
    SELECT COUNT(DISTINCT ProductName) AS TotalProductCount
    FROM Products
),
CustomerProductCount AS (
    SELECT O.CustomerId, COUNT(DISTINCT O.ProductName) AS OrderedProductCount
    FROM Orders O
    GROUP BY O.CustomerId
)
SELECT C.CustomerId, C.Name
FROM Customers C
JOIN CustomerProductCount CPC ON C.CustomerId = CPC.CustomerId
JOIN TotalProducts TP ON CPC.OrderedProductCount = TP.TotalProductCount;



-- 8.Write a query to retrieve the customers who have placed orders on consecutive days.
SELECT DISTINCT O1.CustomerId, C.Name FROM Orders O1
JOIN Orders O2 
ON O1.CustomerId = O2.CustomerId AND O1.OrderDate = DATEADD(DAY, 1, O2.OrderDate)
JOIN Customers C
ON O1.CustomerId = C.CustomerId;


-- 9.Write a query to retrieve the top 3 products with the highest average quantity ordered.
select top(3) ProductName, AVG(Quantity) 'Average quantity' from Orders
Group by ProductName
ORDER BY [Average quantity] DESC


-- 10.Write a query to calculate the percentage of orders that have a quantity greater than the average quantity.
with AverageQuantity as 
(
select AVG(Quantity) as AvgQuantity from Orders
),
quantityCount as (
select 
(Select count(*) from Orders) as TotalCount,
(select COUNT(*) from Orders where Quantity > (select AvgQuantity from AverageQuantity)) as OrderAboveAverage)

select(OrderAboveAverage * 100 / TotalCount) as Persentage from quantityCount 


---------------------------------------------------------------------------------------------------------------------------
select*from Customers
select*from Orders
select*from Products
------------------------------------------------ // Task 3 :- // ----------------------------------------------------------

-- 1.Write a query to retrieve the customers who have placed orders for all products.
WITH ProductCount AS (
    SELECT COUNT(DISTINCT ProductName) AS TotalProducts FROM Products
),

CustomerProductCount AS (
    SELECT O.CustomerId, COUNT(DISTINCT O.ProductName) AS ProductsOrdered FROM Orders O
    GROUP BY O.CustomerId
)
SELECT C.CustomerId, C.Name FROM CustomerProductCount CPC
JOIN ProductCount PC 
ON CPC.ProductsOrdered = PC.TotalProducts
JOIN Customers C 
ON CPC.CustomerId = C.CustomerId


-- 2.Write a query to retrieve the products that have been ordered by all customers.

-- 3.Write a query to calculate the total revenue generated from orders placed in each month.
SELECT YEAR(O.OrderDate) 'OrderYear', MONTH(O.OrderDate) 'OrderMonth' , SUM(O.Quantity * P.Price) AS TotalRevenue FROM Orders O
JOIN Products P ON O.ProductName = P.ProductName
GROUP BY [OrderDate]
ORDER BY OrderYear, OrderMonth



-- 4.Write a query to retrieve the top 5 customers who have spent the highest amount of money on orders.
SELECT top(5) C.CustomerId,  C.Name, SUM(O.Quantity * P.Price) AS TotalSpent FROM Orders O
JOIn Products P 
ON O.ProductName = P.ProductName
JOIN Customers C
ON O.CustomerId = C.CustomerId
GROUP BY C.CustomerId, C.Name
ORDER BY TotalSpent DESC 



-- 5.Write a query to calculate the running total of order quantities for each customer.
SELECT  C.Name, O.OrderDate, O.Quantity,
SUM(O.Quantity) OVER (PARTITION BY O.CustomerId ORDER BY O.OrderDate) AS RunningTotal
FROM Orders O
JOIN Customers C 
on O.CustomerId = C.CustomerId
ORDER BY O.CustomerId, O.OrderDate



-- 6.Write a query to retrieve the top 3 most recent orders for each customer.
Select top(3) C.CustomerID, P.ProductName, O.OrderDate, C.Name from Orders O
Join Customers C
on O.CustomerID = C.CustomerID
join Products P
on P.ProductName = O.ProductName
order by O.OrderDate desc


-- 7.Write a query to calculate the total revenue generated by each customer in the last 30 days.
SELECT C.CustomerId,C.Name,SUM(O.Quantity * P.Price) AS TotalRevenu FROM Orders O
JOIN Products P 
ON O.ProductName = P.ProductName
JOIN Customers C 
ON O.CustomerId = C.CustomerId
WHERE O.OrderDate >= DATEADD(DAY, -30, '2023-07-10')  -- Adjust based on current date
GROUP BY C.CustomerId, C.Name
ORDER BY [TotalRevenu] DESC



-- 8.Write a query to retrieve the customers who have placed orders for at least two different product categories.
SELECT C.CustomerId, C.Name FROM Orders O
JOIN Products P 
ON O.ProductName = P.ProductName
JOIN Customers C 
ON O.CustomerId = C.CustomerId
GROUP BY C.CustomerId, C.Name
HAVING COUNT(DISTINCT P.ProductName) >= 2
