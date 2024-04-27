# Introduction

- This Project Explores the 2023 Market for Data-Related Jobs
- Investigating:
  - 💰 Top-Paying Jobs
  - 🔥 In-Demand Skills
  - 📈 Where High Demand meets High Salary in the World of Data

# The Tools I Used

- **SQL:** Running queries on the project database and revealing initial insights
- **Python:** Primarily used for data visualization here
  - **Libraries:** Pandas, Numpy, Matplotlib
- **PostgreSQL:** Database management system
- **Visual Studio Code:** My preferred IDE for project management and executing scripts in various programming languages
- **Git & GitHub:** Version control, project tracking, and sharing my scripts + analysis

### Initial SQL Queries - Questions to Answer:

1. What are the average salaries for the different data-related job roles?
2. Which job roles are the most in-demand?
3. What skills are most needed for the various job roles?
4. What are the most optimal skills to learn - based on demand and pay?

# Analysis

### 1. Average Salaries for the Different Data-Related Job Roles

SQL Query:

- Filter job postings by the year (2023) and the country that the job is located (U.S.)
- Group the data by job title and calculate average salary for each

```sql
-- Use Query #1 as a CTE
WITH postings AS (
    SELECT
        job_postings.job_id AS job_id,
        job_postings.job_title_short AS job_title,
        companies_dim.name AS company_name,
        job_postings.job_location AS job_location,
        job_postings.salary_year_avg AS avg_yearly_salary,
        job_postings.job_posted_date::DATE AS date_posted
    FROM
        job_postings
    JOIN companies_dim ON
        companies_dim.company_id = job_postings.company_id
    WHERE
        job_postings.job_country = 'United States' AND
        EXTRACT(YEAR FROM job_postings.job_posted_date) = 2023
    ORDER BY
        date_posted
)

-- Return the average salaries for each role from the CTE above
SELECT
    postings.job_title,
    ROUND(AVG(postings.avg_yearly_salary), 0) AS avg_yearly_salary
FROM
    postings
GROUP BY
    job_title
ORDER BY
    avg_yearly_salary DESC;
```

Here is a breakdown of the results:

- Specialized roles like **Senior Data Scientist** and **Machine Learning Engineer** offer the highest salaries
- The more entry level **Data Analyst** roles come with lower salaries in comparison
- Overall, expertise in data science and related fields correlate with higher compensation in the job market

![Average Salary by Role](assets/avg_salary_by_job.png)
_Bar graph visualizing the average salary for each job role, comparing each to the 2023 Median Salary for the U.S._

### 2. Market Demand by Job Title

- Filter job postings by the year (2023) and the country that the job is located (U.S.)
- Group the data by job title and calculate the number of job postings for each

```sql
-- Use Query #1 as a CTE
WITH postings AS (
    SELECT
        job_postings.job_id AS job_id,
        job_postings.job_title_short AS job_title,
        companies_dim.name AS company_name,
        job_postings.job_location AS job_location,
        job_postings.salary_year_avg AS avg_yearly_salary,
        job_postings.job_posted_date::DATE AS date_posted
    FROM
        job_postings
    JOIN companies_dim ON
        companies_dim.company_id = job_postings.company_id
    WHERE
        job_postings.job_country = 'United States' AND
        EXTRACT(YEAR FROM job_postings.job_posted_date) = 2023
    ORDER BY
        date_posted
)

-- Return the demand for each job using the CTE above
SELECT
    job_title,
    COUNT(job_title) AS job_count
FROM
    postings
GROUP BY
    job_title
ORDER BY
    job_count DESC;
```

Here is a breakdown of the results:

- The tech/data field, in general, is a highly demanded career path
- **Data Analyst/Scientist** roles are needed the most, by far
- **Machine Learning/Cloud Engineering** is more of a niche market

![Demand by Role](assets/demand_by_job.png)
_Bar graph visualizing the demand for each position, based on the number of 2023 job postings_
