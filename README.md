# HR Analytics Dashboard | SQL + Power BI

## Project Overview

This project demonstrates an end-to-end HR Analytics workflow using **MySQL** and **Power BI**.

The project begins with a messy HR dataset containing multiple data quality issues. SQL was used to clean, standardize, and validate the data before importing it into Power BI for visualization and business analysis.

The final output is an interactive HR dashboard that provides workforce insights such as employee distribution, hiring trends, salary analysis, and employment status.

---

## Objectives

- Practice SQL Data Cleaning
- Handle real-world messy HR data
- Perform data validation
- Create meaningful KPIs
- Build an interactive HR dashboard in Power BI
- Generate business insights for HR management

---

## Tools Used

- MySQL Workbench
- Power BI Desktop
- DAX

---

## Dataset Information

### Columns

| Column | Description |
|---------|-------------|
| Employee_ID | Employee Identifier |
| Employee_Name | Employee Name |
| Department | Department Name |
| Position | Job Position |
| Hire_Date | Employee Hire Date |
| Salary | Employee Salary |
| Employment_Status | Active / Inactive / On Leave |
| Manager_Name | Reporting Manager |
| City | Employee Location |
| Performance_Rating | Employee Rating |

---

# Data Quality Issues

The dataset intentionally contains various real-world data problems.

### Missing Values

- NULL
- Blank Cells
- N/A

### Inconsistent Formatting

Examples

```
IT
it

HR
HR

Manila
manila
```

### Mixed Date Formats

```
2024-01-15
01/15/2024
15-01-2024
```

### Invalid Salary Formats

```
85000
$85,000
NULL
```

### Other Issues

- Leading spaces
- Trailing spaces
- Mixed capitalization
- Duplicate-like records
- Missing employee names

---

# SQL Data Cleaning Process

The following cleaning steps were performed:

- Created a working table
- Removed leading and trailing spaces
- Standardized text values
- Converted inconsistent capitalization
- Handled NULL and blank values
- Cleaned salary values
- Standardized hire dates
- Removed invalid values
- Performed data validation

---

# Power BI Dashboard

The cleaned dataset was imported into Power BI to create an HR Analytics Dashboard.

## KPI Cards

- Total Employees
- Active Employees
- Average Salary
- Average Performance Rating

## Visualizations

- Hiring Trend by Year
- Employees by Department
- Employment Status Distribution

---

# Dashboard Preview
```
HR.JPG
```
---

# Business Insights

Some insights generated from the dashboard include:

- Employee distribution across departments
- Hiring trend over time
- Percentage of active and inactive employees
- Average employee salary
- Workforce performance overview

# Skills Demonstrated

## SQL

- SELECT
- UPDATE
- CASE
- TRIM
- REPLACE
- CAST
- Data Cleaning
- Data Validation

## Power BI

- Data Import
- DAX
- KPI Cards
- Interactive Dashboard
- Data Visualization

## Analytics

- Data Cleaning
- Data Validation
- HR Analytics
- KPI Development
- Dashboard Design

## Author

**Rajahmuden Dalaten**

Aspiring Data Analyst

**Skills**

- SQL
- Power BI
- Excel
