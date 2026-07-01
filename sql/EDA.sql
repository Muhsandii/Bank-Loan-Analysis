SELECT 
SUM(loan_amount) AS total_loan_disbursed
FROM loan_data;

SELECT
SUM(total_payment) AS total_payment_received
FROM loan_data;

SELECT
ROUND(AVG(loan_amount),2) AS avg_loan
FROM loan_data;

SELECT
ROUND(AVG(int_rate),2) AS avg_interest_rate
FROM loan_data;

SELECT
ROUND(AVG(annual_income),2) AS avg_income
FROM loan_data;

SELECT
loan_status,
COUNT(*) AS total_loans,
ROUND(
COUNT(*)*100.0/
SUM(COUNT(*)) OVER(),2
) AS percentage
FROM loan_data
GROUP BY loan_status
ORDER BY total_loans DESC;

SELECT
purpose,
COUNT(*) total,
ROUND(SUM(loan_amount),2) total_loan
FROM loan_data
GROUP BY purpose
ORDER BY total_loan DESC;

SELECT
grade,
COUNT(*) total_loans,
ROUND(AVG(int_rate),2) avg_interest,
ROUND(AVG(loan_amount),2) avg_loan
FROM loan_data
GROUP BY grade
ORDER BY grade;

SELECT
home_ownership,
COUNT(*) total,
ROUND(AVG(loan_amount),2) avg_loan
FROM loan_data
GROUP BY home_ownership
ORDER BY total DESC;

SELECT
address_state,
COUNT(*) total_loans,
SUM(loan_amount) total_amount
FROM loan_data
GROUP BY address_state
ORDER BY total_amount DESC
LIMIT 10;

SELECT
emp_length,
COUNT(*) total
FROM loan_data
GROUP BY emp_length
ORDER BY total DESC;

SELECT
verification_status,
COUNT(*) total,
ROUND(AVG(loan_amount),2) avg_loan
FROM loan_data
GROUP BY verification_status;

SELECT
DATE_TRUNC('month', issue_date) AS month,
COUNT(*) total_loans,
SUM(loan_amount) total_amount
FROM loan_data
GROUP BY month
ORDER BY month;

SELECT
purpose,
ROUND(AVG(int_rate),2) avg_interest
FROM loan_data
GROUP BY purpose
ORDER BY avg_interest DESC;

SELECT
id,
purpose,
grade,
loan_amount,
annual_income
FROM loan_data
ORDER BY loan_amount DESC
LIMIT 10;

SELECT
CASE
WHEN dti < 10 THEN 'Low'
WHEN dti < 20 THEN 'Medium'
WHEN dti < 30 THEN 'High'
ELSE 'Very High'
END AS dti_category,
COUNT(*) total
FROM loan_data
GROUP BY dti_category;

SELECT
term,
COUNT(*) total,
ROUND(AVG(loan_amount),2) avg_loan
FROM loan_data
GROUP BY term;

SELECT
COUNT(*) AS total_applications,
SUM(loan_amount) AS total_funded,
SUM(total_payment) AS total_received,
ROUND(AVG(int_rate),2) AS avg_interest,
ROUND(AVG(dti),2) AS avg_dti
FROM loan_data;

/* ==========================================================
EDA 01 - Total Loan Portfolio
Business Question:
How much loan has been funded?

Expected Insight:
Understand the overall size of the lending portfolio.
========================================================== */

SELECT
    SUM(loan_amount) AS total_loan_disbursed
FROM loan_data;