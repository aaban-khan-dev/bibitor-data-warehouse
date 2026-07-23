--BULK LOAD

BULK INSERT staging.beg_inv
FROM 'D:\bibitor-data-warehouse\data\BegInvFINAL12312016.csv'
WITH (
   FORMAT          = 'CSV',
   FIELDQUOTE      = '"',
   FIRSTROW        = 2,
   FIELDTERMINATOR = ',',
   TABLOCK
);
GO

BULK INSERT staging.end_inv
FROM 'D:\bibitor-data-warehouse\data\EndInvFINAL12312016.csv'
WITH (
   FORMAT          = 'CSV',
   FIELDQUOTE      = '"',
   FIRSTROW        = 2,
   FIELDTERMINATOR = ',',
   TABLOCK
);
GO

BULK INSERT staging.purchases
FROM 'D:\bibitor-data-warehouse\data\PurchasesFINAL12312016.csv'
WITH (
   FORMAT          = 'CSV',
   FIELDQUOTE      = '"',
   FIRSTROW        = 2,
   FIELDTERMINATOR = ',',
   TABLOCK
);
GO

BULK INSERT staging.invoice_purchases
FROM 'D:\bibitor-data-warehouse\data\InvoicePurchases12312016.csv'
WITH (
   FORMAT          = 'CSV',
   FIELDQUOTE      = '"',
   FIRSTROW        = 2,
   FIELDTERMINATOR = ',',
   TABLOCK
);
GO

--Sales file is unquoted; FIELDQUOTE omitted deliberately
BULK INSERT staging.sales
FROM 'D:\bibitor-data-warehouse\data\SalesFINAL12312016.csv'
WITH (
   FORMAT = 'CSV',
   FIELDQUOTE = '"',
   FIRSTROW = 2,
   TABLOCK
);
GO

BULK INSERT staging.purchase_prices
FROM 'D:\bibitor-data-warehouse\data\2017PurchasePricesDec.csv'
WITH (
   FORMAT          = 'CSV',
   FIELDQUOTE      = '"',
   FIRSTROW        = 2,
   FIELDTERMINATOR = ',',
   TABLOCK
);
GO

-- =====================================================================
-- VERIFICATION
-- =====================================================================
SELECT 'beg_inv'           AS table_name, COUNT(*) AS row_count FROM staging.beg_inv
UNION ALL
SELECT 'end_inv',           COUNT(*) FROM staging.end_inv
UNION ALL
SELECT 'purchases',         COUNT(*) FROM staging.purchases
UNION ALL
SELECT 'invoice_purchases', COUNT(*) FROM staging.invoice_purchases
UNION ALL
SELECT 'sales',             COUNT(*) FROM staging.sales
UNION ALL
SELECT 'purchase_prices',   COUNT(*) FROM staging.purchase_prices;
GO