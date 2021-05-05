--liquibase formatted sql 

--changeset SteveZ:createTable_salesTableZ context:DEV labels:Jira1000
CREATE TABLE salesTableZ (
   ID int NOT NULL,
   NAME varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
   REGION varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
   MARKET varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
--rollback DROP TABLE salesTableZ
 
--changeset SteveZ:createTable_CustomerInfo context:DEV labels:Jira1001
CREATE TABLE CustomerInfo (CustomerTypeID nchar(10) NOT NULL, CustomerDesc nvarchar(MAX))
--rollback DROP TABLE CustomerInfo
 
--changeset Martha:addPrimaryKey_pk_CustomerTypeID context=PROD labels=Jira1002
ALTER TABLE CustomerInfo ADD CONSTRAINT pk_CustomerTypeID PRIMARY KEY (CustomerTypeID)
--rollback ALTER TABLE CustomerInfo DROP CONSTRAINT pk_CustomerTypeID
 
--changeset Amy:CustomerInfo_ADD_address context:QA labels:Jira1009,1010
ALTER TABLE CustomerInfo ADD address varchar(255)
--rollback ALTER TABLE CustomerInfo DROP COLUMN address
 
