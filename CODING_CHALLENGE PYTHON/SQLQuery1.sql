CREATE TABLE Users (
  userId INT PRIMARY KEY,
  username NVARCHAR(50) UNIQUE NOT NULL,
  password NVARCHAR(100) NOT NULL,
  role NVARCHAR(10) NOT NULL
);

CREATE TABLE Product (
  productId INT PRIMARY KEY,
  productName NVARCHAR(100),
  description NVARCHAR(255),
  price DECIMAL(10,2),
  quantityInStock INT,
  type NVARCHAR(20)  -- "Electronics" or "Clothing"
);

CREATE TABLE Electronics (
  productId INT PRIMARY KEY FOREIGN KEY REFERENCES Product(productId),
  brand NVARCHAR(50),
  warrantyPeriod INT
);

CREATE TABLE Clothing (
  productId INT PRIMARY KEY FOREIGN KEY REFERENCES Product(productId),
  size NVARCHAR(10),
  color NVARCHAR(20)
);

CREATE TABLE [Order] (
  orderId INT PRIMARY KEY IDENTITY(1,1),
  userId INT FOREIGN KEY REFERENCES Users(userId), -- ✅ Correct table reference
  orderDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE OrderDetails (
  orderDetailId INT PRIMARY KEY IDENTITY(1,1),
  orderId INT FOREIGN KEY REFERENCES [Order](orderId),
  productId INT FOREIGN KEY REFERENCES Product(productId),
  quantity INT
);


SELECT * FROM [Order];
