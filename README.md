# OLIST Market Analysis 🇧🇷

🔍 **Overview**  
This project provides a comprehensive market analysis using data from **OLIST**, a popular e-commerce platform in Brazil. The project covers **data cleaning**, **transformation**, and **analysis** using SQL queries, while also presenting the data in a more understandable way with **interactive visualizations** created in Power BI.  

---

## 📂 **Data Set**

The dataset used in this project is a rich e-commerce dataset publicly available on Kaggle, provided by OLIST. It contains detailed information about:  
✔️ Orders  
✔️ Customers  
✔️ Products  
✔️ Payments  
✔️ Sellers  

📥 **Access the dataset here**: [Kaggle OLIST Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce-olist-dataset)  

---

## 🎯 **Project Goal**

The main goal of this project is to deeply analyze:  
📈 **Customer Behavior**  
💰 **Sales Trends**  
🚚 **Logistics Performance**  
📊 **Market Dynamics**  
🏅 **RFM Analysis**

Using SQL and Power BI together, the analysis provides insights that can guide business decisions, improve growth strategies, and identify areas for operational enhancements.

---

## ⚙️ **Technologies Used**

* **SQL**: Used for retrieving, cleaning, transforming, and analyzing data. *(Database used: PostgreSQL.)*  
* **Power BI**: Used for creating interactive visualizations, reports, and dashboards.  
* **GitHub**: Version control and project file sharing.

---

## 🗂️ **Project Structure**

The project is organized into the following directories:  

### 📜 **SQL Queries Include (`OLIST_Analysis.sql`)**

This SQL file contains a series of well-structured queries designed to extract insights and analyze the OLIST dataset. The key analyses performed are:  

1. **RFM Analysis**  
   * This analysis classifies customers based on:  
     - **Recency:** How recently they made a purchase.  
     - **Frequency:** How often they make purchases.  
     - **Monetary:** How much they spend.  
   * The results help in identifying valuable customer segments, such as loyal customers or those at risk of churn.  

2. **Payment Analysis**  
   * Investigates payment methods used by customers.  
   * Provides insights into the popularity of different payment options, the number of installments chosen, and payment-related customer behaviors.  

3. **Seller Analysis**  
   * Analyzes seller performance metrics such as:  
     - Number of orders fulfilled.  
     - Average ratings received.  
     - Average delivery times.  
   * Helps identify top-performing sellers and those requiring improvement.  

4. **Customer Analysis**  
   * Focuses on customer segmentation based on purchase behavior.  
   * Includes insights into demographics, geographic locations, and lifetime value of customers.  

5. **Order Analysis**  
   * Evaluates order-related data, such as:  
     - Monthly and yearly order trends.  
     - Average delivery times.  
     - Order status distributions (e.g., delivered, canceled, returned).  
   * Helps uncover seasonal trends and potential bottlenecks in the order fulfillment process.

### 📊 **Power BI Files (`OLIST_Analysis_Visualization`)**
* Contains the Power BI report file (`.pbix`) and screenshots of visualizations.

---

## 📈 **Power BI Visualizations**

The Power BI report includes:  

1. **📅 Customer Analysis:**  
   * Check out general information about customers' spending and distribution and more.  
   * ![image](https://github.com/user-attachments/assets/c0040e6e-5545-4a05-90fc-68dffb80c494)
 

2. **👥 Payment Analysis:**  
   * You can examine customers' payment behavior (e.g. the most used payment method). 
   * ![image](https://github.com/user-attachments/assets/294efa6a-dda7-4cdd-9115-91e5317bef3c)
  

3. **📦 Category Analysis (Product):**  
   * Check out category-based analysis.  
   * ![image](https://github.com/user-attachments/assets/b211402a-80fb-4119-a4ed-767da2c990bb)
  
---

## 🚀 **Getting Started**

Follow these steps to get started:  
1. Clone this repository:  
   ```bash
   git clone https://github.com/HsnHmrc/OLIST_Market_Analysis.git
