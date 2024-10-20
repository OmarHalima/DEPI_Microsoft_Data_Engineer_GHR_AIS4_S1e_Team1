use Transactional_DB

-- ==========================================
-- SQL Queries for Data Validation and Analysis
-- ==========================================

-- ==========================================
-- Part 1: Data Validation Queries
-- ==========================================

-- 1. Check for NULL values in important fields (Customers table)
-- Ensures mandatory fields in the Customers table are filled.
SELECT COUNT(*) AS NullCount
FROM dbo.Customers
WHERE Email IS NULL OR FirstName IS NULL OR LastName IS NULL;

-- 2. Check for duplicate emails (which should be unique)
-- Ensures that the Email column does not contain duplicate values.
SELECT Email, COUNT(*) AS EmailCount
FROM dbo.Customers
GROUP BY Email
HAVING COUNT(*) > 1;

-- 3. Check for invalid postal codes (non-numeric)
-- Validates that PostalCode only contains numeric values.
SELECT PostalCode
FROM dbo.CustomerAddresses
WHERE ISNUMERIC(PostalCode) = 0;

-- 4. Verify customer addresses without a city or country
-- Ensures all addresses have a valid city and country specified.
SELECT *
FROM dbo.CustomerAddresses
WHERE City IS NULL OR Country IS NULL;

-- 5. Check if foreign keys in CustomerAddresses refer to non-existent customers
-- Verifies that every customer address is linked to a valid customer.
SELECT a.*
FROM dbo.CustomerAddresses a
LEFT JOIN dbo.Customers c ON a.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

-- 6. Ensure that no transactions have a negative amount
-- Checks if any transactions have a negative monetary amount.
SELECT *
FROM dbo.Transactions
WHERE Amount < 0;

-- 7. Check if ProductReviews have ratings outside the allowed range (1-5)
-- Validates that product ratings are between 1 and 5.
SELECT *
FROM dbo.ProductReviews
WHERE Rating < 1 OR Rating > 5;

-- 8. Find customers without any registered addresses
-- Identifies customers who have no address linked to them.
SELECT c.CustomerID, c.FirstName, c.LastName
FROM dbo.Customers c
LEFT JOIN dbo.CustomerAddresses a ON c.CustomerID = a.CustomerID
WHERE a.CustomerID IS NULL;

-- 9. Validate consistency of Transactions related to non-existent customers
-- Ensures that every transaction is linked to a valid customer.
SELECT t.*
FROM dbo.Transactions t
LEFT JOIN dbo.Customers c ON t.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

-- 10. Ensure InteractionTypes are properly referenced in Interactions
-- Validates that every interaction refers to a valid interaction type.
SELECT i.*
FROM dbo.Interactions i
LEFT JOIN dbo.InteractionTypes it ON i.InteractionTypeID = it.InteractionTypeID
WHERE it.InteractionTypeID IS NULL;

-- 11. Check for duplicate product names in Products table
-- Verifies that product names in the Products table are unique.
SELECT ProductName, COUNT(*)
FROM dbo.Products
GROUP BY ProductName
HAVING COUNT(*) > 1;

-- 12. Ensure all Login entries have associated customers
-- Ensures that every login record is linked to a valid customer.
SELECT l.*
FROM dbo.Login l
LEFT JOIN dbo.Customers c ON l.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

-- 13. Check for invalid or empty product prices
-- Ensures that products have valid (non-zero, non-null) prices.
SELECT *
FROM dbo.Products
WHERE Price <= 0 OR Price IS NULL;

-- 14. Verify if UserSessions have login but no logout times
-- Identifies sessions where a user has logged in but not logged out.
SELECT *
FROM dbo.UserSessions
WHERE LogoutTime IS NULL;

-- 15. Identify transactions without details in TransactionDetails
-- Ensures that every transaction has corresponding details.
SELECT t.TransactionID
FROM dbo.Transactions t
LEFT JOIN dbo.TransactionDetails td ON t.TransactionID = td.TransactionID
WHERE td.TransactionID IS NULL;

-- 16. Ensure all WishlistItems refer to existing products
-- Checks that every item in a wishlist is a valid product.
SELECT wi.*
FROM dbo.WishlistItems wi
LEFT JOIN dbo.Products p ON wi.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

-- 17. Check for orphaned interactions that don't have customers
-- Ensures that every interaction is linked to a valid customer.
SELECT i.*
FROM dbo.Interactions i
LEFT JOIN dbo.Customers c ON i.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

-- 18. Validate TransactionDetails entries have valid product references
-- Ensures every transaction detail refers to an existing product.
SELECT td.*
FROM dbo.TransactionDetails td
LEFT JOIN dbo.Products p ON td.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

-- 19. Ensure Wishlists are linked to valid customers
-- Verifies that each wishlist is associated with a valid customer.
SELECT w.*
FROM dbo.Wishlists w
LEFT JOIN dbo.Customers c ON w.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

-- 20. Check if Log records are missing CustomerIDs or LoginIDs
-- Ensures that logs contain both customer and login IDs.
SELECT *
FROM dbo.Log
WHERE CustomerID IS NULL OR LoginID IS NULL;


-- ==========================================
-- Part 2: Data Analysis Queries
-- ==========================================

-- 1. Count total customers
-- Provides the total number of customers in the system.
SELECT COUNT(*) AS TotalCustomers
FROM dbo.Customers;

