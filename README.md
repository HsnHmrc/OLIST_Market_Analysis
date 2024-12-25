# OLIST Market Analysis 🇧🇷

**Note:** I will add screenshots when I have completed the visualizations in the analysis and will fix the shortcomings in the ReadMe folder.

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

1. **📅 Sales Trends:**  
   * Line chart showing sales trends over time.  
   * _Screenshot_  

2. **👥 Customer Segmentation:**  
   * Pie chart or map visualization dividing customers into groups based on purchasing behavior.  
   * _Screenshot_  

3. **📦 Product Performance:**  
   * Bar chart highlighting best-selling products and top revenue-generating items.  
   * _Screenshot_  

4. **🚛 Logistics Performance:**  
   * Metrics showcasing average shipping times and delivery success rates.  
   * _Screenshot_  

_`![Description](powerbi/screenshot.png)`_

---

## 🚀 **Getting Started**

Follow these steps to get started:  
1. Clone this repository:  
   ```bash
   git clone https://github.com/HsnHmrc/OLIST_Market_Analysis.git
