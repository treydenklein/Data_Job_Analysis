/*
Question: How do the job roles compare, in terms of job market demand?
- Identify the demand for each job role by counting the number of
  postings associated with each
- Why? Knowing the demand could be a contributing factor when choosing
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

/*
Quick Breakdown of the Query Results:
- The tech/data field, in general, is a highly demanded career path
- Data Analyst/Scientist roles are needed the most, by far
- Machine Learning/Cloud Engineering is more of a niche market

Results:
[
  {
    "job_title": "Data Analyst",
    "job_count": "67837"
  },
  {
    "job_title": "Data Scientist",
    "job_count": "58927"
  },
  {
    "job_title": "Data Engineer",
    "job_count": "35065"
  },
  {
    "job_title": "Senior Data Scientist",
    "job_count": "12940"
  },
  {
    "job_title": "Senior Data Analyst",
    "job_count": "11809"
  },
  {
    "job_title": "Senior Data Engineer",
    "job_count": "9404"
  },
  {
    "job_title": "Business Analyst",
    "job_count": "7391"
  },
  {
    "job_title": "Software Engineer",
    "job_count": "1816"
  },
  {
    "job_title": "Machine Learning Engineer",
    "job_count": "944"
  },
  {
    "job_title": "Cloud Engineer",
    "job_count": "415"
  }
]
*/