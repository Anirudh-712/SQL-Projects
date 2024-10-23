CREATE DATABASE employee_infoDB;

USE employee_infoDB;

CREATE TABLE LOCATION(
   Location_ID INT PRIMARY KEY,
   City VARCHAR(100)
   );

   INSERT INTO LOCATION (Location_ID, City)
VALUES
(122, 'New York'),
(123, 'Dallas'),
(124, 'Chicago'),
(167, 'Boston');

CREATE TABLE department(
   Department_ID INT PRIMARY KEY,
   Name VARCHAR(100),
   Location_ID INT,
   FOREIGN KEY (Location_ID) REFERENCES LOCATION(Location_ID)
   );

   INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES
(10, 'Accounting', 122),
(20, 'Sales', 124),
(30, 'Research', 123),
(40, 'Operations', 167);

CREATE TABLE JOB(
   Job_ID INT PRIMARY KEY,
   Designation VARCHAR(100)
   );

   INSERT INTO JOB (Job_ID, Designation)
VALUES
(667, 'Clerk'),
(668, 'Staff'),
(669, 'Analyst'),
(670, 'Sales Person'),
(671, 'Manager'),
(672, 'President');

CREATE TABLE EMPLOYEE(
   Employee_Id INT PRIMARY KEY,   Last_name VARCHAR(100),   First_name VARCHAR(100),   Middle_name VARCHAR(100),   Job_ID INT,   Hire_date DATE,   Salary DECIMAL(10, 2),
   Commission DECIMAL(10, 2),
   Department_Id INT,   FOREIGN KEY (Job_ID) REFERENCES JOB(Job_ID),   FOREIGN KEY (Department_Id) REFERENCES DEPARTMENT(Department_Id),   );   INSERT INTO EMPLOYEE (Employee_Id, Last_Name, First_Name, Middle_Name, Job_Id, Hire_Date, Salary, Commission, Department_Id)
VALUES
(7369, 'Smith', 'John', 'Q', 667, '1984-12-17', 800, NULL, 20),
(7499, 'Allen', 'Kevin', 'J', 670, '1985-02-20', 1600, 300, 30),
(755, 'Doyle', 'Jean', 'K', 671, '1985-04-04', 2850, NULL, 30),
(756, 'Dennis', 'Lynn', 'S', 671, '1985-05-15', 2750, NULL, 30),
(757, 'Baker', 'Leslie', 'D', 671, '1985-06-10', 2200, NULL, 40),
(7521, 'Wark', 'Cynthia', 'D', 670, '1985-02-22', 1250, 50, 30);

--Simple Queries:
--1. List all the employee details.
--2. List all the department details.
--3. List all job details.
--4. List all the locations.
--5. List out the First Name, Last Name, Salary, Commission for all Employees.
--6. List out the Employee ID, Last Name, Department ID for all employees and
--alias
--Employee ID as "ID of the Employee", Last Name as "Name of the
--Employee", Department ID as "Dep_id".
--7. List out the annual salary of the employees with their names only.SELECT * FROM EMPLOYEE;                     -- List all the employee details.
SELECT * FROM DEPARTMENT;                    --List all the department details
SELECT * FROM JOB;                            -- List all job details.
SELECT * FROM LOCATION;                        --List all the locations.

SELECT First_name, Last_name, Salary, Commission FROM EMPLOYEE; -- List out the First Name, Last Name, Salary, Commission for all Employees.

 SELECT 
    Employee_ID AS E_ID , 
    Last_name AS LN,
    Department_Id AS D_ID
 FROM EMPLOYEE;                 --List out the Employee ID, Last Name, Department ID for all employees and alias


 SELECT
    First_name,
    Last_name,
    (Salary*12) AS Annual_salary
FROM EMPLOYEE;                   --List the annual salary of the employees with their names


-- WHERE CONDITION 

SELECT * FROM EMPLOYEE
   WHERE Last_name= 'SMITH';       --List details about "Smith"


SELECT * FROM EMPLOYEE
   WHERE Department_ID= 20;               --List out the employees who are working in department 20



SELECT * FROM EMPLOYEE
   WHERE Salary BETWEEN 2000 AND 3000 ;      -- List out the employees who are earning salary between 2000 and 3000


SELECT * FROM EMPLOYEE
   WHERE Department_ID IN (10,20);       -- List out the employees who are working in department 10 or 20.



