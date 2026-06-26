WITH ranked_loans AS (
    SELECT
        address_state,
        id,
        loan_amount,
        ROW_NUMBER() OVER (
            PARTITION BY address_state
            ORDER BY loan_amount DESC
        ) AS rn
    FROM loan_data
)

SELECT *
FROM ranked_loans
WHERE rn <= 3;

SELECT
    grade,
    SUM(loan_amount) AS total_loan,
    DENSE_RANK() OVER(
        ORDER BY SUM(loan_amount) DESC
    ) AS ranking
FROM loan_data
GROUP BY grade;

SELECT
    id,
    annual_income,
    NTILE(5) OVER(
        ORDER BY annual_income
    ) AS income_group
FROM loan_data;

SELECT
    issue_date,
    loan_amount,
    SUM(loan_amount)
    OVER(
        ORDER BY issue_date
    ) AS cumulative_loan
FROM loan_data;

SELECT
issue_date,
loan_amount,
ROUND(
AVG(loan_amount)
OVER(
ORDER BY issue_date
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
),2)
AS moving_average
FROM loan_data;

SELECT
purpose,
SUM(loan_amount),
ROUND(
100*
SUM(loan_amount) / SUM(SUM(loan_amount))
OVER()
,2)
AS contribution
FROM loan_data
GROUP BY purpose;

SELECT
id,
grade,
loan_amount,
AVG(loan_amount)
OVER(PARTITION BY grade)
AS avg_grade_loan
FROM loan_data;

SELECT
id, grade, loan_amount,
AVG(loan_amount)
OVER(PARTITION BY grade)
AS avg_grade, loan_amount-
AVG(loan_amount)
OVER(PARTITION BY grade)
AS difference
FROM loan_data;

CREATE VIEW vw_dashboard_summary AS

SELECT
COUNT(*) total_application,
SUM(loan_amount) total_funded,
SUM(total_payment) total_received,
ROUND(AVG(int_rate),2) avg_interest,
ROUND(AVG(dti),2) avg_dti
FROM loan_data;

CREATE VIEW vw_monthly_summary AS
SELECT DATE_TRUNC('month', issue_date) AS loan_month,
COUNT(*) AS applications,
SUM(loan_amount) AS funded,
SUM(total_payment) AS received
FROM loan_data
GROUP BY DATE_TRUNC('month', issue_date)
ORDER BY DATE_TRUNC('month', issue_date);

CREATE VIEW vw_state_summary AS
SELECT address_state,
COUNT(*) applications,
SUM(loan_amount) funded,
SUM(total_payment) received
FROM loan_data
GROUP BY address_state;

CREATE VIEW vw_purpose_summary AS
SELECT purpose,
COUNT(*) applications,
SUM(loan_amount) funded
FROM loan_data
GROUP BY purpose;