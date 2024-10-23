CREATE DATABASE Hotels_db;

USE Hotels_db;

go

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY IDENTITY(1,1),
    restaurant_name NVARCHAR(255),
    cuisine_type NVARCHAR(255),
    restaurant_type NVARCHAR(255),
    rating FLOAT,
    area NVARCHAR(255),
    table_booking INT
);

go

-- Insert sample data

INSERT INTO Restaurants (restaurant_name, cuisine_type, restaurant_type, rating, area, table_booking)
VALUES 
('Tandoori Mahal', 'Indian', 'Quick Bites', 4.5, 'Uptown', 10),
('Chai Shai', 'Cafe', 'Cafe', 3.9, 'Downtown', 15),
('Biryani House', 'Indian', 'Casual Dining', 4.8, 'Midtown', 20),
('Kebab Junction', 'Indian', 'Quick Bites', 4.2, 'Downtown', 5),
('Saffron Spice', 'Indian', 'Casual Dining', 4.7, 'Suburb', 8),
('Green Leaf', 'Vegan', 'Cafe', 3.3, 'Uptown', 0),
('Masala Twist', 'Indian', 'Fine Dining', 4.6, 'Suburb', 25),
('Grill N Tandoor', 'Indian', 'Casual Dining', 4.1, 'Midtown', 12),
('Naan Express', 'Indian', 'Quick Bites', 3.2, 'Uptown', 7),
('Dosa Delight', 'South Indian', 'Cafe', 4.4, 'Downtown', 0);

go

--Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.

CREATE PROCEDURE GetNonZeroTableBookings
AS
BEGIN
    SELECT restaurant_name, restaurant_type, cuisine_type
    FROM Restaurants
    WHERE table_booking > 0;
END;

GO

--Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it

BEGIN TRANSACTION;

UPDATE Restaurants
SET cuisine_type = 'Cafeteria'
WHERE cuisine_type = 'Cafe';

-- Check the updated records
SELECT restaurant_name, cuisine_type
FROM Restaurants
WHERE cuisine_type = 'Cafeteria';

-- Rollback the transaction
ROLLBACK TRANSACTION;

go

--Generate a row number column and find the top 5 areas with the highest rating of restaurants.

WITH RankedRestaurants AS (
    SELECT area, rating,
           ROW_NUMBER() OVER (ORDER BY rating DESC) AS row_num
    FROM Restaurants
)
SELECT area, rating
FROM RankedRestaurants
WHERE row_num <= 5;

go

--Use a WHILE Loop to Display Numbers from 1 to 50

DECLARE @i INT = 1;

WHILE @i <= 50
BEGIN
    PRINT @i;
    SET @i = @i + 1;
END;

go

--Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants

CREATE VIEW TopRatedRestaurants AS
WITH RankedRestaurants AS (
    SELECT restaurant_name, rating,
           ROW_NUMBER() OVER (ORDER BY rating DESC) AS row_num
    FROM Restaurants
)
SELECT restaurant_name, rating
FROM RankedRestaurants
WHERE row_num <= 5;

go

SELECT name 
FROM sys.views 
WHERE name = 'TopRatedRestaurants';

go

SELECT * 
FROM TopRatedRestaurants;

go

--Create a trigger that give an message whenever a new record is inserted.

CREATE TRIGGER NotifyOnInsert
ON Restaurants
AFTER INSERT
AS
BEGIN
    PRINT 'A new restaurant has been added to the database.';
END;

go

-- Checking the trigger


INSERT INTO Restaurants (restaurant_name, cuisine_type, restaurant_type, rating, area, table_booking)
VALUES ('Spicy Tadka', 'Indian', 'Casual Dining', 4.3, 'City Center', 10);












