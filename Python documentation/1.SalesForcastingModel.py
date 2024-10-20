import pandas as pd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt
import seaborn as sns

# Define your connection string
# Step 1: Install necessary libraries
# Run this in your terminal or command line if you haven't installed the required libraries
# !pip install prophet sqlalchemy pymssql sklearn matplotlib joblib

import pandas as pd
from prophet import Prophet
from sqlalchemy import create_engine
from sklearn.metrics import mean_absolute_error
import matplotlib.pyplot as plt
import joblib

# Step 2: Database connection setup (using SQLAlchemy and pymssql)
# Replace these credentials with your actual database details
server = 'Omar'
database = 'Datawarehouse_DB'
username = 'sa'
password = 'admin'

# Create a connection string
connection_string = f"mssql+pymssql://{username}:{password}@{server}/{database}"

# Establish the connection to SQL Server
engine = create_engine(connection_string)

# Step 3: Load data from the fact_transactions table
query = '''
    SELECT TransactionDate, SUM(Price) AS y
    FROM fact_transactions
    GROUP BY TransactionDate
    ORDER BY TransactionDate
'''

# Load the data into a pandas dataframe
df = pd.read_sql(query, engine)

# Step 4: Data Preparation
# Prophet requires two columns: 'ds' (date) and 'y' (sales)
df = df.rename(columns={'TransactionDate': 'ds'})

# Ensure the 'ds' column is in datetime format
df['ds'] = pd.to_datetime(df['ds'])

# Step 5: Initialize the Prophet model
model = Prophet()

# Step 6: Fit the model with the historical sales data
model.fit(df)

# Step 7: Create future dates for forecasting (e.g., 365 days into the future)
future = model.make_future_dataframe(periods=365)

# Step 8: Make predictions using the fitted model
forecast = model.predict(future)

# Step 9: Plot the forecasted results
# Prophet has a built-in plotting function
fig1 = model.plot(forecast)
plt.title('Sales Forecast')
plt.xlabel('Date')
plt.ylabel('Sales')

# Show the plot
plt.show()

# Step 10: Plot the forecast components (trend, weekly, yearly seasonality, etc.)
fig2 = model.plot_components(forecast)
plt.show()

# Step 11: Model Evaluation
# Since Prophet predicts past data as well, we can evaluate its performance on historical data
# We compare the actual sales values with the predicted values for the known period

# Extract the actual values from the most recent period (365 days)
y_true = df.set_index('ds')['y'].tail(365)

# Ensure that y_true and y_pred have the same length
y_pred = forecast['yhat'].tail(len(y_true))

# Calculate Mean Absolute Error (MAE) as the evaluation metric
mae = mean_absolute_error(y_true, y_pred)
print('Mean Absolute Error (MAE):', mae)

# Step 12: Save the trained model
# Save the Prophet model for future use
model_path = 'prophet_sales_forecasting_model.pkl'
joblib.dump(model, model_path)
print(f"Model saved to {model_path}")

# Step 13: (Optional) Loading the saved model for later use
# You can load the saved model to make new predictions without retraining it
loaded_model = joblib.load(model_path)

# Step 14: Making new predictions with the loaded model (if needed)
# Example of using the loaded model to forecast again
future_new = loaded_model.make_future_dataframe(periods=365)
forecast_new = loaded_model.predict(future_new)

# Plot the new forecast
fig3 = loaded_model.plot(forecast_new)
plt.show()


# Connect to the database
engine = create_engine(connection_string)

# Function to load data from the database
def load_data():
    dim_product_df = pd.read_sql_query("SELECT TransactionDate, SUM(Quantity * Price) AS TotalSales FROM fact_transactions GROUP BY TransactionDate ORDER BY TransactionDate;", engine)

