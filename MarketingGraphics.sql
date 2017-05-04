/*
	==============
	Alex Mullins
	CIS-324 
	Final Project
	==============
*/
PRINT 'Creating MarketingGraphics...'

SET NOCOUNT ON

/*
	===============
	Create Database
	===============
*/
CREATE DATABASE MarketingGraphics
GO

USE MarketingGraphics 
GO

PRINT 'Created database MarketingGraphics.'
GO

/*
	=============
	Create tables
	=============
*/
CREATE TABLE tblCustomers
(
	CustomerID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL,
	Address NVARCHAR(100) NOT NULL,
	BuildingNo NVARCHAR(100) NOT NULL,
	City NVARCHAR(100) NOT NULL,
	State NVARCHAR(100) NOT NULL,
	Zip NVARCHAR(5) NOT NULL,
)
GO

CREATE TABLE tblSalesPersons
(
	SalesPersonID INT IDENTITY(1,1) PRIMARY KEY,
	FirstName NVARCHAR(100) NOT NULL,
	LastName NVARCHAR(100) NOT NULL,
)
GO

CREATE TABLE tblItems
(
	ItemID INT IDENTITY(1,1) PRIMARY KEY,
	UnitPrice MONEY NOT NULL,
	Description NVARCHAR(100) NOT NULL,
)
GO

CREATE TABLE tblInvoices
(
	InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
	SalesPerson INT NOT NULL,
	Customer INT NOT NULL,
	Date DATE NOT NULL,
	ShipDate DATE NOT NULL,
	SubTotal MONEY NOT NULL,
	Tax MONEY NOT NULL,
	ShippingCost MONEY NOT NULL,
	Total MONEY NOT NULL,
	Terms NVARCHAR(100) NOT NULL,
)
GO

CREATE TABLE tblInvoiceLineItems
(
	LineItemID INT IDENTITY(1,1) PRIMARY KEY,
	Invoice INT NOT NULL,
	Item INT NOT NULL,
	Quantity INT NOT NULL,
	UnitPrice MONEY NOT NULL,
	ExtendedPrice MONEY NOT NULL,
)
GO

PRINT 'Created tables for MarketingGraphics database.'
GO

/*
	=========================
	Create table constraints.
	=========================
*/ 
ALTER TABLE tblInvoices
ADD CONSTRAINT Customer_ID_fk FOREIGN KEY (Customer)
REFERENCES tblCustomers(CustomerID)
GO

ALTER TABLE tblInvoices
ADD CONSTRAINT SalesPerson_ID_fk FOREIGN KEY (SalesPerson)
REFERENCES tblSalesPersons(SalesPersonID)
GO

ALTER TABLE tblInvoiceLineItems
ADD CONSTRAINT Invoice_ID_fk FOREIGN KEY (Invoice)
REFERENCES tblInvoices(InvoiceID)
GO

ALTER TABLE tblInvoiceLineItems
ADD CONSTRAINT Item_ID_fk FOREIGN KEY (Item)
REFERENCES tblItems(ItemID)
GO

PRINT 'Created table constraints for MarketingGraphics database.'

/*
	==================
	Create dummy data.
	==================
*/
--Insert Customers
INSERT INTO tblCustomers (Name, Address, BuildingNo, City, State, Zip)
VALUES 
('Bobs Burgers', '222 Burger Drive', '1a', 'Mobile', 'AL', 36695),
('Teds Hotdogs', '333 Hotdog Lane', '2b', 'Foley', 'AL', 36535),
('Mamas Meatballs', '444 Meatball Ave', '3c', 'Mobile', 'AL', 36636)
GO

--Insert SalesPersons
INSERT INTO tblSalesPersons (FirstName,	LastName)
VALUES
('Alex', 'Mullins'),
('Trey', 'Mullins'),
('Whitney', 'Bishop')
GO

--Insert Items
INSERT INTO tblItems (UnitPrice, Description)
VALUES
(12.99, 'Nice Picture'),
(13.99, 'Nicer Picture'),
(15.99, 'Best Picture')
GO

--Insert Invoices
Declare @CustomerID_1 INT
SET @CustomerID_1 = (SELECT CustomerID from tblCustomers WHERE CustomerID = 1)

Declare @CustomerID_2 INT
SET @CustomerID_2 = (SELECT CustomerID from tblCustomers WHERE CustomerID = 2)

Declare @CustomerID_3 INT
SET @CustomerID_3 = (SELECT CustomerID from tblCustomers WHERE CustomerID = 3)

Declare @SalesPersonID_1 INT
SET @SalesPersonID_1 = (SELECT SalesPersonID from tblSalesPersons WHERE SalesPersonID = 1)

Declare @SalesPersonID_2 INT
SET @SalesPersonID_2 = (SELECT SalesPersonID from tblSalesPersons WHERE SalesPersonID = 2)

Declare @SalesPersonID_3 INT
SET @SalesPersonID_3 = (SELECT SalesPersonID from tblSalesPersons WHERE SalesPersonID = 3)

INSERT INTO tblInvoices (SalesPerson, Customer, Date, ShipDate, SubTotal, Tax, ShippingCost, Total, Terms)
VALUES
(@SalesPersonID_1, @CustomerID_1, '2017-04-30', '2017-05-01', 12.99, 0.00, 0.00, 12.99, 'NA'),
(@SalesPersonID_2, @CustomerID_2, '2017-04-29', '2017-05-02', 13.99, 0.00, 0.00, 13.99, 'Fast delivery'),
(@SalesPersonID_3, @CustomerID_3, '2017-04-28', '2017-05-03', 15.99, 0.00, 0.00, 15.99, 'Fastest delivery')
GO

--Insert InvoiceLineItems
Declare @InvoiceID_1 INT
SET @InvoiceID_1 = (SELECT InvoiceID from tblInvoices WHERE InvoiceID = 1)

Declare @InvoiceID_2 INT
SET @InvoiceID_2 = (SELECT InvoiceID from tblInvoices WHERE InvoiceID = 2)

Declare @InvoiceID_3 INT
SET @InvoiceID_3 = (SELECT InvoiceID from tblInvoices WHERE InvoiceID = 3)

Declare @ItemID_1 INT
SET @ItemID_1 = (SELECT ItemID from tblItems WHERE ItemID = 1)

Declare @ItemID_2 INT
SET @ItemID_2 = (SELECT ItemID from tblItems WHERE ItemID = 2)

Declare @ItemID_3 INT
SET @ItemID_3 = (SELECT ItemID from tblItems WHERE ItemID = 3)

INSERT INTO tblInvoiceLineItems (Invoice, Item, Quantity, UnitPrice, ExtendedPrice)
VALUES
(@InvoiceID_1, @ItemID_1, 1, 12.99, 12.99),
(@InvoiceID_2, @ItemID_2, 1, 13.99, 13.99),
(@InvoiceID_3, @ItemID_3, 1, 15.99, 15.99)
GO

PRINT 'Created dummy data for MarketingGraphics database.'

/*
	===========
	Select ROWS
	===========
*/
SELECT * FROM tblCustomers
SELECT * FROM tblSalesPersons
SELECT * FROM tblItems
SELECT * FROM tblInvoices
SELECT * FROM tblInvoiceLineItems
GO

PRINT 'Creating MarketingGraphics database complete.'
