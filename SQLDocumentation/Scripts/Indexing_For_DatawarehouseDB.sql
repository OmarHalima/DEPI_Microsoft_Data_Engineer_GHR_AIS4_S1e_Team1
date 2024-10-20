-- ==========================================
-- Indexing Script for Datawarehouse_DB
-- ==========================================

-- dim_customer Table Indexes
CREATE NONCLUSTERED INDEX IX_dim_customer_CustomerID
ON dbo.dim_customer (CustomerID);

CREATE NONCLUSTERED INDEX IX_dim_customer_City_Country
ON dbo.dim_customer (City, Country);

CREATE NONCLUSTERED INDEX IX_dim_customer_is_current
ON dbo.dim_customer (is_current);

-- dim_date Table Indexes
CREATE NONCLUSTERED INDEX IX_dim_date_DateKey
ON dbo.dim_date (DateKey);

CREATE NONCLUSTERED INDEX IX_dim_date_Year_Month_Day
ON dbo.dim_date (Year, Month, DayOfMonth);

-- dim_interaction Table Indexes
CREATE NONCLUSTERED INDEX IX_dim_interaction_CustomerID
ON dbo.dim_interaction (CustomerID);

CREATE NONCLUSTERED INDEX IX_dim_interaction_InteractionDate
ON dbo.dim_interaction (InteractionDate);

CREATE NONCLUSTERED INDEX IX_dim_interaction_InteractionTypeName
ON dbo.dim_interaction (InteractionTypeName);

CREATE NONCLUSTERED INDEX IX_dim_interaction_is_current
ON dbo.dim_interaction (is_current);

-- dim_product Table Indexes
CREATE NONCLUSTERED INDEX IX_dim_product_ProductID
ON dbo.dim_product (ProductID);

CREATE NONCLUSTERED INDEX IX_dim_product_ProductName
ON dbo.dim_product (ProductName);

CREATE NONCLUSTERED INDEX IX_dim_product_CategoryName
ON dbo.dim_product (CategoryName);

CREATE NONCLUSTERED INDEX IX_dim_product_is_current
ON dbo.dim_product (is_current);

-- dim_user Table Indexes
CREATE NONCLUSTERED INDEX IX_dim_user_LoginID
ON dbo.dim_user (LoginID);

CREATE NONCLUSTERED INDEX IX_dim_user_Username
ON dbo.dim_user (Username);

CREATE NONCLUSTERED INDEX IX_dim_user_LastLogin
ON dbo.dim_user (LastLogin);

CREATE NONCLUSTERED INDEX IX_dim_user_is_current
ON dbo.dim_user (is_current);

-- fact_transactions Table Indexes
CREATE NONCLUSTERED INDEX IX_fact_transactions_TransactionDate
ON dbo.fact_transactions (TransactionDate);

CREATE NONCLUSTERED INDEX IX_fact_transactions_CustomerID
ON dbo.fact_transactions (CustomerID);

CREATE NONCLUSTERED INDEX IX_fact_transactions_ProductID
ON dbo.fact_transactions (ProductID);

CREATE NONCLUSTERED INDEX IX_fact_transactions_PaymentMethod
ON dbo.fact_transactions (PaymentMethod);

-- ==========================================
-- End of Indexing Script
-- ==========================================
