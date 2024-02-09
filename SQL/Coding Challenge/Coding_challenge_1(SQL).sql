Create database CodingChallenge;
use CodingChallenge;

-- for over and partition by clause 

Create Table Orders (
    orderid Int PRIMARY KEY,
    Orderdate DATE,
    CustomerName Varchar(100),
    Customercity Varchar(100), 
    Orderamount Decimal(10,2)
);

-- inserting sample data in the orders table

insert into Orders (orderid,Orderdate,CustomerName,Customercity,Orderamount)
VALUES(1, '2024-01-01', 'Customer1', 'CityA', 100.00),
    (2, '2024-01-02', 'Customer2', 'CityB', 150.50),
    (3, '2024-01-03', 'Customer3', 'CityA', 200.25),
    (4, '2024-01-04', 'Customer4', 'CityC', 120.75),
    (5, '2024-01-05', 'Customer5', 'CityB', 180.00),
    (6, '2024-01-06', 'Customer6', 'CityA', 220.50),
    (7, '2024-01-07', 'Customer7', 'CityC', 130.00),
    (8, '2024-01-08', 'Customer8', 'CityB', 90.25),
    (9, '2024-01-09', 'Customer9', 'CityA', 110.75),
    (10, '2024-01-10', 'Customer10', 'CityC', 160.00);
    
-- OVER and PARTITION BY clause
Select orderid,Orderdate,CustomerName,Customercity,Orderamount,
    SUM(Orderamount) OVER (PARTITION BY Customercity ORDER BY Orderdate) AS TotalOrderAmountByCity
From Orders;

-- subtotal aggregations
Select Customercity, SUM(Orderamount) AS SubtotalOrderAmount
From Orders
GROUP BY Customercity;

-- total aggregations
SELECT Customercity, SUM(Orderamount) AS SubtotalOrderAmount
FROM Orders
GROUP BY Customercity
WITH ROLLUP;


-- implementing joins
-- Customer table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Customercity VARCHAR(100)
);

-- insertng data in Customers table
INSERT INTO Customers VALUES
    (1, 'Customer1', 'CityA'),
    (2, 'Customer2', 'CityB'),
    (3, 'Customer3', 'CityA'),
    (4, 'Customer4', 'CityC'),
    (5, 'Customer5', 'CityB');
    
    
-- Order_details table
CREATE TABLE Order_details (
    OrderID INT PRIMARY KEY,
    Orderdate DATE,
    CustomerID INT,
    Orderamount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
-- inserting data in Order_details table
INSERT INTO Order_details VALUES
    (1, '2024-01-01', 1, 100.00),
    (2, '2024-01-02', 2, 150.50),
    (3, '2024-01-03', 1, 200.25),
    (4, '2024-01-04', 3, 120.75),
    (5, '2024-01-05', 2, 180.00),
    (6, '2024-01-06', 1, 220.50),
    (7, '2024-01-07', 4, 130.00),
    (8, '2024-01-08', 2, 90.25),
    (9, '2024-01-09', 3, 110.75),
    (10, '2024-01-10', 4, 160.00);


-- inner join
SELECT Customers.CustomerID, Customers.CustomerName,
    Order_details.OrderID, Order_details.Orderdate
FROM Customers
INNER JOIN Order_details ON Customers.CustomerID = Order_details.CustomerID;


-- left join
SELECT Customers.CustomerID, Customers.CustomerName,
    Order_details.OrderID,Order_details.Orderdate
FROM Customers
LEFT JOIN Order_details ON Customers.CustomerID = Order_details.CustomerID;


-- right join
SELECT Customers.CustomerID, Customers.CustomerName,
    Order_details.OrderID, Order_details.Orderdate
FROM Customers
RIGHT JOIN Order_details ON Customers.CustomerID = Order_details.CustomerID;


-- full outer join
SELECT Customers.CustomerID,Customers.CustomerName,
    Order_details.OrderID,Order_details.Orderdate
FROM Customers
LEFT JOIN Order_details ON Customers.CustomerID = Order_details.CustomerID

UNION

SELECT Customers.CustomerID, Customers.CustomerName,
    Order_details.OrderID, Order_details.Orderdate
FROM Customers
RIGHT JOIN Order_details ON Customers.CustomerID = Order_details.CustomerID
WHERE Customers.CustomerID IS NULL;

-- cross join
SELECT Customers.CustomerID, Customers.CustomerName, Customers.Customercity,
    Order_details.OrderID, Order_details.Orderdate, Order_details.Orderamount
FROM Customers
CROSS JOIN Order_details;






