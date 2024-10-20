import pandas as pd
from sklearn.neighbors import NearestNeighbors
import pyodbc
# Connect to SQL Server database
from sqlalchemy import create_engine
import pandas as pd

# Create SQLAlchemy engine (replace with your actual database connection string)
engine = create_engine('mssql+pyodbc://sa:admin@Omar/Datawarehouse_DB?driver=SQL+Server')

# Use the engine with pd.read_sql


# Query to fetch customer-product interactions
query = '''
SELECT 
    c.CustomerID,
    p.ProductID,
    f.Quantity
FROM 
    dbo.fact_transactions f
JOIN 
    dbo.dim_customer c ON f.CustomerID = c.CustomerID
JOIN 
    dbo.dim_product p ON f.ProductID = p.ProductID
WHERE 
    f.TransactionDate IS NOT NULL
ORDER BY 
    c.CustomerID;
'''

# Load data into a DataFrame
df = pd.read_sql(query, engine)
# Group by CustomerID and ProductID, and sum the Quantity
df_grouped = df.groupby(['CustomerID', 'ProductID'], as_index=False)['Quantity'].sum()

# Pivot the data to create a user-item matrix
user_item_matrix = df_grouped.pivot(index='CustomerID', columns='ProductID', values='Quantity').fillna(0)


# Fit the KNN model
model_knn = NearestNeighbors(metric='cosine', algorithm='brute')
model_knn.fit(user_item_matrix)

def get_recommendations(customer_id, n_recommendations=5):
    """ Get product recommendations for a given customer ID. """
    # Get the index of the customer
    customer_index = user_item_matrix.index.get_loc(customer_id)
    
    # Find the nearest neighbors
    distances, indices = model_knn.kneighbors(user_item_matrix.iloc[customer_index, :].values.reshape(1, -1), n_neighbors=n_recommendations + 1)
    
    # Get the recommended products
    recommendations = []
    for i in range(1, len(distances.flatten())):
        recommended_customer_index = indices.flatten()[i]
        recommended_products = user_item_matrix.iloc[recommended_customer_index][user_item_matrix.iloc[recommended_customer_index] > 0].index.tolist()
        recommendations.extend(recommended_products)
    
    # Return unique recommendations
    return list(set(recommendations))

# Example usage with a valid customer ID
customer_id = 2  # Change this to an existing customer ID
if customer_id in user_item_matrix.index:
    recommended_products = get_recommendations(customer_id, n_recommendations=1)  # Adjust to 1 or 2
    print(f"Recommended products for Customer ID {customer_id}: {recommended_products}")
else:
    print(f"Customer ID {customer_id} not found in the user-item matrix.")

