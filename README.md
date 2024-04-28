# Introduction

- This Project Explores the 2023 Market for Data-Related Jobs
- Investigating:
  - 💰 Top-Paying Jobs
  - 🔥 In-Demand Skills
  - 📈 Where High Demand Meets High Salary in the World of Data

# The Tools I Used

- **SQL:** Running queries on the project database and revealing initial insights
- **Python:** For this project, Python is primarily used for data visualization
  - **Libraries:** Pandas, Numpy, Matplotlib
- **PostgreSQL:** Database Management
- **Visual Studio Code:** My preferred IDE for project management and executing scripts in various programming languages
- **Git & GitHub:** Version control, project tracking, and sharing my scripts + analysis

### Initial SQL Queries - Questions to Answer:

1. Compensation: What are the average salaries for the different data-related job roles?
2. Market Demand: Which job roles are the most in-demand?
3. Job Essentials: What skills are most needed for the various job roles?
4. Valuable Skills: What are the most optimal skills to learn - based on demand and pay?

# Analysis

### 1. Average Salaries for the Different Data-Related Job Roles

#### SQL Query:

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

#### Breakdown of the Results:

- Specialized roles like **Senior Data Scientist** and **Machine Learning Engineer** offer the highest salaries
- The more entry level **Data Analyst** roles come with lower salaries in comparison
- Overall, expertise in data science and related fields correlate with higher compensation in the job market

![Average Salary by Role](assets/avg_salary_by_job.png)
_Bar graph visualizing the average salary for each job role, comparing each to the 2023 Median Salary for the U.S._

### 2. Market Demand by Job Title

#### SQL Query:

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

#### Breakdown of the Results:

- The tech/data field, in general, is a highly demanded career path
- **Data Analyst/Scientist** roles are needed the most, by far
- **Machine Learning/Cloud Engineering** is more of a niche market

![Demand by Role](assets/demand_by_job.png)
_Bar graph visualizing the demand for each position, based on the number of 2023 job postings_

### 3. What Skills are Needed the Most for Each Position?

#### SQL Query:

- Filter job postings by the year (2023) and the country that the job is located (U.S.)
- Rank each skill according to its demand in each role
- Return the top 5 skills for each role based on the rankings

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
        job_postings.job_country = 'United States'
        AND EXTRACT(YEAR FROM job_postings.job_posted_date) = 2023
    ORDER BY
        date_posted
),
-- Rank each skill according to its demand in each role
ranked_skills AS (
    SELECT
        postings.job_title AS job_title,
        skills_dim.skills AS skills,
        COUNT(job_skills_dim.job_id) AS demand_count,
        ROW_NUMBER() OVER (PARTITION BY postings.job_title ORDER BY COUNT(job_skills_dim.job_id) DESC) AS skill_rank
    FROM
        postings
    JOIN job_skills_dim ON
        postings.job_id = job_skills_dim.job_id
    JOIN skills_dim ON
        job_skills_dim.skill_id = skills_dim.skill_id
    GROUP BY
        job_title,
        skills
)

-- Return the top 5 skills for each role based on the rankings
SELECT
    job_title,
    skills,
    demand_count
FROM
    ranked_skills
WHERE
    skill_rank <= 5;
