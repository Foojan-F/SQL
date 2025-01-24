### **Grouping and Aggregation**  
Get the total number of customers in each state.
```sql
SELECT State , COUNT(DISTINCT CustomerId)NumberOfCoustomer
FROM Orders
GROUP BY State
ORDER BY NumberOfCoustomer DESC;
```
Calculate the total sales (sum of order amount) by product.
```sql
SELECT ProductId,SUM(TotalPrice) AS TotalSalesAmount
FROM OrderLines
GROUP BY ProductId
ORDER BY TotalSalesAmount DESC;
```
Find the average order value for each campaign.
```sql
SELECT CampaignId, AVG(TotalPrice) AS AverageOrderAmount
FROM Orders
GROUP BY CampaignId
ORDER BY AverageOrderAmount DESC;
```
Retrieve the maximum, minimum, and average prices of all products
```sql
SELECT MAX(TotalPrice)AS MAX,MIN(TotalPrice) AS MIN,AVG(TotalPrice) AS AVG
FROM OrderLines
```
Get the total number of orders placed by each customer.
```sql
SELECT CustomerId,COUNT(OrderId) AS NumberOfOrders
FROM Orders
GROUP BY CustomerId
ORDER BY NumberOfOrders DESC;
```
Calculate the total number of products ordered in each order.
```sql
SELECT OrderId,COUNT(ProductId) AS TotalNumberOfProducts
FROM OrderLines
GROUP BY OrderId 
ORDER BY COUNT(ProductId) DESC;
```
Find the number of subscribers per campaign.
```sql
SELECT CampaignId,COUNT(S.SubscriberId) AS numberOfSubscriber
FROM Orders
JOIN Subscribers S ON S.SubscriberId= CustomerId 
GROUP BY CampaignId
ORDER BY COUNT(S.SubscriberId) DESC;
```
Retrieve the total number of orders placed by customers in each county.
```sql
SELECT Z.CountyName, COUNT(O.OrderId) AS TotalNumberOfOrders 
FROM Orders O
JOIN ZipCounty Z ON Z.ZipCode = O.ZipCode
GROUP BY CountyName
ORDER BY CountyName ;
```
List the products with their total order quantity, ordered by highest to lowest.
```sql
SELECT ProductId , SUM(NumUnits) AS numberOfOrder
FROM OrderLines
GROUP BY ProductId
ORDER BY numberOfOrder DESC;
```
Calculate the total population per state from the [ZipCensus] table.
```sql
SELECT state, SUM(TotPop) AS TotalPopulation
FROM ZipCensus
GROUP BY state
ORDER BY state;
```
