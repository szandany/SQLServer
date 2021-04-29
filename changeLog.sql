--liquibase formatted sql 

--changeset SteveZ:createTable_salesTableZ context:"DEV" labels:"staging,hotfix"
CREATE TABLE salesTableZ (
   ID int NOT NULL,
   NAME varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
   REGION varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
   MARKET varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
--rollback DROP TABLE salesTableZ

--changeset SteveZ:insertInto_salesTableZ context:"DEV" labels:"staging,hotfix"
INSERT INTO salesTableZ (ID, NAME, REGION, MARKET)
VALUES
(0, 'AXV', 'NA', 'LMP'),
(1, 'MKL', 'SA', 'LMP'),
(2, 'POK', 'LA', 'LLA'),
(3, 'DER', 'CA', 'PRA'),
(4, 'BFV', 'PA', 'LMP'),
(5, 'SAW', 'AA', 'LMP'),
(6, 'JUF', 'NY', 'LMP')
--rollback DELETE FROM salesTableZ WHERE ID=0
 
--changeset SteveZ:createTable_CustomerInfo context:"DEV" labels:"staging,hotfix"
CREATE TABLE CustomerInfo (CustomerTypeID nchar(10) NOT NULL, CustomerDesc nvarchar(MAX))
--rollback DROP TABLE CustomerInfo
 
--changeset Martha:addPrimaryKey_pk_CustomerTypeID context="PROD" labels="staging,hotfix"
ALTER TABLE CustomerInfo ADD CONSTRAINT pk_CustomerTypeID PRIMARY KEY (CustomerTypeID)
--rollback ALTER TABLE CustomerInfo DROP CONSTRAINT pk_CustomerTypeID
 
--changeset Amy:CustomerInfo_ADD_address context:"QA" labels:"staging,hotfix"
ALTER TABLE CustomerInfo ADD address varchar(255)
--rollback ALTER TABLE CustomerInfo DROP COLUMN address
 
--changeset Mike:CREATE_PROCEDURE_[dbo].[CustOrderHist1] context:"DEV" labels:"staging,hotfix"
CREATE PROCEDURE [dbo].[CustOrderHist1] @CustomerID nchar(5)
AS
SELECT ProductName, Total=SUM(Quantity)
FROM Products P, [Order Details] OD, Orders O, Customers C
WHERE C.CustomerID = @CustomerID
AND C.CustomerID = O.CustomerID AND O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID
GROUP BY ProductName;
--rollback DROP PROCEDURE [dbo].[CustOrderHist1];
 
--changeset Mike:CREATE_PROCEDURE_[dbo].[CustOrderHist2] context="DEV" labels="staging,hotfix"
CREATE PROCEDURE [dbo].[CustOrderHist2] @CustomerID nchar(5)
AS
SELECT ProductName, Total=SUM(Quantity)
FROM Products P, [Order Details] OD, Orders O, Customers C
WHERE C.CustomerID = @CustomerID
AND C.CustomerID = O.CustomerID AND O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID
GROUP BY ProductName;
--rollback DROP PROCEDURE [dbo].[CustOrderHist2];
 
--changeset Kevin:ALTER_PROCEDURE_[dbo].[CustOrderHist2] context="QA" labels="staging,hotfix" runOnChange:true
ALTER PROCEDURE [dbo].[CustOrderHist2] @CustomerID nchar(5)
AS
SELECT ProductName, Total=SUM(Quantity) + 1
FROM Products P, [Order Details] OD, Orders O, Customers C
WHERE C.CustomerID = @CustomerID
AND C.CustomerID = O.CustomerID AND O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID
GROUP BY ProductName;
--rollback ALTER PROCEDURE [dbo].[CustOrderHist2] @CustomerID nchar(5) AS SELECT ProductName, Total=SUM(Quantity) FROM Products P, [Order Details] OD, Orders O, Customers C WHERE C.CustomerID = @CustomerID AND C.CustomerID = O.CustomerID AND O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID GROUP BY ProductName;