-- 2. Get the top 5 cities by the number of customer addresses
-- Shows which cities have the most customer addresses.
SELECT City, COUNT(*) AS AddressCount
FROM dbo.CustomerAddresses
GROUP BY City
ORDER BY AddressCount DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- 3. Total revenue generated from transactions
-- Calculates the total revenue (sum of transaction amounts).
SELECT SUM(Amount) AS TotalRevenue
FROM dbo.Transactions;

-- 4. Get the average rating of products from ProductReviews
-- Provides the average rating score for all product reviews.
SELECT AVG(Rating) AS AvgRating
FROM dbo.ProductReviews;

-- 5. Number of interactions by interaction type
-- Counts how many interactions exist for each interaction type.
SELECT it.InteractionTypeName, COUNT(*) AS InteractionCount
FROM dbo.Interactions i
JOIN dbo.InteractionTypes it ON i.InteractionTypeID = it.InteractionTypeID
GROUP BY it.InteractionTypeName;

-- 6. Top 5 most purchased products
-- Shows the top 5 products based on the total quantity sold.
SELECT p.ProductName, SUM(td.Quantity) AS TotalQuantity
FROM dbo.TransactionDetails td
JOIN dbo.Products p ON td.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantity DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- 7. Count of transactions by payment method
-- Provides the number of transactions for each payment method.
SELECT PaymentMethod, COUNT(*) AS TransactionCount
FROM dbo.Transactions
GROUP BY PaymentMethod;

-- 8. Average order value in transactions
-- Calculates the average value of a customer transaction.
SELECT AVG(Amount) AS AvgOrderValue
FROM dbo.Transactions;

-- 9. List of customers who have never made a transaction
-- Shows customers who have registered but not made a transaction.
SELECT c.CustomerID, c.FirstName, c.LastName
FROM dbo.Customers c
LEFT JOIN dbo.Transactions t ON c.CustomerID = t.CustomerID
WHERE t.CustomerID IS NULL;

-- 10. Top 5 most active customers by the number of interactions
-- Lists the top 5 customers with the highest number of interactions.
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(i.InteractionID) AS InteractionCount
FROM dbo.Customers c
JOIN dbo.Interactions i ON c.CustomerID = i.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY InteractionCount DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- 11. Total number of sessions in UserSessions
-- Shows how many sessions have been logged by all users.
SELECT COUNT(*) AS TotalSessions
FROM dbo.UserSessions;

-- 12. Get the top 5 customers by the total transaction amount
-- Shows the customers who have spent the most money.
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(t.Amount) AS TotalAmount
FROM dbo.Customers c
JOIN dbo.Transactions t ON c.CustomerID = t.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalAmount DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- 13. Number of customers registered each year
-- Provides the count of customer registrations for each year.
SELECT YEAR(RegistrationDate) AS Year, COUNT(*) AS Registrations
FROM dbo.Customers
GROUP BY YEAR(RegistrationDate);

-- 14. Monthly breakdown of total transactions
-- Shows the total transaction amounts for each month.
SELECT YEAR(TransactionDate) AS Year, MONTH(TransactionDate) AS Month, SUM(Amount) AS MonthlyTotal
FROM dbo.Transactions
GROUP BY YEAR(TransactionDate), MONTH(TransactionDate)
ORDER BY Year, Month;

-- 15. Top 5 product categories by number of products
-- Lists the product categories with the highest product counts.
SELECT pc.CategoryName, COUNT(p.ProductID) AS ProductCount
FROM dbo.ProductCategories pc
JOIN dbo.Products p ON pc.CategoryID = p.CategoryID
GROUP BY pc.CategoryName
ORDER BY ProductCount DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- 16. Average customer age based on DateOfBirth
-- Calculates the average age of customers.
SELECT AVG(DATEDIFF(YEAR, DateOfBirth, GETDATE())) AS AvgAge
FROM dbo.Customers
WHERE DateOfBirth IS NOT NULL;

-- 17. Total number of interactions each month
-- Provides the count of interactions for each month.
SELECT YEAR(InteractionDate) AS Year, MONTH(InteractionDate) AS Month, COUNT(*) AS InteractionCount
FROM dbo.Interactions
GROUP BY YEAR(InteractionDate), MONTH(InteractionDate);

-- 18. Total revenue per product in transactions
-- Shows the total revenue generated by each product.
SELECT p.ProductName, SUM(td.Quantity * td.Price) AS TotalRevenue
FROM dbo.TransactionDetails td
JOIN dbo.Products p ON td.ProductID = p.ProductID
GROUP BY p.ProductName;

-- 19. Most recent login time for each customer
-- Shows the most recent login time for each customer.
SELECT c.CustomerID, c.FirstName, c.LastName, MAX(l.LastLogin) AS LastLogin
FROM dbo.Customers c
JOIN dbo.Login l ON c.CustomerID = l.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- 20. Top 5 customers by the number of products in their wishlist
-- Lists the customers with the most items in their wishlists.
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(wi.WishlistItemID) AS WishlistCount
FROM dbo.Customers c
JOIN dbo.Wishlists w ON c.CustomerID = w.CustomerID
JOIN dbo.WishlistItems wi ON w.WishlistID = wi.WishlistID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY WishlistCount DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

