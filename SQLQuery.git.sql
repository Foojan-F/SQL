USE SQLBook;
--Retrieve the names of all campaigns in the [Campaigns] table.
SELECT DISTINCT(CampaignId)
FROM Campaigns
--List the first 10 products from the [Products] table.
SELECT top(10) ProductId
FROM Products;
--Get the first 5 zip codes from the [ZipCounty] table.
select top(5) ZipCode
from ZipCounty;
--Find all customers who live in a specific state.LIKE CALIFORNIA
SELECT CustomerId
FROM Orders
WHERE State = 'CA';
--Retrieve all customers who purchased a specific product.LIKE PRODUCT 10010
SELECT CustomerId FROM Orders O
JOIN OrderLines OL ON OL.OrderId = O.OrderId
WHERE ProductId = 10010;
--Get the total number of records in the [Orders] table.
SELECT COUNT(OrderId)
FROM ORDERS
--Retrieve all orders placed after January 1, 2024.
SELECT *
FROM Orders
WHERE OrderDate > '2012-12-01';
--List the names of all products with prices greater than $50.
SELECT * 
FROM Products
WHERE FullPrice>50;
--Find all customers who live in a particular county (use the CountyName).
SELECT CustomerId
FROM Orders O
JOIN ZipCounty Z ON O.ZipCode=Z.ZipCode
WHERE Z.CountyName = 'Luquillo Municipio'
------Retrieve all campaigns that have a start date after a specific date.
SELECT * FROM Campaigns
--------Retrieve the customer names along with the campaign names they are subscribed to
SELECT c.FirstName,Ca.CampaignName 
from Orders o
JOIN Customers c ON c.CustomerId = o.CustomerId
JOIN Campaigns Ca ON Ca.CampaignId = o.CampaignId
--12.List the product names and their corresponding order amounts.
SELECT OL.ProductId,SUM(TotalPrice)AS OrderAmount,P.Name FROM OrderLines OL
JOIN Products P ON P.ProductId = OL.ProductId
GROUP BY OL.ProductId,P.Name
ORDER BY OrderAmount DESC
--13.Retrieve the zip codes along with their respective counties
select ZipCode,CountyName from ZipCounty
order by CountyName
--14.Find customers and their orders, including order details (use Customers, Orders, and OrderLines).
SELECT Customers.FirstName,OL.*
FROM OrderLines OL
JOIN Orders ON Orders.OrderId= OL.OrderId
JOIN Customers ON Customers.CustomerId = Orders.CustomerId
--15.Get the total order amount for each customer.
SELECT C.FirstName, SUM(O.TotalPrice)TotalOrderAmount
FROM Orders O
JOIN Customers C ON C.CustomerId=O.CustomerId
GROUP BY C.FirstName
--16.List all products that have been ordered by customers in a specific state.
SELECT Orders.State , OrderLines.ProductId, COUNT(*)NumberOfOrders	
FROM Orders
JOIN OrderLines ON ORDERS.OrderId = OrderLines.OrderId
WHERE State = 'CA' 
GROUP BY State,ProductId
--17.Retrieve all customers and the products they ordered, along with the quantity ordered.

