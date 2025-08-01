-- SQL Queries for Bank Loan Analysis

-- Assuming the table name is bank_loan_data and it has the following columns:
-- id, issue_date, loan_amount, total_payment, int_rate, dti, loan_status, address_state, term, emp_length, purpose, home_ownership

-- Total Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data;

-- MTD Loan Applications (Assuming December)
SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12;

-- PMTD Loan Applications (Assuming November)
SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11;

-- Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data;

-- MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12;

-- PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11;

-- Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data;

-- MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12;

-- PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11;

-- Average Interest Rate
SELECT AVG(int_rate) * 100 AS Avg_Int_Rate FROM bank_loan_data;

-- MTD Average Interest
SELECT AVG(int_rate) * 100 AS MTD_Avg_Int_Rate 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12;

-- PMTD Average Interest
SELECT AVG(int_rate) * 100 AS PMTD_Avg_Int_Rate 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11;

-- Avg DTI
SELECT AVG(dti) * 100 AS Avg_DTI FROM bank_loan_data;

-- MTD Avg DTI
SELECT AVG(dti) * 100 AS MTD_Avg_DTI 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12;

-- PMTD Avg DTI
SELECT AVG(dti) * 100 AS PMTD_Avg_DTI 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11;

-- Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) * 100.0) / 
    COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;

-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications 
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount 
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received 
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid', 'Current');

-- Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
    COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received 
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Loan Status Summary
SELECT
   loan_status,
   COUNT(id) AS LoanCount,
   SUM(total_payment) AS Total_Amount_Received,
   SUM(loan_amount) AS Total_Funded_Amount,
   AVG(int_rate) * 100 AS Interest_Rate,
   AVG(dti) * 100 AS DTI
FROM bank_loan_data
GROUP BY loan_status;

-- MTD Loan Status Summary
SELECT 
    loan_status, 
    SUM(total_payment) AS MTD_Total_Amount_Received, 
    SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
GROUP BY loan_status;

-- Month-wise Report
SELECT 
    EXTRACT(MONTH FROM issue_date) AS Month_Number, 
    TO_CHAR(issue_date, 'Month') AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY EXTRACT(MONTH FROM issue_date), TO_CHAR(issue_date, 'Month')
ORDER BY Month_Number;

-- State-wise Report
SELECT 
    address_state AS State, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;

-- Term-wise Report
SELECT 
    term AS Term, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- Employee Length-wise Report
SELECT 
    emp_length AS Employee_Length, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

-- Purpose-wise Report
SELECT 
    purpose AS Purpose, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;

-- Home Ownership-wise Report
SELECT 
    home_ownership AS Home_Ownership, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;
