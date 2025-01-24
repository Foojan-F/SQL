Find customers who have made more than the average number of orders.
```sql
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
```
Retrieve products that have been ordered more times than the average number of orders.
```sql
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
```