SELECT * FROM EMPLOYEE
   WHERE Department_ID NOT IN (10,30);     --Find out the employees who are not working in department 10 or 30.



   SELECT * FROM EMPLOYEE
   WHERE First_name LIKE 'L%%';           -- List out the employees whose name starts with 'L'.




   SELECT * FROM EMPLOYEE
   WHERE First_name LIKE 'L%E';        -- List out the employees whose name starts with 'L' and ends with 'E'.   SELECT * FROM EMPLOYEE
   WHERE LEN(First_name)=4 AND First_name LIKE 'j%';     --List out the employees whose name length is 4 and start with 'J'.



   SELECT * FROM EMPLOYEE
   WHERE Salary > 2500 AND Department_Id= 30;               --List out the employees who are working in department 30 and draw the salaries more than 2500.   SELECT * FROM EMPLOYEE
   WHERE Commission IS NULL;              --    List out the employees who are not receiving commission.   --- order by clauseSELECT  Employee_ID, Last_name from EMPLOYEE     ORDER BY Employee_Id ASC ;                      -- List out the Employee ID and Last Name in ascending order based on the Employee ID.	SELECT  Employee_ID, First_name, Last_name, Salary from EMPLOYEE     ORDER BY Salary DESC;                                                   -- List out the Employee ID and Name in descending order based on salary.	SELECT * FROM EMPLOYEE	   ORDER BY Last_name ASC;                                              --  List out the employee details according to their Last Name in ascending-order.	   SELECT * FROM EMPLOYEE	   ORDER BY Last_name ASC , Department_Id DESC;                               -- List out the employee details according to their Last Name in ascending order and then Department ID in descending order.	   --GROUP BY and HAVING Clause--SELECT department_ID,   MAX(Salary) AS max_salary,                                               -- List out the department wise maximum salary, minimum salary and average salary of the employees.   MIN(salary) AS min_salary,   AVG(salary) AS avg_salary   FROM Employee   GROUP BY Department_Id;   SELECT Job_ID,   MAX(Salary) AS max_salary,                                               -- List out the job wise maximum salary, minimum salary and average salary of the employees.   MIN(salary) AS min_salary,   AVG(salary) AS avg_salary   FROM Employee   GROUP BY Job_ID; SELECT MONTH(Hire_Date) AS Month, 
       COUNT(Employee_Id) AS Employee_Count 
FROM EMPLOYEE                                                 --List out the number of employees who joined each month in ascending order
GROUP BY MONTH(Hire_Date) 
ORDER BY Month ASC;
   --SELECT Employee_Id,Hire_Date,Job_ID     -- FROM EMPLOYEE;	 SELECT YEAR(Hire_Date) AS Year,
	 MONTH(Hire_Date) AS Month, 
       COUNT(Employee_Id) AS Employee_Count                          --List out the number of employees for each month and year in ascending order based on the year and month
FROM EMPLOYEE                                                 
GROUP BY YEAR(Hire_Date),MONTH(Hire_Date) 
ORDER BY Month ASC;


SELECT Department_Id, COUNT(Employee_Id) AS Employee_Count 
FROM EMPLOYEE                                                                --List out the Department ID having at least four employees.
GROUP BY Department_Id 
HAVING COUNT(Employee_Id) >= 4;                         


SELECT COUNT(Employee_Id) AS Employee_Count 
FROM EMPLOYEE                                                                --How many employees joined in February month.
WHERE MONTH(Hire_date)=2;


SELECT COUNT(Employee_Id) AS Employee_Count 
FROM EMPLOYEE                                                                --How many employees joined in May or June month
WHERE MONTH(Hire_date)=5 OR MONTH(Hire_date)=6


SELECT COUNT(Employee_Id) AS Employee_Count 
FROM EMPLOYEE                                                                --How many employees joined in the year 1985
WHERE YEAR(Hire_date)=1985;


SELECT MONTH(Hire_Date) AS Month, 
       COUNT(Employee_Id) AS Employee_Count                          --How many employees joined each month in 1985?
FROM EMPLOYEE    
WHERE YEAR(Hire_date)= 1985
GROUP BY MONTH(Hire_date);


SELECT  COUNT(Employee_Id) AS Employee_Count                          --How many employees joined each month in 1985?
FROM EMPLOYEE    
WHERE YEAR(Hire_date)= 1985
AND MONTH(Hire_date)= 4;


SELECT  Department_Id                         --Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
FROM EMPLOYEE    
WHERE YEAR(Hire_date)= 1985
AND MONTH(Hire_date)= 4
GROUP BY Department_Id
HAVING COUNT(Employee_Id) >= 1;