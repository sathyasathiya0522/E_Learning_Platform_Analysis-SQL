-- INNER JOIN

USE elearning_platform;

SELECT
    l.full_name AS Learner_Name,
    c.course_name AS Course_Name,
    c.category AS Category,
    p.quantity AS Quantity,
    FORMAT(p.quantity * c.unit_price, 2) AS Total_Amount,
    p.purchase_date AS Purchase_Date
FROM purchases p
INNER JOIN learners l
    ON p.learner_id = l.learner_id
INNER JOIN courses c
    ON p.course_id = c.course_id
ORDER BY (p.quantity * c.unit_price) DESC;

-- LEFT JOIN

SELECT
    l.full_name AS Learner_Name,
    c.course_name AS Course_Name,
    c.category AS Category,
    p.quantity AS Quantity,
    FORMAT(p.quantity * c.unit_price, 2) AS Total_Amount,
    p.purchase_date AS Purchase_Date
FROM learners l
LEFT JOIN purchases p
    ON l.learner_id = p.learner_id
LEFT JOIN courses c
    ON p.course_id = c.course_id
ORDER BY (p.quantity * c.unit_price) DESC;

-- RIGHT JOIN

SELECT
    l.full_name AS Learner_Name,
    c.course_name AS Course_Name,
    c.category AS Category,
    p.quantity AS Quantity,
    FORMAT(p.quantity * c.unit_price, 2) AS Total_Amount,
    p.purchase_date AS Purchase_Date
FROM purchases p
RIGHT JOIN courses c
    ON p.course_id = c.course_id
LEFT JOIN learners l
    ON p.learner_id = l.learner_id
ORDER BY (p.quantity * c.unit_price) DESC;


-- Q1: Total spending by each learner

SELECT
    l.full_name AS Learner_Name,
    l.country AS Country,
    FORMAT(SUM(p.quantity * c.unit_price), 2) AS Total_Spending
FROM learners l
JOIN purchases p
    ON l.learner_id = p.learner_id
JOIN courses c
    ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name, l.country
ORDER BY SUM(p.quantity * c.unit_price) DESC;

-- Q2: Top 3 most purchased courses by quantity

SELECT
    c.course_name AS Course_Name,
    SUM(p.quantity) AS Total_Quantity
FROM courses c
JOIN purchases p
    ON c.course_id = p.course_id
GROUP BY c.course_id, c.course_name
ORDER BY Total_Quantity DESC
LIMIT 3;

-- Q3: Total revenue and unique learners by category

SELECT
    c.category AS Category,
    FORMAT(SUM(p.quantity * c.unit_price), 2) AS Total_Revenue,
    COUNT(DISTINCT p.learner_id) AS Unique_Learners
FROM courses c
JOIN purchases p
    ON c.course_id = p.course_id
GROUP BY c.category
ORDER BY SUM(p.quantity * c.unit_price) DESC;

-- Q4: Learners who purchased from more than one category

SELECT
    l.full_name AS Learner_Name,
    COUNT(DISTINCT c.category) AS Categories_Purchased
FROM learners l
JOIN purchases p
    ON l.learner_id = p.learner_id
JOIN courses c
    ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name
HAVING COUNT(DISTINCT c.category) > 1;

-- Q5: Identify courses never purchased

SELECT
    c.course_id AS Course_ID,
    c.course_name AS Course_Name,
    c.category AS Category
FROM courses c
LEFT JOIN purchases p
    ON c.course_id = p.course_id
WHERE p.purchase_id IS NULL;

-- Q6: Learners whose total spending is above average learner spending

SELECT
    l.full_name AS Learner_Name,
    SUM(p.quantity * c.unit_price) AS Total_Spending
FROM learners l
JOIN purchases p
    ON l.learner_id = p.learner_id
JOIN courses c
    ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name
HAVING SUM(p.quantity * c.unit_price) >
(
    SELECT AVG(Learner_Total)
    FROM
    (
        SELECT
            SUM(p2.quantity * c2.unit_price) AS Learner_Total
        FROM purchases p2
        JOIN courses c2
            ON p2.course_id = c2.course_id
        GROUP BY p2.learner_id
    ) AS Spending_Table
);

-- Q7: Courses priced higher than any Beginner course

SELECT
    course_name AS Course_Name,
    category AS Category,
    unit_price AS Unit_Price
FROM courses
WHERE unit_price > ANY
(
    SELECT unit_price
    FROM courses
    WHERE category = 'Beginner'
);

-- Q8: Learners who spent more than
-- the average spending in their country

SELECT
    l.full_name AS Learner_Name,
    l.country AS Country,
    SUM(p.quantity * c.unit_price) AS Total_Spending
FROM learners l
JOIN purchases p
    ON l.learner_id = p.learner_id
JOIN courses c
    ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name, l.country
HAVING SUM(p.quantity * c.unit_price) >
(
    SELECT AVG(Country_Spending)
    FROM
    (
        SELECT
            SUM(p2.quantity * c2.unit_price) AS Country_Spending
        FROM learners l2
        JOIN purchases p2
            ON l2.learner_id = p2.learner_id
        JOIN courses c2
            ON p2.course_id = c2.course_id
        WHERE l2.country = l.country
        GROUP BY l2.learner_id
    ) AS Country_Average
);

-- Q9: CTE to find learners spending above 10,000

WITH LearnerSpending AS
(
    SELECT
        l.learner_id,
        l.full_name,
        SUM(p.quantity * c.unit_price) AS Total_Spending
    FROM learners l
    JOIN purchases p
        ON l.learner_id = p.learner_id
    JOIN courses c
        ON p.course_id = c.course_id
    GROUP BY l.learner_id, l.full_name
)

SELECT
    full_name AS Learner_Name,
    Total_Spending
FROM LearnerSpending
WHERE Total_Spending > 10000
ORDER BY Total_Spending DESC;

-- Q10: Classify learners based on total spending

SELECT
    l.full_name AS Learner_Name,
    SUM(p.quantity * c.unit_price) AS Total_Spending,
    CASE
        WHEN SUM(p.quantity * c.unit_price) > 15000
            THEN 'High Value'
        WHEN SUM(p.quantity * c.unit_price) >= 8000
            THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Learner_Category
FROM learners l

-- Q11: NULL Handling using IFNULL()

SELECT
    c.course_name AS Course_Name,
    c.category AS Category,
    IFNULL(pc.Purchase_Count, 0) AS Purchase_Count
FROM courses c
LEFT JOIN
(
    SELECT
        course_id,
        COUNT(*) AS Purchase_Count
    FROM purchases
    GROUP BY course_id
) pc
    ON c.course_id = pc.course_id;
    
-- Q12: Create Category Performance View

SELECT * FROM category_performance_view;

-- Q12: Create Category Performance View

CREATE VIEW category_performance_view AS

SELECT
    c.category AS Category,
    SUM(p.quantity * c.unit_price) AS Total_Revenue,
    COUNT(p.purchase_id) AS Number_of_Purchases,
    AVG(p.quantity * c.unit_price) AS Average_Revenue_Per_Purchase
FROM courses c
JOIN purchases p
    ON c.course_id = p.course_id
GROUP BY c.category;