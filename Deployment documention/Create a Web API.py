import pandas as pd
from sklearn.neighbors import NearestNeighbors
from flask import Flask, jsonify, request
from sqlalchemy import create_engine

# Initialize Flask application
app = Flask(__name__)

# Create SQLAlchemy engine (replace with your actual database connection string)
engine = create_engine('mssql+pyodbc://sa:admin@Omar/Datawarehouse_DB?driver=SQL+Server')

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
    
    # Ensure that we do not request more neighbors than available
    n_neighbors = min(n_recommendations + 1, len(user_item_matrix))
    
    # Find the nearest neighbors
    distances, indices = model_knn.kneighbors(
        user_item_matrix.iloc[customer_index, :].values.reshape(1, -1), n_neighbors=n_neighbors)

    # Get the recommended products
    recommendations = []
    for i in range(1, len(distances.flatten())):
        recommended_customer_index = indices.flatten()[i]
        recommended_products = user_item_matrix.iloc[recommended_customer_index][user_item_matrix.iloc[recommended_customer_index] > 0].index.tolist()
        recommendations.extend(recommended_products)

    # Return unique recommendations
    return list(set(recommendations))

@app.route('/recommend', methods=['GET'])
def recommend():
    customer_id = request.args.get('customer_id', type=int)
    n_recommendations = request.args.get('n', default=5, type=int)

    if customer_id not in user_item_matrix.index:
        return jsonify({'error': 'Customer ID not found'}), 404

    # Get recommendations
    recommended_products = get_recommendations(customer_id, n_recommendations=n_recommendations)
    return jsonify({'recommended_products': recommended_products})

if __name__ == '__main__':
    app.run(debug=True)



'''
for testing the code use this link:
http://127.0.0.1:5000/recommend?customer_id=2&n=5
'''