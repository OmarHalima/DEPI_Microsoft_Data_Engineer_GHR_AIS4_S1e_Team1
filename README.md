# Customer Data Management and Analysis - README

## Project Overview

This project is aimed at developing a system to manage and analyze customer data efficiently. It involves setting up a SQL database, implementing data warehousing, writing SQL queries, and using Python for data extraction, analysis, and predictions. The key focus is on organizing customer data and generating insights like transaction patterns and customer churn prediction.

## Key Components

### 1. **SQL Database Design**

- **Schema Design**: The SQL database manages core customer-related entities such as customer information, transactions, and interactions.
- **Normalization**: Data is normalized to eliminate redundancy and ensure consistency.
- **Entities**: The main tables include `Customers`, `Transactions`, `Interactions`, `Products`, `CustomerAddresses`, and related tables to ensure smooth data handling.
- **Constraints**: Primary and foreign keys maintain relationships and data integrity across tables.

### 2. **Data Warehousing**

- **Data Warehouse Setup**: A data warehouse is implemented to aggregate large volumes of customer data for analytical purposes.
- **ETL Process**: Data is extracted from various sources, transformed as needed, and loaded into the data warehouse for reporting and analysis.

### 3. **SQL Queries for Analysis**

- A set of SQL queries is provided to retrieve and analyze data related to customer transactions, interactions, and other key metrics.
- **Examples**:
  - Total number of customers.
  - Monthly transaction revenue.
  - Customer lifetime value (CLV).
  - Interaction frequency by channel.

### 4. **Python Scripts for Data Processing**

- Python scripts (using Pandas and SQLAlchemy) are used to extract data from the SQL database and prepare it for analysis.
- These scripts help in automating the process of data extraction and transformation.

### 5. **Predictive Analysis with Python**

- **revenues Prediction Model**: Using Python's Scikit-learn library, a predictive model is built to forecast revenues based on historical data.
- The model is trained, validated, and evaluated using key metrics.

## Deliverables

- **Database Design**: A SQL database schema to store customer data.
- **Data Warehouse**: A functioning data warehouse for large-scale data aggregation.
- **SQL Queries**: A collection of SQL queries to retrieve and analyze customer data.
- **Python Scripts**: Scripts for interacting with the database and performing analysis.
- **Predictive Model**: A machine learning model for customer churn prediction.

## Folder Structure

```
/project-directory
    ├── SQL Documentation.txt               # SQL database schema and tables
    ├── Python Documentation/             # Folder containing Python scripts
    ├── Deployment Documentation.txt          # Sample of Deployment tasks
    ├── README.md                   # Project documentation
```

## Getting Started

### Prerequisites

- **SQL Server**: Ensure that Microsoft SQL Server is installed and configured.
- **Python**: Install Python with required libraries (Pandas, SQLAlchemy, Scikit-learn).

### Installation

1. Set up the SQL database using the schema provided in _DB Tables.txt_.
2. Populate the database with sample data from _Sample.txt_.
3. Use the Python scripts in the _Python Scripts/_ folder to interact with the database and perform data analysis.
4. Run SQL queries from _Queries.txt_ to extract data insights.

### Usage

- **SQL Queries**: Retrieve customer, transaction, and interaction data using the provided queries.
- **Python Scripts**: Automate data extraction and analysis with Python.
- **Model Predictions**: Use the Recommendation and revenues prediction model to analyze customer and profit behavior.
