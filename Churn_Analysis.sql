SELECT * FROM churn_analysis.churn limit 5;

SELECT COUNT(*) FROM churn_analysis.churn;
DESCRIBE churn_analysis.churn;

SELECT *
FROM churn_analysis.churn
WHERE Churn = 'Yes';

SELECT *
FROM churn_analysis.churn
WHERE Contract = 'Month-to-month';

SELECT *
FROM churn_analysis.churn
WHERE tenure <= 12;

SELECT *
FROM churn_analysis.churn
WHERE Contract = 'Month-to-month'
AND Churn = 'Yes';

SELECT COUNT(*)
FROM churn_analysis.churn
WHERE Contract = 'Month-to-month'
AND Churn = 'Yes';

#5 Overall churn rate
SELECT
    ROUND(
        COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0
        / COUNT(*), 2
    ) AS Churn_Rate
FROM churn_analysis.churn;

# Average monthly charges
SELECT
    ROUND(AVG(MonthlyCharges), 2) AS Average_Monthly_Charges
FROM churn_analysis.churn;

# Total monthly charges
SELECT
    ROUND(SUM(MonthlyCharges), 2) AS Total_Monthly_Charges
FROM churn_analysis.churn;

#6 Average Customer tenure
SELECT
    ROUND(AVG(tenure), 2) AS Average_Tenure
FROM churn_analysis.churn;

# Churn by contract type
SELECT
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' 
    THEN 1 
    ELSE 0 
    END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' 
        THEN 1 
        ELSE 0
        END) * 100.0
        / COUNT(*), 2
    ) AS Churn_Rate
FROM churn_analysis.churn
GROUP BY Contract
ORDER BY Churn_Rate DESC;

# Churn by payment method
SELECT
    PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' 
    THEN 1 
    ELSE 0 
    END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes'
        THEN 1 
        ELSE 0
        END) * 100.0
        / COUNT(*), 2
    ) AS Churn_Rate
FROM churn_analysis.churn
GROUP BY PaymentMethod
ORDER BY Churn_Rate DESC;

# Churn by internet service
SELECT
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' 
        THEN 1 
        ELSE 0 
        END) * 100.0
        / COUNT(*), 2
    ) AS Churn_Rate
FROM churn_analysis.churn
GROUP BY InternetService
ORDER BY Churn_Rate DESC;

# CUSTOMER SEGMENTATION ANALYSIS
# Churn by tenure group
SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        WHEN tenure <= 60 THEN '49-60 months'
        ELSE '61-72 months'
    END AS Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' 
    THEN 1 
    ELSE 0 
    END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' 
        THEN 1 
        ELSE 0 
        END) * 100.0
        / COUNT(*), 2
    ) AS Churn_Rate
FROM churn_analysis.churn
GROUP BY Tenure_Group
ORDER BY MIN(tenure);

# Churn by senior citizen status
SELECT
    SeniorCitizen,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' 
    THEN 1 
    ELSE 0 
    END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' 
        THEN 1 
        ELSE 0 
        END) * 100.0
        / COUNT(*), 2
    ) AS Churn_Rate
FROM churn_analysis.churn
GROUP BY SeniorCitizen;

# Churn by gender
SELECT
    gender,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' 
    THEN 1 
    ELSE 0 
    END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' 
        THEN 1 
        ELSE 0 
        END) * 100.0
        / COUNT(*), 2
    ) AS Churn_Rate
FROM churn_analysis.churn
GROUP BY gender;

# Churn by technical support
SELECT
    TechSupport,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' 
    THEN 1 
    ELSE 0 
    END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' 
        THEN 1 
        ELSE 0 
        END) * 100.0
        / COUNT(*), 2
    ) AS Churn_Rate
FROM churn_analysis.churn
GROUP BY TechSupport
ORDER BY Churn_Rate DESC;

# Churn by online security
SELECT
    OnlineSecurity,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' 
    THEN 1 
    ELSE 0
    END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' 
        THEN 1 
        ELSE 0 
        END) * 100.0
        / COUNT(*), 2
    ) AS Churn_Rate
FROM churn_analysis.churn
GROUP BY OnlineSecurity
ORDER BY Churn_Rate DESC;

# Churn by contract and tenure together
SELECT
    Contract,
    CASE
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        WHEN tenure <= 60 THEN '49-60 months'
        ELSE '61-72 months'
    END AS Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' 
    THEN 1 
    ELSE 0 
    END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' 
        THEN 1 
        ELSE 0 
        END) * 100.0
        / COUNT(*), 2
    ) AS Churn_Rate
