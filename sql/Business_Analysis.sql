/* ==========================================
KPI Dashboard
========================================== */

SELECT
    COUNT(*) AS total_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount,
    ROUND(AVG(int_rate),2) AS avg_interest_rate,
    ROUND(AVG(dti),2) AS avg_dti
FROM loan_data;

SELECT
CASE
WHEN loan_status IN ('Fully Paid','Current')
THEN 'Good Loan'
ELSE 'Bad Loan'
END AS loan_quality,
COUNT(*) total_applications,
SUM(loan_amount) funded_amount,
SUM(total_payment) payment_received
FROM loan_data
GROUP BY loan_quality;

SELECT
ROUND(100.0 *SUM(CASE
WHEN loan_status IN ('Fully Paid','Current')
THEN 1
ELSE 0
END
)
/COUNT(*),2)
AS good_loan_percentage
FROM loan_data;

SELECT
grade,
COUNT(*) total_loans,
SUM(loan_amount) funded,
SUM(total_payment) received,
ROUND(AVG(int_rate),2) avg_interest
FROM loan_data
GROUP BY grade
ORDER BY grade;

SELECT
grade,
COUNT(*) total,SUM(
CASE
WHEN loan_status='Charged Off'
THEN 1
ELSE 0
END
) charged_off,ROUND(100.0*
SUM(CASE
WHEN loan_status='Charged Off'
THEN 1
ELSE 0
END
)/COUNT(*),2) default_rate
FROM loan_data
GROUP BY grade
ORDER BY default_rate DESC;

SELECT purpose,
SUM(loan_amount) total_loan,
COUNT(*) applications
FROM loan_data
GROUP BY purpose
ORDER BY total_loan DESC;

SELECT address_state,
SUM(loan_amount) total_loan,
RANK() OVER(
ORDER BY SUM(loan_amount) 
DESC) state_rank
FROM loan_data
GROUP BY address_state;

SELECT
address_state,
SUM(total_payment) total_received,
RANK() OVER(
ORDER BY SUM(total_payment) DESC
) payment_rank
FROM loan_data
GROUP BY address_state;

WITH monthly AS (
    SELECT
        DATE_TRUNC('month', issue_date) AS month,
        SUM(loan_amount) AS total_loan
    FROM loan_data
    GROUP BY DATE_TRUNC('month', issue_date)
)

SELECT
    month,
    total_loan,
    LAG(total_loan) OVER (ORDER BY month) AS previous_month,
    ROUND(
        (
            total_loan - LAG(total_loan) OVER (ORDER BY month)
        ) * 100.0
        /
        LAG(total_loan) OVER (ORDER BY month),
        2
    ) AS growth_percentage
FROM monthly
ORDER BY month;

SELECT
id, purpose, grade, loan_amount,
RANK()
OVER(
ORDER BY loan_amount DESC)
AS ranking
FROM loan_data
LIMIT 10;

SELECT
CASE
WHEN annual_income <50000 THEN 'Low'
WHEN annual_income <100000 THEN 'Middle'
ELSE 'High'
END income_group,
COUNT(*) total_customer,
ROUND(AVG(loan_amount),2) avg_loan
FROM loan_data
GROUP BY income_group;

SELECT
grade, home_ownership,
COUNT(*) total,
SUM(
CASE
WHEN loan_status='Charged Off'
THEN 1
ELSE 0
END
) bad_loan
FROM loan_data
GROUP BY grade,home_ownership
ORDER BY grade;

SELECT
purpose,
SUM(total_payment) payment,
RANK()
OVER(
ORDER BY SUM(total_payment) DESC
)
AS rank
FROM loan_data
GROUP BY purpose;

SELECT
purpose,
ROUND(
100*
SUM(loan_amount) / SUM(SUM(loan_amount))
OVER()
,2)
portfolio_percentage
FROM loan_data
GROUP BY purpose
ORDER BY portfolio_percentage DESC;

WITH state_summary AS (
SELECT
address_state,
SUM(loan_amount) total_loan,
SUM(total_payment) total_payment
FROM loan_data
GROUP BY address_state
)

SELECT
*,
RANK()
OVER(
ORDER BY total_loan DESC
)
AS loan_rank,
DENSE_RANK()
OVER(
ORDER BY total_payment DESC
)
AS payment_rank
FROM state_summary;