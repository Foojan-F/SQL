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

List customers whose order total is greater than the total of a specific product's orders.
```sql
-- Calculate the total revenue of a specific product
WITH ProductTotal AS (
    SELECT 
        ProductId,
        SUM(TotalPrice) AS TotalProductRevenue
    FROM 
        OrderLines
    WHERE 
        ProductId = 11075
    GROUP BY 
        ProductId
    
),

-- Calculate the total order value for each customer
CustomerTotals AS (
    SELECT 
        O.CustomerId,
        SUM(OL.TotalPrice) AS TotalCustomerOrders
    FROM 
        Orders O
    JOIN 
        OrderLines OL ON O.OrderId = OL.OrderId
    GROUP BY 
        O.CustomerId
)

-- Compare customer total with product total
SELECT 
    CT.CustomerId,
    CT.TotalCustomerOrders
FROM 
    CustomerTotals CT
JOIN 
    ProductTotal PT ON CT.TotalCustomerOrders > PT.TotalProductRevenue;
```