FROM churn_analysis.churn
GROUP BY Contract, Tenure_Group
ORDER BY Churn_Rate DESC;

# Revenue Analysis
# Average monthly charges by churn status
SELECT
    Churn,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(MonthlyCharges), 2) AS Average_Monthly_Charges
FROM churn_analysis.churn
GROUP BY Churn;

# Monthly revenue associated with churned customers
SELECT
    ROUND(SUM(MonthlyCharges), 2) AS Monthly_Revenue_At_Risk
FROM churn_analysis.churn
WHERE Churn = 'Yes';

# Revenue contribution by contract type
SELECT
    Contract,
    COUNT(*) AS Total_Customers,
    ROUND(SUM(MonthlyCharges), 2) AS Total_Monthly_Revenue,
    ROUND(AVG(MonthlyCharges), 2) AS Average_Monthly_Charges
FROM churn_analysis.churn
GROUP BY Contract
ORDER BY Total_Monthly_Revenue DESC;

# Revenue analysis by internet service
SELECT
    InternetService,
    COUNT(*) AS Total_Customers,
    ROUND(SUM(MonthlyCharges), 2) AS Total_Monthly_Revenue,
    ROUND(AVG(MonthlyCharges), 2) AS Average_Monthly_Charges
FROM churn_analysis.churn
GROUP BY InternetService
ORDER BY Total_Monthly_Revenue DESC;

# High-value customers who churned
SELECT
    customerID,
    Contract,
    tenure,
    MonthlyCharges,
    InternetService
FROM churn_analysis.churn
WHERE Churn = 'Yes'
AND MonthlyCharges > 80
ORDER BY MonthlyCharges DESC;

# Total charges lost from churned customers
SELECT
    ROUND(SUM(TotalCharges), 2) AS Total_Charges_From_Churned_Customers
FROM churn_analysis.churn
WHERE Churn = 'Yes';

# Identify customers paying above the average monthly charge
SELECT
    customerID,
    Contract,
    MonthlyCharges,
    Churn
FROM churn_analysis.churn
WHERE MonthlyCharges > (
    SELECT AVG(MonthlyCharges)
    FROM churn_analysis.churn
)
ORDER BY MonthlyCharges DESC;

# Identify contracts with a churn rate above the overall churn rate
SELECT
    Contract,
    ROUND(
        AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100,
        2
    ) AS Churn_Rate
FROM churn_analysis.churn
GROUP BY Contract
HAVING AVG(CASE WHEN Churn = 'Yes' 
THEN 1 
ELSE 0 
END) >
(
    SELECT AVG(CASE WHEN Churn = 'Yes' 
    THEN 1 
    ELSE 0 
    END)
    FROM churn_analysis.churn
);

# Identify customer segments with more than 100 churned customers
SELECT
    Contract,
    InternetService,
    COUNT(*) AS Churned_Customers
FROM churn_analysis.churn
WHERE Churn = 'Yes'
GROUP BY Contract, InternetService
HAVING COUNT(*) > 100
ORDER BY Churned_Customers DESC;

# Rank contract types by churn rate using a CTE and RANK()
WITH Contract_Churn AS (
    SELECT
        Contract,
        COUNT(*) AS Total_Customers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
        AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100 AS Churn_Rate
    FROM churn_analysis.churn
    GROUP BY Contract
)

SELECT
    Contract,
    Total_Customers,
    Churned_Customers,
    ROUND(Churn_Rate, 2) AS Churn_Rate,
    RANK() OVER (ORDER BY Churn_Rate DESC) AS Churn_Rank
FROM Contract_Churn;

# Rank customers by monthly charges
SELECT
    customerID,
    MonthlyCharges,
    Churn,
    ROW_NUMBER() OVER (
        ORDER BY MonthlyCharges DESC
    ) AS Customer_Rank
FROM churn_analysis.churn
LIMIT 20;

# Comparing individual customer charges with the average charges of their contract group
SELECT
    customerID,
    Contract,
    MonthlyCharges,
    ROUND(
        AVG(MonthlyCharges) OVER (
            PARTITION BY Contract
        ), 2
    ) AS Contract_Average_Charges
FROM churn_analysis.churn;

# Churn rate by contract and payment method
SELECT
    Contract,
    PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate
FROM churn_analysis.churn
GROUP BY Contract, PaymentMethod
ORDER BY Churn_Rate DESC;

