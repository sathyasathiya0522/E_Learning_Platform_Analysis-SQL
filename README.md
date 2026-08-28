# 📊 Analyzing E-Learning Platform Purchases Using MySQL

## 📌 Project Overview

This project is part of the Data Analytics Module-End Assignment 3.

The objective of this project is to analyze an e-learning platform's course purchase data using MySQL. The analysis helps understand learner spending behavior, popular courses, category performance, and sales trends.

## 🗂️ Database Structure

The project contains three tables:

### 1. Learners
- learner_id
- full_name
- country

### 2. Courses
- course_id
- course_name
- category
- unit_price

### 3. Purchases
- purchase_id
- learner_id
- course_id
- quantity
- purchase_date

Primary Keys and Foreign Keys are used to establish relationships between the tables.

## 🔍 SQL Concepts Used

The project demonstrates the following MySQL concepts:

- Database and Table Creation
- Primary Keys and Foreign Keys
- INSERT Statements
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- Aggregate Functions
- GROUP BY
- HAVING
- ORDER BY
- LIMIT
- Subqueries
- Correlated Subqueries
- Common Table Expressions (CTE)
- CASE Expression
- NULL Handling using IFNULL()
- Views

## 📈 Analysis Performed

The project answers the following business questions:

1. Total spending by each learner with their country.
2. Top 3 most purchased courses by quantity.
3. Total revenue and unique learners by category.
4. Learners who purchased courses from more than one category.
5. Courses that were never purchased.
6. Learners whose spending is above average.
7. Courses priced higher than courses in the Beginner category.
8. Learners spending above their country's average.
9. Learners with total spending above ₹10,000 using a CTE.
10. Learner classification as High, Medium, or Low Value.
11. NULL purchase counts handled using IFNULL().
12. Category performance analysis using a SQL View.

## 💡 Key Insights

- The Advanced category generated the highest revenue in the sample dataset.
- Data Analytics Masterclass generated the highest single purchase amount.
- Python for Beginners showed strong purchase quantity.
- Learners purchasing from multiple categories can be targeted for cross-selling.
- High-value learners can be identified using total spending analysis.

## 🎯 Recommendations

- Focus marketing efforts on high-performing course categories.
- Provide personalized recommendations to high-value learners.
- Promote less-purchased courses using discounts and course bundles.
- Use learner spending patterns for targeted marketing campaigns.
- Regularly monitor category performance to improve business decisions.

## 🛠️ Tools Used

- MySQL
- MySQL Workbench
- GitHub

## 📁 Project Files

- `E_Learning_Platform_Analysis.sql` – Complete MySQL queries
- `E_Learning_Platform_One_Page_Summary.pdf` – Project summary report
- `README.md` – Project documentation

## ✅ Conclusion

This project demonstrates how MySQL can be used to analyze e-learning purchase data and generate useful business insights. SQL techniques such as joins, subqueries, CTEs, CASE expressions, aggregate functions, NULL handling, and views were used to perform the analysis.
