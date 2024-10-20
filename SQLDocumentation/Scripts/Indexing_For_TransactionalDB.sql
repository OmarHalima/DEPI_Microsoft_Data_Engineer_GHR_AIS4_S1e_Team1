use Transactional_DB 
-- ==========================================
-- Drop Existing Non-Primary Key Indexes
-- ==========================================
-- Drop unique index on Customers.Email
DROP INDEX UQ__Customer__A9D10534DF679959 ON dbo.Customers;

-- More indexes can be dropped here if needed...


-- ==========================================
-- Create New Indexes for Performance
-- ==========================================

-- 1. Customers Table Indexes
CREATE NONCLUSTERED INDEX IX_Customers_Email
ON dbo.Customers (Email);

CREATE NONCLUSTERED INDEX IX_Customers_Name
ON dbo.Customers (LastName, FirstName);

CREATE NONCLUSTERED INDEX IX_Customers_DateOfBirth
ON dbo.Customers (DateOfBirth);

-- 2. CustomerAddresses Table Index
CREATE NONCLUSTERED INDEX IX_CustomerAddresses_CustomerID
ON dbo.CustomerAddresses (CustomerID);

-- 3. Transactions Table Indexes
CREATE NONCLUSTERED INDEX IX_Transactions_CustomerID_TransactionDate
ON dbo.Transactions (CustomerID, TransactionDate);

-- 4. ProductReviews Table Indexes
CREATE NONCLUSTERED INDEX IX_ProductReviews_ProductID_Rating
ON dbo.ProductReviews (ProductID, Rating);

-- 5. Interactions Table Indexes
CREATE NONCLUSTERED INDEX IX_Interactions_CustomerID_InteractionDate
ON dbo.Interactions (CustomerID, InteractionDate);

-- 6. Products Table Indexes
CREATE NONCLUSTERED INDEX IX_Products_CategoryID_Price
ON dbo.Products (CategoryID, Price);

-- 7. TransactionDetails Table Index
CREATE NONCLUSTERED INDEX IX_TransactionDetails_TransactionID
ON dbo.TransactionDetails (TransactionID);

-- 8. Login Table Index
CREATE NONCLUSTERED INDEX IX_Login_CustomerID
ON dbo.Login (CustomerID);

-- ==========================================
-- End of Index Script
-- ==========================================