# Identify high-risk customer segments
SELECT
    customerID,
    Contract,
    tenure,
    Churn,
    CASE
        WHEN Contract = 'Month-to-month' AND tenure <= 12
            THEN 'High Risk'
        WHEN Contract = 'Month-to-month' AND tenure <= 24
            THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Category
FROM churn_analysis.churn;

# Count customers in each risk category
SELECT
    Risk_Category,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate
FROM (
    SELECT
        customerID,
        Churn,
        CASE
            WHEN Contract = 'Month-to-month' AND tenure <= 12
                THEN 'High Risk'
            WHEN Contract = 'Month-to-month' AND tenure <= 24
                THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS Risk_Category
    FROM churn_analysis.churn
) AS Customer_Segments
GROUP BY Risk_Category
ORDER BY Churn_Rate DESC;

#Classifying customers by monthly charges
SELECT
    customerID,
    MonthlyCharges,
    CASE
        WHEN MonthlyCharges >= 80 THEN 'High Value'
        WHEN MonthlyCharges >= 50 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Customer_Value
FROM churn_analysis.churn;

# Revenue contribution by customer value
SELECT
    Customer_Value,
    COUNT(*) AS Total_Customers,
    ROUND(SUM(MonthlyCharges), 2) AS Total_Monthly_Revenue,
    ROUND(AVG(MonthlyCharges), 2) AS Average_Monthly_Charges
FROM (
    SELECT
        MonthlyCharges,
        CASE
            WHEN MonthlyCharges >= 80 THEN 'High Value'
            WHEN MonthlyCharges >= 50 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS Customer_Value
    FROM churn_analysis.churn
) AS Customer_Segments
GROUP BY Customer_Value
ORDER BY Total_Monthly_Revenue DESC;

# High-value customers who churned
SELECT
    customerID,
    Contract,
    tenure,
    MonthlyCharges,
    InternetService,
    PaymentMethod
FROM churn_analysis.churn
WHERE MonthlyCharges >= 80
AND Churn = 'Yes'
ORDER BY MonthlyCharges DESC;

# Churn rate by customer value
SELECT
    Customer_Value,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS Churn_Rate
FROM (
    SELECT
        Churn,
        CASE
            WHEN MonthlyCharges >= 80 THEN 'High Value'
            WHEN MonthlyCharges >= 50 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS Customer_Value
    FROM churn_analysis.churn
) AS Customer_Segments
GROUP BY Customer_Value
ORDER BY Churn_Rate DESC;

# Rank contract types by churn rate
WITH Contract_Analysis AS (
    SELECT
        Contract,
        COUNT(*) AS Total_Customers,
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
        AVG(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100 AS Churn_Rate
    FROM churn_analysis.churn
    GROUP BY Contract
)
SELECT
    Contract,
    Total_Customers,
    Churned_Customers,
    ROUND(Churn_Rate, 2) AS Churn_Rate,
    RANK() OVER (ORDER BY Churn_Rate DESC) AS Churn_Rank
FROM Contract_Analysis;

# Rank customers by monthly charges
SELECT
    customerID,
    Contract,
    MonthlyCharges,
    Churn,
    RANK() OVER (ORDER BY MonthlyCharges DESC) AS Charge_Rank
FROM churn_analysis.churn
ORDER BY MonthlyCharges DESC
LIMIT 20;

# Compare customer charges with contract average
SELECT
    customerID,
    Contract,
    MonthlyCharges,
    ROUND(
        AVG(MonthlyCharges) OVER (PARTITION BY Contract),
        2
    ) AS Contract_Average_Charges
FROM churn_analysis.churn;

# Compare customer charges with contract average
SELECT
    customerID,
    Contract,
    MonthlyCharges,
    ROUND(
        AVG(MonthlyCharges) OVER (PARTITION BY Contract),
        2
    ) AS Contract_Average_Charges
FROM churn_analysis.churn;

# Calculate revenue contribution by contract
WITH Contract_Revenue AS (
    SELECT
        Contract,
        SUM(MonthlyCharges) AS Total_Revenue
    FROM churn_analysis.churn
    GROUP BY Contract
)
SELECT
    Contract,
    ROUND(Total_Revenue, 2) AS Total_Revenue,
    ROUND(
        Total_Revenue * 100.0 / SUM(Total_Revenue) OVER (),
        2
    ) AS Revenue_Contribution_Percentage
FROM Contract_Revenue
ORDER BY Total_Revenue DESC;