SELECT TOP (10) *
FROM [SQLBook].[dbo].[Orders]

SELECT TOP (10) *
  FROM [SQLBook].[dbo].[OrderLines]
SELECT TOP (10) *
  FROM [SQLBook].[dbo].[Customers]

select * from ZipCounty
where CountyName = 'San Juan Municipio'


select count(distinct ProductId)
from Products