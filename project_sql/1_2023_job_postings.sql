/*
Question: Which of the job postings are relevant?
- Identify job postings that were made in 2023 for companies located in the U.S.
- Bonus: Include company names in each posting
- Why? Our goal is to analyze jobs posted in 2023 that are located
       in the U.S., making all other data irrelevant
*/

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
    date_posted;

/*
Quick Breakdown of the Query Results:
- Over 35,000 distinct job sources (companies)
- Over 200,000 U.S. data jobs posted in 2023
- Yearly salaries ranging from $25,000 to $960,000

Partial Results:
[
  {
    "job_id": 1101176,
    "job_title": "Data Analyst",
    "company_name": "Allegis Group",
    "job_location": "Charlotte, NC",
    "avg_yearly_salary": null,
    "date_posted": "2023-01-01"
  },
  {
    "job_id": 200392,
    "job_title": "Data Scientist",
    "company_name": "Pyramid Consulting, Inc",
    "job_location": "Dallas, TX",
    "avg_yearly_salary": null,
    "date_posted": "2023-01-01"
  },
  {
    "job_id": 916227,
    "job_title": "Data Analyst",
    "company_name": "Health First",
    "job_location": "Melbourne, FL",
    "avg_yearly_salary": null,
    "date_posted": "2023-01-01"
  },

  ...

  {
    "job_id": 177175,
    "job_title": "Data Engineer",
    "company_name": "Regions",
    "job_location": "Hoover, AL",
    "avg_yearly_salary": null,
    "date_posted": "2023-12-31"
  },
  {
    "job_id": 203185,
    "job_title": "Data Engineer",
    "company_name": "Rapinno Tech Inc",
    "job_location": "Plano, TX",
    "avg_yearly_salary": null,
    "date_posted": "2023-12-31"
  },
  {
    "job_id": 1009044,
    "job_title": "Data Analyst",
    "company_name": "Wal-Mart",
    "job_location": "Sunnyvale, CA",
    "avg_yearly_salary": null,
    "date_posted": "2023-12-31"
  }
]
*/