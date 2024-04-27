/*
Question: What skills are in demand for each data related role?
- Identify the top 5 roles skills in demand for each role
- Bonus: Join with skills_dim table to include skill names
- Why? Retrieves the top 5 demanded skills in the job market for
       each role, providing insight into valuable skills for job seekers
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
),
-- Rank each skill according to demand for each role
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

-- Return the top 5 skills for each role based on its ranking
SELECT
    job_title,
    skills,
    demand_count
FROM
    ranked_skills
WHERE
    skill_rank <= 5;

/*
Quick Breakdown of the Results:
- SQL: Important for data-related roles
- Python: Valued across various positions
- Excel: Useful for business analysis
- Tableau: Key for data visualization
- Cloud Skills (AWS, Azure): Increasingly in demand for engineering roles
- R and SAS: Still relevant but less common
- Machine Learning Frameworks: Mentioned for Machine Learning Engineer roles, but less prevalent

Results:
[
  {
    "job_title": "Business Analyst",
    "skills": "sql",
    "demand_count": "3564"
  },
  {
    "job_title": "Business Analyst",
    "skills": "excel",
    "demand_count": "3136"
  },
  {
    "job_title": "Business Analyst",
    "skills": "tableau",
    "demand_count": "2212"
  },
  {
    "job_title": "Business Analyst",
    "skills": "power bi",
    "demand_count": "1558"
  },
  {
    "job_title": "Business Analyst",
    "skills": "python",
    "demand_count": "1406"
  },
  {
    "job_title": "Cloud Engineer",
    "skills": "sql",
    "demand_count": "132"
  },
  {
    "job_title": "Cloud Engineer",
    "skills": "python",
    "demand_count": "119"
  },
  {
    "job_title": "Cloud Engineer",
    "skills": "aws",
    "demand_count": "102"
  },
  {
    "job_title": "Cloud Engineer",
    "skills": "excel",
    "demand_count": "78"
  },
  {
    "job_title": "Cloud Engineer",
    "skills": "azure",
    "demand_count": "62"
  },
  {
    "job_title": "Data Analyst",
    "skills": "sql",
    "demand_count": "34450"
  },
  {
    "job_title": "Data Analyst",
    "skills": "excel",
    "demand_count": "27519"
  },
  {
    "job_title": "Data Analyst",
    "skills": "tableau",
    "demand_count": "19324"
  },
  {
    "job_title": "Data Analyst",
    "skills": "python",
    "demand_count": "18383"
  },
  {
    "job_title": "Data Analyst",
    "skills": "sas",
    "demand_count": "13228"
  },
  {
    "job_title": "Data Engineer",
    "skills": "sql",
    "demand_count": "23963"
  },
  {
    "job_title": "Data Engineer",
    "skills": "python",
    "demand_count": "22739"
  },
  {
    "job_title": "Data Engineer",
    "skills": "aws",
    "demand_count": "14979"
  },
  {
    "job_title": "Data Engineer",
    "skills": "spark",
    "demand_count": "11283"
  },
  {
    "job_title": "Data Engineer",
    "skills": "azure",
    "demand_count": "11265"
  },
  {
    "job_title": "Data Scientist",
    "skills": "python",
    "demand_count": "42401"
  },
  {
    "job_title": "Data Scientist",
    "skills": "sql",
    "demand_count": "30082"
  },
  {
    "job_title": "Data Scientist",
    "skills": "r",
    "demand_count": "26056"
  },
  {
    "job_title": "Data Scientist",
    "skills": "sas",
    "demand_count": "14480"
  },
  {
    "job_title": "Data Scientist",
    "skills": "tableau",
    "demand_count": "13857"
  },
  {
    "job_title": "Machine Learning Engineer",
    "skills": "python",
    "demand_count": "662"
  },
  {
    "job_title": "Machine Learning Engineer",
    "skills": "sql",
    "demand_count": "308"
  },
  {
    "job_title": "Machine Learning Engineer",
    "skills": "tensorflow",
    "demand_count": "287"
  },
  {
    "job_title": "Machine Learning Engineer",
    "skills": "aws",
    "demand_count": "281"
  },
  {
    "job_title": "Machine Learning Engineer",
    "skills": "pytorch",
    "demand_count": "266"
  },
  {
    "job_title": "Senior Data Analyst",
    "skills": "sql",
    "demand_count": "7817"
  },
  {
    "job_title": "Senior Data Analyst",
    "skills": "tableau",
    "demand_count": "4682"
  },
  {
    "job_title": "Senior Data Analyst",
    "skills": "python",
    "demand_count": "4268"
  },
  {
    "job_title": "Senior Data Analyst",
    "skills": "excel",
    "demand_count": "4026"
  },
  {
    "job_title": "Senior Data Analyst",
    "skills": "sas",
    "demand_count": "3098"
  },
  {
    "job_title": "Senior Data Engineer",
    "skills": "python",
    "demand_count": "6771"
  },
  {
    "job_title": "Senior Data Engineer",
    "skills": "sql",
    "demand_count": "6749"
  },
  {
    "job_title": "Senior Data Engineer",
    "skills": "aws",
    "demand_count": "4895"
  },
  {
    "job_title": "Senior Data Engineer",
    "skills": "spark",
    "demand_count": "3912"
  },
  {
    "job_title": "Senior Data Engineer",
    "skills": "azure",
    "demand_count": "3537"
  },
  {
    "job_title": "Senior Data Scientist",
    "skills": "python",
    "demand_count": "9795"
  },
  {
    "job_title": "Senior Data Scientist",
    "skills": "sql",
    "demand_count": "7417"
  },
  {
    "job_title": "Senior Data Scientist",
    "skills": "r",
    "demand_count": "5720"
  },
  {
    "job_title": "Senior Data Scientist",
    "skills": "sas",
    "demand_count": "3198"
  },
  {
    "job_title": "Senior Data Scientist",
    "skills": "tableau",
    "demand_count": "2836"
  },
  {
    "job_title": "Software Engineer",
    "skills": "sql",
    "demand_count": "726"
  },
  {
    "job_title": "Software Engineer",
    "skills": "python",
    "demand_count": "706"
  },
  {
    "job_title": "Software Engineer",
    "skills": "java",
    "demand_count": "380"
  },
  {
    "job_title": "Software Engineer",
    "skills": "tableau",
    "demand_count": "336"
  },
  {
    "job_title": "Software Engineer",
    "skills": "aws",
    "demand_count": "330"
  }
]
*/