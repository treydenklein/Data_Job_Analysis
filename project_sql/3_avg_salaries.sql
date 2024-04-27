/*
Question: How do the average salaries compare for each role?
- Identify the average salaries grouped by the different job roles
- Why? Yearly salary is a major contributing factor to choosing a
       a career path
*/

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

/*
Quick Breakdown of the Results:
- Specialized roles like 'Senior Data Scientist' and 'Machine Learning Engineer'
  offer the highest salaries
- The more entry level 'Data Analyst' roles come with lower salaries in comparison
- Overall, expertise in data science and related fields correlates with higher
  compensation in the tech industry

Results:
[
  {
    "job_title": "Senior Data Scientist",
    "avg_yearly_salary": "159029"
  },
  {
    "job_title": "Machine Learning Engineer",
    "avg_yearly_salary": "153525"
  },
  {
    "job_title": "Senior Data Engineer",
    "avg_yearly_salary": "150324"
  },
  {
    "job_title": "Data Scientist",
    "avg_yearly_salary": "139974"
  },
  {
    "job_title": "Data Engineer",
    "avg_yearly_salary": "134576"
  },
  {
    "job_title": "Software Engineer",
    "avg_yearly_salary": "134533"
  },
  {
    "job_title": "Cloud Engineer",
    "avg_yearly_salary": "120091"
  },
  {
    "job_title": "Senior Data Analyst",
    "avg_yearly_salary": "115838"
  },
  {
    "job_title": "Business Analyst",
    "avg_yearly_salary": "95934"
  },
  {
    "job_title": "Data Analyst",
    "avg_yearly_salary": "94525"
  }
]
*/