SELECT Orders.CustomerId , OrderLines.ProductId ,SUM(OrderLines.NumUnits) AS Quantity
FROM OrderLines
JOIN Orders ON  Orders.OrderId = OrderLines.OrderId
Group by Orders.CustomerId,OrderLines.ProductId
--18.List the counties that have populations greater than 1,000,000, along with the state they belong to.
SELECT DISTINCT CountyName,CountyPop
FROM ZipCounty
WHERE CountyPop> 1000000
--19.Show customers who have ordered more than one product.
SELECT CustomerId, COUNT(DISTINCT ProductId) AS NumberOfProducts
FROM Orders O
JOIN OrderLines OL ON O.OrderId = OL.OrderId
GROUP BY CustomerId
HAVING COUNT(DISTINCT ProductId) > 1
ORDER BY NumberOfProducts DESC;
--20.Retrieve the zip codes and the corresponding county names for the customers who live in those zip codes.
SELECT Z.CountyName,Z.ZipCode,O.CustomerId
FROM ZipCounty Z
JOIN Orders O  ON Z.ZipCode = O.ZipCode
GROUP BY Z.CountyName,Z.ZipCode,O.CustomerId
----Grouping and Aggregation
--21.Get the total number of customers in each state.
SELECT State , COUNT(DISTINCT CustomerId)NumberOfCoustomer
FROM Orders
GROUP BY State
ORDER BY NumberOfCoustomer DESC; 
--22.Calculate the total sales (sum of order amount) by product.
SELECT ProductId,SUM(TotalPrice) AS TotalSalesAmount
FROM OrderLines
GROUP BY ProductId
ORDER BY TotalSalesAmount DESC;
--23.Find the average order value for each campaign.
SELECT CampaignId, AVG(TotalPrice) AS AverageOrderAmount
FROM Orders
GROUP BY CampaignId
ORDER BY AverageOrderAmount DESC;
--24.Retrieve the maximum, minimum, and average prices of all products
SELECT MAX(TotalPrice)AS MAX,MIN(TotalPrice) AS MIN,AVG(TotalPrice) AS AVG
FROM OrderLines
--25.Get the total number of orders placed by each customer.
SELECT CustomerId,COUNT(OrderId) AS NumberOfOrders
FROM Orders
GROUP BY CustomerId
ORDER BY NumberOfOrders DESC;
--26.Calculate the total number of products ordered in each order.
SELECT OrderId,COUNT(ProductId) AS TotalNumberOfProducts
FROM OrderLines
GROUP BY OrderId 
ORDER BY COUNT(ProductId) DESC;
--27.Find the number of subscribers per campaign.
SELECT CampaignId,COUNT(S.SubscriberId) AS numberOfSubscriber
FROM Orders
JOIN Subscribers S ON S.SubscriberId= CustomerId 
GROUP BY CampaignId
ORDER BY COUNT(S.SubscriberId) DESC;
--28.Retrieve the total number of orders placed by customers in each county.
SELECT Z.CountyName, COUNT(O.OrderId) AS TotalNumberOfOrders 
FROM Orders O
JOIN ZipCounty Z ON Z.ZipCode = O.ZipCode
GROUP BY CountyName
ORDER BY CountyName ;
--29.List the products with their total order quantity, ordered by highest to lowest.

SELECT ProductId , SUM(NumUnits) AS numberOfOrder
FROM OrderLines
GROUP BY ProductId
ORDER BY numberOfOrder DESC;
--30.Calculate the total population per state from the [ZipCensus] table.
SELECT state, SUM(TotPop) AS TotalPopulation
FROM ZipCensus
GROUP BY state
ORDER BY state;
--31.Find customers who have made more than the average number of orders
WITH CustomerOrderCounts AS (
    SELECT 
        CustomerId, 
        COUNT(OrderId) AS NumberOfOrders
    FROM Orders
    GROUP BY CustomerId
),
AverageOrders AS (
    SELECT 
        AVG(NumberOfOrders) AS AvgOrders
    FROM CustomerOrderCounts
)
SELECT 
    C.CustomerId, 
    C.NumberOfOrders
FROM CustomerOrderCounts C
CROSS JOIN AverageOrders A
WHERE C.NumberOfOrders > A.AvgOrders;
--32.Retrieve products that have been ordered more times than the average number of orders.
WITH ProductOrderCount AS(
	SELECT ProductId,
		COUNT(OrderId) AS NumberOfOrders
	FROM OrderLines
	GROUP BY ProductId
), 
 AVGOrderNumber AS (
	 SELECT AVG(NumberOfOrders) AS AVGNUMBEROFORDER
	 FROM ProductOrderCount
	 )
SELECT ProductId, NumberOfOrders
FROM ProductOrderCount
CROSS JOIN  AVGOrderNumber 
WHERE NumberOfOrders>AVGNUMBEROFORDER;
--33.List customers whose order total is greater than the total of a specific product's orders.
WITH TotalOfSproduct AS (
	SELECT ProductId,SUM(NumUnits) AS totalOfOrders
	FROM OrderLines
	GROUP BY ProductId
	),
CustomertotalOrder AS(
	SELECT CustomerId ,COUNT(OrderId) AS totalNumberOfOrders
	FROM Orders
	GROUP BY CustomerId)
SELECT 
