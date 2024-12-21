-- Database Creation 
CREATE DATABASE BookstoreDB;
USE BookstoreDB;

-- Table Creation 
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    AuthorID INT,
    CategoryID INT,
    Price DECIMAL(10, 2),
    StockQuantity INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    OrderDate DATE NOT NULL
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    BookID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Insert Sample Data into Tables

INSERT INTO Authors (AuthorID, AuthorName)
VALUES
(1, 'Chetan Bhagat'),
(2, 'Ruskin Bond'),
(3, 'R.K. Narayan'),
(4, 'Arundhati Roy'),
(5, 'Vikram Seth');

INSERT INTO Categories (CategoryID, CategoryName)
VALUES
(1, 'Romance'),
(2, 'Adventure'),
(3, 'Literature'),
(4, 'Historical Fiction'),
(5, 'Poetry');

INSERT INTO Books (BookID, Title, AuthorID, CategoryID, Price, StockQuantity)
VALUES
(1, 'Five Point Someone', 1, 1, 299.99, 150),
(2, 'The Blue Umbrella', 2, 2, 199.99, 120),
(3, 'Malgudi Days', 3, 3, 249.99, 100),
(4, 'The God of Small Things', 4, 4, 399.99, 80),
(5, 'A Suitable Boy', 5, 5, 599.99, 50),
(6, 'Revolution 2020', 1, 1, 249.99, 180),
(7, 'Tales of the Unexpected', 2, 2, 219.99, 110),
(8, 'The Guide', 3, 3, 299.99, 140),
(9, 'The Ministry of Utmost Happiness', 4, 4, 499.99, 70),
(10, 'Mappings', 5, 5, 349.99, 90);

INSERT INTO Orders (OrderID, CustomerName, OrderDate)
VALUES
(1, 'Amit Kumar', '2024-12-15'),
(2, 'Priya Sharma', '2024-12-16'),
(3, 'Rajesh Mehta', '2024-12-17');

INSERT INTO OrderDetails (OrderDetailID, OrderID, BookID, Quantity)
VALUES
(1, 1, 1, 2),  
(2, 1, 5, 1),  
(3, 2, 3, 3),  
(4, 2, 7, 1),  
(5, 3, 10, 2), 
(6, 3, 8, 1),  
(7, 2, 4, 1),  
(8, 1, 9, 2),  
(9, 2, 6, 1),  
(10, 3, 2, 1); 

-- Querying and Analysis Scripts

-- Basic Queries

-- Retrieve all books along with their authors and categories

SELECT 
    b.BookID,
    b.Title AS BookTitle,
    a.AuthorName,
    c.CategoryName,
    b.Price,
    b.StockQuantity
FROM 
    Books b
JOIN 
    Authors a ON b.AuthorID = a.AuthorID
JOIN 
    Categories c ON b.CategoryID = c.CategoryID;

-- Find books that are out of stock (StockQuantity = 0)

SELECT 
    BookID, 
    Title AS BookTitle, 
    AuthorID, 
    CategoryID, 
    Price
FROM 
    Books
WHERE 
    StockQuantity = 0;

-- Aggregate Functions

-- Find the total revenue generated from all orders.

SELECT 
    SUM(b.Price * od.Quantity) AS TotalRevenue
FROM 
    OrderDetails od
JOIN 
    Books b ON od.BookID = b.BookID;

-- Get the number of books available in each category. 

SELECT 
    c.CategoryName, 
    SUM(b.StockQuantity) AS TotalBooksAvailable
FROM 
    Books b
JOIN 
    Categories c ON b.CategoryID = c.CategoryID
GROUP BY 
    c.CategoryName;

-- Joins

-- List all orders along with the customer name, order date, book titles, and quantity ordered

SELECT 
    o.OrderID,
    o.CustomerName,
    o.OrderDate,
    b.Title AS BookTitle,
    od.Quantity
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Books b ON od.BookID = b.BookID;

-- Subqueries

-- Find the most expensive book in the Poetry category

SELECT TOP 1 
    b.Title AS BookTitle, 
    b.Price
FROM 
    Books b
WHERE 
    b.CategoryID = (SELECT CategoryID FROM Categories WHERE CategoryName = 'Poetry')
ORDER BY 
    b.Price DESC;

-- List customers who have ordered more than 5 books in a single order

SELECT 
    o.CustomerName,
    o.OrderID,
    SUM(od.Quantity) AS TotalBooksOrdered
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
GROUP BY 
    o.CustomerName, o.OrderID
HAVING 
    SUM(od.Quantity) > 5;

--Advanced Queries
-- Identify authors whose books have generated revenue exceeding $500.

SELECT 
    a.AuthorName,
    SUM(b.Price * od.Quantity) AS TotalRevenue
FROM 
    Authors a
JOIN 
    Books b ON a.AuthorID = b.AuthorID
JOIN 
    OrderDetails od ON b.BookID = od.BookID
GROUP BY 
    a.AuthorName
HAVING 
    SUM(b.Price * od.Quantity) > 500;

-- Calculate the stock value (price	stock quantity) of all books and list the top 3 books by stock value

SELECT TOP 3
    b.Title AS BookTitle,
    b.Price,
    b.StockQuantity,
    (b.Price * b.StockQuantity) AS StockValue
FROM 
    Books b
ORDER BY 
    StockValue DESC;

-- Stored Procedures

-- Write a stored procedure GetBooksByAuthor that accepts an AuthorlD as input and returns all books by that author

CREATE PROCEDURE GetBooksByAuthor 
    @AuthorID INT
AS
BEGIN
    SELECT 
        b.BookID,
        b.Title AS BookTitle,
        b.Price,
        b.StockQuantity
    FROM 
        Books b
    WHERE 
        b.AuthorID = @AuthorID;
END;

EXEC GetBooksByAuthor @AuthorID = 1;

-- Views

-- Create a view TopSellingBooks that lists the top 5 books based on total quantity sold

CREATE VIEW TopSellingBooks AS
SELECT TOP 5
    b.BookID,
    b.Title AS BookTitle,
    SUM(od.Quantity) AS TotalQuantitySold
FROM 
    Books b
JOIN 
    OrderDetails od ON b.BookID = od.BookID
GROUP BY 
    b.BookID, b.Title
ORDER BY 
    TotalQuantitySold DESC;

SELECT * FROM TopSellingBooks;

-- Indexes

-- Create an index on the Books table for the Title column to optimize search performance

CREATE INDEX IDX_Books_Title
ON Books (Title);

SELECT * 
FROM sys.indexes
WHERE object_id = OBJECT_ID('Books');




