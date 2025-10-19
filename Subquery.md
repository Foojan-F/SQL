List the products ordered by customers who have ordered more than 5 times.  
```sql
SELECT DISTINCT OL.ProductId
FROM Orders O
JOIN OrderLines OL ON O.OrderId = OL.OrderId
WHERE O.CustomerId IN (
    SELECT CustomerId
    FROM Orders
    GROUP BY CustomerId
    HAVING COUNT(OrderId) > 5
);
```

the list of all zip codes in states with fewer than 100 zip codes

```sql
SELECT zc1.zcta5
FROM ZipCensus zc1
WHERE EXISTS (
    SELECT 1
    FROM ZipCensus zc2
    WHERE zc2.state = zc1.state
    GROUP BY zc2.state
    HAVING COUNT(*) < 100
);
```