```

#### Breakdown of the Results:

- **SQL:** Important for data-related roles
- **Python:** Valued across various positions
- **Excel:** Useful for business analysis
- **Tableau:** Key for data visualization
- **Cloud Skills (AWS, Azure):** Increasingly in demand for engineering roles
- **R and SAS:** Still relevant but less common
- **Machine Learning Frameworks:** Mentioned for Machine Learning Engineer roles, but less prevalent

![Top 5 Skills for Business Analyst](assets/top_5_skills_for_business_analyst.png)
_Bar graph visualizing the top 5 skills for Business Analyst roles, based on the frequency of mentions in job postings_

![Top 5 Skills for Cloud Engineer](assets/top_5_skills_for_cloud_engineer.png)
_Bar graph visualizing the top 5 skills for Cloud Engineer roles, based on the frequency of mentions in job postings_

![Top 5 Skills for Data Analyst](assets/top_5_skills_for_data_analyst.png)
_Bar graph visualizing the top 5 skills for Data Analyst roles, based on the frequency of mentions in job postings_

![Top 5 Skills for Data Engineer](assets/top_5_skills_for_data_engineer.png)
_Bar graph visualizing the top 5 skills for Data Engineer roles, based on the frequency of mentions in job postings_

![Top 5 Skills for Data Scientist](assets/top_5_skills_for_data_scientist.png)
_Bar graph visualizing the top 5 skills for Data Scientist roles, based on the frequency of mentions in job postings_

![Top 5 Skills for Machine Learning Engineer](assets/top_5_skills_for_machine_learning_engineer.png)
_Bar graph visualizing the top 5 skills for Machine Learning Engineer roles, based on the frequency of mentions in job postings_

![Top 5 Skills for Senior Data Analyst](assets/top_5_skills_for_senior_data_analyst.png)
_Bar graph visualizing the top 5 skills for Senior Data Analyst roles, based on the frequency of mentions in job postings_

![Top 5 Skills for Senior Data Engineer](assets/top_5_skills_for_senior_data_engineer.png)
_Bar graph visualizing the top 5 skills for Senior Data Engineer roles, based on the frequency of mentions in job postings_

![Top 5 Skills for Senior Data Scientist](assets/top_5_skills_for_senior_data_scientist.png)
_Bar graph visualizing the top 5 skills for Senior Data Scientist roles, based on the frequency of mentions in job postings_

![Top 5 Skills for Software Engineer](assets/top_5_skills_for_software_engineer.png)
_Bar graph visualizing the top 5 skills for Software Engineer roles, based on the frequency of mentions in job postings_

### 4. Most Optimal Skills to Learn

#### SQL Query:

- Filter job postings by the year (2023) and the country that the job is located (U.S.)
- Group data by skill and calculate demand and average salary for each
- Return the first 10 rows after ordering data by demand and average salary in descending order

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

-- Return top 10 skills with the highest demand and avg salary
SELECT
    skills_dim.skill_id AS skill_id,
    skills_dim.skills AS skills,
    COUNT(job_skills_dim.job_id) AS demand_count,
    ROUND(AVG(postings.avg_yearly_salary), 0) AS avg_salary
FROM
    postings
INNER JOIN job_skills_dim ON
    postings.job_id = job_skills_dim.job_id
INNER JOIN skills_dim ON
    job_skills_dim.skill_id = skills_dim.skill_id
GROUP BY
    skills_dim.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 10;
```

#### Breakdown of the Results:

- **SQL** and **Python** are the most in-demand skills overall
- Focus on **SQL**, **Python**, **AWS**, and **Spark** for high-paying, in-demand roles
- Despite lower demand, **Java** still offers good pay
- **Excel** and **Power BI** roles are plentiful, but with lower average pay

![Most Optimal Skills to Learn](assets/most_optimal_skills_to_learn.png)
_Bar graph visualizing the top 10 skills to learn, based on market demand and average salary_

# Conclusions

### Insights

1. **Job Demand in the Tech/Data Field:** The demand for tech and data-related roles is strong, with Data Analyst and Data Scientist positions leading the pack.
2. **Emphasis on SQL and Python:** SQL and Python lead in demand and offer a higher salary on average, making them the most optimal skills for anyone looking for data-related roles to learn and maximize their market value.
3. **Path to Higher-Paying Roles:** Most data-related roles have similar skills in-demand, making it more accessible to start with the basics and work your way up from an entry level position to a more specialized niche.

### Closing Thoughts

This project enhanced my SQL and Data Visualization skills and provided valuable insights into the market for data-related jobs. The findings and analysis serve as a guide to prioritizing skill development and job search efforts. It also highlights the importance of continuous learning and adapting to emerging trends in the field of data.
