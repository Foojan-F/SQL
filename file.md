#### Grouping and Aggregation

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
