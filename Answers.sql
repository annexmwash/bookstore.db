/* creating database Bookstoredb*/
create database Bookstoredb;
/* creating authors table*/
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Bio TEXT
);
/*creating books table*/
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT,
    ISBN VARCHAR(13) UNIQUE,
    Genre VARCHAR(100),
    Price DECIMAL(10, 2),
    Stock INT,
    PublishedDate DATE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);
/* creating customers table*/
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
/* creating orders table*/
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50),
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
/* ceating orders item table*/
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    BookID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
/* creating shipping table*/
CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ShippedDate DATE,
    DeliveryDate DATE,
    ShippingAddress TEXT,
    Carrier VARCHAR(100),
    TrackingNumber VARCHAR(100),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
/* creating inventory table*/
CREATE TABLE Inventory (
    BookID INT PRIMARY KEY,
    Stock INT NOT NULL DEFAULT 0,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
    );
    /* creating users*/
CREATE USER 'alice'@'localhost' identified by 'admin_password';
CREATE USER 'bob'@'localhost' IDENTIFIED BY 'manager_password';
CREATE USER 'charlie'@'localhost' IDENTIFIED BY 'sales_password';
CREATE USER 'diana'@'localhost' IDENTIFIED BY 'readonly_password';
/*creating roles for each user*/
CREATE ROLE admin;
CREATE ROLE manager;
CREATE ROLE sales;
CREATE ROLE readonly;
/* Grant privilages to roles*/
GRANT ALL PRIVILEGES ON *.* TO 'admin'WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore.* TO 'manager';
GRANT SELECT, INSERT ON books TO 'sales';
GRANT SELECT ON bookstore.* TO 'readonly';
/* testing data*/
-- Authors
INSERT INTO Authors (FirstName, LastName, Bio) VALUES
('George', 'Orwell', 'Author of 1984 and Animal Farm.'),
('Jane', 'Austen', 'Author of Pride and Prejudice.');

-- Genres
INSERT INTO Genres (GenreName) VALUES
('Dystopian'), ('Classic'), ('Romance');

-- Books
INSERT INTO Books (Title, AuthorID, GenreID, ISBN, PublishedDate, Price) VALUES
('1984', 1, 1, '9780451524935', '1949-06-08', 9.99),
('Animal Farm', 1, 1, '9780451526342', '1945-08-17', 7.99),
('Pride and Prejudice', 2, 3, '9781503290563', '1813-01-28', 10.99);

-- Inventory
INSERT INTO Inventory (BookID, Stock) VALUES
(1, 10),
(2, 5),
(3, 7);

-- Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('Alice', 'Smith', 'alice@example.com', '123-456-7890', '123 Elm St'),
('Bob', 'Johnson', 'bob@example.com', '234-567-8901', '456 Oak St');

-- Orders
INSERT INTO Orders (CustomerID, OrderDate, Status, TotalAmount) VALUES
(1, '2025-04-10', 'Shipped', 17.98),
(2, '2025-04-11', 'Processing', 10.99);

-- OrderItems
INSERT INTO OrderItems (OrderID, BookID, Quantity, Price) VALUES
(1, 1, 1, 9.99),
(1, 2, 1, 7.99),
(2, 3, 1, 10.99);

-- Shipping
INSERT INTO Shipping (OrderID, ShippedDate, DeliveryDate, ShippingAddress, Carrier, TrackingNumber) VALUES
(1, '2025-04-11', '2025-04-13', '123 Elm St', 'UPS', '1Z123ABC');


/*test query */
SELECT b.Title, a.FirstName || ' ' || a.LastName AS Author, b.Genre, b.Price
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID;
