/*
    Creates staging tables for the Bibitor dataset.

    All staging tables store raw source data.
*/

USE BibitorDW;
GO

-- Staging schema holds raw, untransformed source data
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'staging')
    EXEC('CREATE SCHEMA staging');
GO

-- ---------------------------------------------------------------------
-- Drop existing staging tables so this script is re-runnable (idempotent)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS staging.beg_inv;
DROP TABLE IF EXISTS staging.end_inv;
DROP TABLE IF EXISTS staging.purchases;
DROP TABLE IF EXISTS staging.invoice_purchases;
DROP TABLE IF EXISTS staging.sales;
DROP TABLE IF EXISTS staging.purchase_prices;
GO

-- ---------------------------------------------------------------------
-- 1. Beginning inventory snapshot (2016-01-01)
-- ---------------------------------------------------------------------
CREATE TABLE staging.beg_inv (
    InventoryId   VARCHAR(100)   NULL,
    Store         INT            NULL,
    City          VARCHAR(100)   NULL,
    Brand         INT            NULL,
    Description   VARCHAR(255)   NULL,
    Size          VARCHAR(50)    NULL,
    onHand        INT            NULL,
    Price         DECIMAL(18,4)  NULL,
    startDate     VARCHAR(50)    NULL
);
GO

-- ---------------------------------------------------------------------
-- 2. Ending inventory snapshot (2016-12-31)
-- ---------------------------------------------------------------------
CREATE TABLE staging.end_inv (
    InventoryId   VARCHAR(100)   NULL,
    Store         INT            NULL,
    City          VARCHAR(100)   NULL,
    Brand         INT            NULL,
    Description   VARCHAR(255)   NULL,
    Size          VARCHAR(50)    NULL,
    onHand        INT            NULL,
    Price         DECIMAL(18,4)  NULL,
    endDate       VARCHAR(50)    NULL
);
GO

-- ---------------------------------------------------------------------
-- 3. Purchase line items
-- ---------------------------------------------------------------------
CREATE TABLE staging.purchases (
    InventoryId     VARCHAR(100)   NULL,
    Store           INT            NULL,
    Brand           INT            NULL,
    Description     VARCHAR(255)   NULL,
    Size            VARCHAR(50)    NULL,
    VendorNumber    INT            NULL,
    VendorName      VARCHAR(255)   NULL,
    PONumber        INT            NULL,
    PODate          VARCHAR(50)    NULL,
    ReceivingDate   VARCHAR(50)    NULL,
    InvoiceDate     VARCHAR(50)    NULL,
    PayDate         VARCHAR(50)    NULL,
    PurchasePrice   DECIMAL(18,4)  NULL,
    Quantity        INT            NULL,
    Dollars         DECIMAL(18,4)  NULL,
    Classification  INT            NULL
);
GO

-- ---------------------------------------------------------------------
-- 4. Vendor invoices (header level, includes freight)
-- ---------------------------------------------------------------------
CREATE TABLE staging.invoice_purchases (
    VendorNumber   INT            NULL,
    VendorName     VARCHAR(255)   NULL,
    InvoiceDate    VARCHAR(50)    NULL,
    PONumber       INT            NULL,
    PODate         VARCHAR(50)    NULL,
    PayDate        VARCHAR(50)    NULL,
    Quantity       INT            NULL,
    Dollars        DECIMAL(18,4)  NULL,
    Freight        DECIMAL(18,4)  NULL,
    Approval       VARCHAR(100)   NULL
);
GO

-- ---------------------------------------------------------------------
-- 5. Sales line items (largest file, ~12M rows)
--    NOTE: this file is NOT quote-wrapped and uses M/D/YYYY dates
-- ---------------------------------------------------------------------
CREATE TABLE staging.sales (
    InventoryId     VARCHAR(100)   NULL,
    Store           INT            NULL,
    Brand           INT            NULL,
    Description     VARCHAR(255)   NULL,
    Size            VARCHAR(50)    NULL,
    SalesQuantity   INT            NULL,
    SalesDollars    DECIMAL(18,4)  NULL,
    SalesPrice      DECIMAL(18,4)  NULL,
    SalesDate       VARCHAR(50)    NULL,
    Volume          VARCHAR(50)    NULL,
    Classification  INT            NULL,
    ExciseTax       DECIMAL(18,4)  NULL,
    VendorNo        INT            NULL,
    VendorName      VARCHAR(255)   NULL
);
GO

-- ---------------------------------------------------------------------
-- 6. Purchase price reference (Dec 2017 price list)
-- ---------------------------------------------------------------------
CREATE TABLE staging.purchase_prices (
    Brand           INT            NULL,
    Description     VARCHAR(255)   NULL,
    Price           DECIMAL(18,4)  NULL,
    Size            VARCHAR(50)    NULL,
    Volume          VARCHAR(50)    NULL,
    Classification  INT            NULL,
    PurchasePrice   DECIMAL(18,4)  NULL,
    VendorNumber    INT            NULL,
    VendorName      VARCHAR(255)   NULL
);
GO

