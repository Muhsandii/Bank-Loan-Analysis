SELECT *
FROM loan_data
LIMIT 10;

SELECT COUNT(*)
FROM loan_data;

SELECT COUNT(*)
FROM loan_data
WHERE annual_income IS NULL;

SELECT
id,
COUNT(*)
FROM loan_data
GROUP BY id
HAVING COUNT(*) > 1;

SELECT
COUNT(*) AS total_data,
COUNT(annual_income) AS income,
COUNT(emp_title) AS employee,
COUNT(emp_length) AS emp_length,
COUNT(int_rate) AS interest,
COUNT(loan_amount) AS loan,
COUNT(total_payment) AS payment
FROM loan_data;

SELECT
loan_status,
COUNT(*) AS total
FROM loan_data
GROUP BY loan_status
ORDER BY total DESC;

SELECT
SUM(loan_amount) AS total_loan
FROM loan_data;

SELECT
ROUND(AVG(loan_amount),2)
FROM loan_data;

SELECT
loan_status,
COUNT(*) AS total,
ROUND(
COUNT(*)*100.0/
SUM(COUNT(*)) OVER(),2
) AS percentage
FROM loan_data
GROUP BY loan_status;

SELECT
MIN(loan_amount),
MAX(loan_amount),
ROUND(AVG(loan_amount),2)
FROM loan_data;

SELECT
MIN(annual_income),
MAX(annual_income),
ROUND(AVG(annual_income),2)
FROM loan_data;

SELECT
MIN(int_rate),
MAX(int_rate),
ROUND(AVG(int_rate),2)
FROM loan_data;

SELECT
grade,
COUNT(*) total
FROM loan_data
GROUP BY grade
ORDER BY grade;

SELECT
purpose,
COUNT(*) total
FROM loan_data
GROUP BY purpose
ORDER BY total DESC;

SELECT
address_state,
COUNT(*) total
FROM loan_data
GROUP BY address_state
ORDER BY total DESC
LIMIT 10;

CREATE VIEW loan_summary AS
SELECT
id,
loan_amount,
annual_income,
loan_status,
purpose,
grade,
address_state,
int_rate
FROM loan_data;

SELECT *
FROM loan_summary
LIMIT 10;