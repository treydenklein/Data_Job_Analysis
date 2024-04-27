/*
Answer: What are the most optimal skills to learn (aka high demand and high-paying)?
- Identify skills in high demand that are associated with high average salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in the industry
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

-- Return the top 10 skills with the highest demand and average salary
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

/*
Quick Breakdown of the Query Results:
- SQL and Python are the most in-demand skills overall
- Focus on SQL, Python, AWS, and Spark for high-paying, in-demand roles
- Despite lower demand, Java still offers good pay
- Excel and Power BI roles are plentiful, but with lower average pay

Results:
[
  {
    "skill_id": 0,
    "skills": "sql",
    "demand_count": "115208",
    "avg_salary": "126914"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "107250",
    "avg_salary": "135994"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "demand_count": "51295",
    "avg_salary": "129564"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "49638",
    "avg_salary": "118447"
  },
  {
    "skill_id": 181,
    "skills": "excel",
    "demand_count": "45490",
    "avg_salary": "100051"
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "demand_count": "38136",
    "avg_salary": "141241"
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "demand_count": "30210",
    "avg_salary": "148568"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "demand_count": "27835",
    "avg_salary": "134408"
  },
  {
    "skill_id": 183,
    "skills": "power bi",
    "demand_count": "26517",
    "avg_salary": "107244"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "22935",
    "avg_salary": "141290"
  }
]
*/