USE AdventureWorks2019;

--If User wants to check the data for Employee from Employee table whose department is IT and HR.

Select * from HumanResources.Department;

select * FROM HumanResources.Employee;


select * FROM HumanResources.EmployeeDepartmentHistory;

SELECT pp.FirstName, pp.LastName, e.JobTitle, d.Name AS Department
FROM [HumanResources].[Employee] e
JOIN [Person].[Person] pp ON e.BusinessEntityID = pp.BusinessEntityID
JOIN [HumanResources].[EmployeeDepartmentHistory] edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN [HumanResources].[Department] d ON edh.DepartmentID = d.DepartmentID
WHERE d.Name IN ('Human Resources', 'Information Services');

-- If the departement column is not present in Employee table and it is present is Department table.

--The joining condition will be Dept_id.User need to find out the data for Employees whose associated department is 'IT' or 'HR'.

SELECT e.BusinessEntityID, pp.FirstName, pp.LastName, d.Name AS Department
FROM [HumanResources].[Employee] e
JOIN [Person].[Person] pp ON e.BusinessEntityID = pp.BusinessEntityID
JOIN [HumanResources].[EmployeeDepartmentHistory] edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN [HumanResources].[Department] d ON edh.DepartmentID = d.DepartmentID
WHERE d.Name IN ('Information Services', 'Human Resources');

--If user wants to fetch data for Employees whose department is 'IT' and Salary is greater than 30.


SELECT pp.FirstName, pp.LastName, d.Name AS Department, eph.Rate
FROM [HumanResources].[Employee] e
JOIN [Person].[Person] pp ON e.BusinessEntityID = pp.BusinessEntityID
JOIN [HumanResources].[EmployeeDepartmentHistory] edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN [HumanResources].[Department] d ON edh.DepartmentID = d.DepartmentID
JOIN [HumanResources].[EmployeePayHistory] eph ON e.BusinessEntityID = eph.BusinessEntityID
WHERE d.Name = 'Information Services' AND eph.Rate > 30;


select * FROM HumanResources.EmployeePayHistory;


--If user wants to fetch data for Employees whose name Starts with 'A'? 

SELECT * 
FROM [Person].[Person]
WHERE FirstName LIKE 'A%';

--If user wants to count the number of employees whose department is 'IT' and salary is greater than 30000.

SELECT COUNT(e.BusinessEntityID) AS TotalEmployees
FROM [HumanResources].[Employee] e
JOIN [HumanResources].[EmployeePayHistory] eph ON e.BusinessEntityID = eph.BusinessEntityID
JOIN [HumanResources].[EmployeeDepartmentHistory] edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN [HumanResources].[Department] d ON edh.DepartmentID = d.DepartmentID
WHERE d.Name = 'Information Services' AND eph.Rate > 30000;


SELECT * FROM [Person].[Person]

--If user wants to calculate Employess with its department.

SELECT d.Name, COUNT(e.BusinessEntityID) AS TotalEmployees
FROM [HumanResources].[Employee] e
JOIN [HumanResources].[EmployeeDepartmentHistory] edh 
    ON e.BusinessEntityID = edh.BusinessEntityID
JOIN [HumanResources].[Department] d 
    ON edh.DepartmentID = d.DepartmentID
GROUP BY d.Name;

--If user wants to calculate Employees with its department  which is order by descending order.

SELECT d.Name, COUNT(e.BusinessEntityID) AS TotalEmployees
FROM [HumanResources].[Employee] e
JOIN [HumanResources].[EmployeeDepartmentHistory] edh 
    ON e.BusinessEntityID = edh.BusinessEntityID
JOIN [HumanResources].[Department] d 
    ON edh.DepartmentID = d.DepartmentID
GROUP BY d.Name
ORDER BY TotalEmployees DESC;


-- ASC
SELECT d.Name, COUNT(e.BusinessEntityID) AS TotalEmployees
FROM [HumanResources].[Employee] e
JOIN [HumanResources].[EmployeeDepartmentHistory] edh 
    ON e.BusinessEntityID = edh.BusinessEntityID
JOIN [HumanResources].[Department] d 
    ON edh.DepartmentID = d.DepartmentID
GROUP BY d.Name
ORDER BY TotalEmployees ASC;


--If user wants to fetch the name of distinct department from Department table.

SELECT DISTINCT d.Name
FROM [HumanResources].[Department] d
ORDER BY d.Name ASC	 ;

--If user wants to fetch the employee data from employee table where department names are IT and Finance.

SELECT pp.FirstName, d.Name
FROM [Person].[Person] pp
JOIN [HumanResources].[EmployeeDepartmentHistory] edh 
    ON pp.BusinessEntityID = edh.BusinessEntityID
JOIN [HumanResources].[Department] d 
    ON edh.DepartmentID = d.DepartmentID
WHERE d.Name IN ('Information Services', 'Finance');

--If Employee salary is greater than 30000 the Employee will be High Salaried else it is regular pay

SELECT ep.*, 
    CASE 
        WHEN ep.Rate > 30 THEN 'High Salaried' 
        ELSE 'Regular Pay' 
    END AS SalaryClassification
FROM [HumanResources].[EmployeePayHistory] ep;



