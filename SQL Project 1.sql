--1)CUSTOMER DETALS

USE AdventureWorks2012

SELECT
    p.BusinessEntityID,
    p.FirstName,
    p.LastName,
    e.EmailAddress,
    ph.PhoneNumber,
    pt.Name AS PhoneNumberType
FROM
    Person.Person AS p
LEFT JOIN
person.EmailAddress AS e ON  p.BusinessEntityID= e.BusinessEntityID
LEFT JOIN
Person.PersonPhone AS ph ON  p.BusinessEntityID= ph.BusinessEntityID
LEFT JOIN
Person.PhoneNumberType AS pt ON ph.PhoneNumberTypeID= pt.PhoneNumberTypeID;

-- 2)Get all the detalis of the sales header order made in may 2011

Select * from Sales.SalesOrderHeader;

SELECT
    SalesOrderID,
    OrderDate,
    DueDate,
    ShipDate,
    Status,
    TotalDue
FROM
    Sales.SalesOrderHeader
WHERE
    OrderDate >= '2011-05-01' AND OrderDate < '2011-06-01';

--3) Get the details of the sales details order made in the month of May 2011

select * from sales.SalesOrderDetail;

select 
     sod.SalesOrderID,
	 sod.SalesOrderDetailID,
	 sod.ProductID,
	 sod.OrderQty,
	 sod.UnitPrice,
	 sod.UnitPriceDiscount,
	 sod.LineTotal,
	 soh.OrderDate
From
     Sales.SalesOrderDetail AS sod
JOIN
 Sales.SalesOrderHeader AS soh ON sod.SalesOrderID= soh.SalesOrderID
 Where
     soh.OrderDate >= '2011-05-01' AND soh.OrderDate < '2011-06-01';

-- 4)Get the total sales made in may 2011

SELECT
    SUM(TotalDue) AS TotalSales
FROM
    Sales.SalesOrderHeader
WHERE
    OrderDate >= '2011-05-01' AND OrderDate < '2011-06-01';

--5)  Get the total sales made in the year 2011 by month order by increasing sales

Select
    DATEPART(MONTH, OrderDate) AS MonthName,
	SUM(TotalDue) AS TotalSales
FROM 
    sales.SalesOrderHeader
WHERE 
    DATEPART( YEAR, OrderDate) = 2011
GROUP BY 
    DATENAME(MONTH, OrderDate),
    DATEPART(MONTH,OrderDate)
ORDER BY
    TotalSales ASC;

-- 6) Get the total sales made to the customer with FirstName='Gustavo' and LastName= 'Achong'

SELECT
    SUM(soh.TotalDue) AS TotalSales
FROM
    Sales.SalesOrderHeader AS soh
JOIN
    Sales.Customer AS c ON soh.CustomerID = c.CustomerID
JOIN
    Person.Person AS p ON c.PersonID = p.BusinessEntityID
WHERE
    p.FirstName = 'Gustavo' 
    AND p.LastName = 'Achong';






