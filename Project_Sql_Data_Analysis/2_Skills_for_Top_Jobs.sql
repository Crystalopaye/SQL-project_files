/*
Question: What skills are required for the top_paying data analyst jobs?
-Use the top 10 highest-paying data analyst jobs from first query
-Add the specific skills required for these roles
-Why? It provides a detailed look at which high-paying jobs demand certain skills,
helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS( 
    SELECT
        job_id,
        job_title_short,
        name AS company_name,
        salary_year_avg

    FROM 
        job_postings_fact

    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL

    ORDER BY
        salary_year_avg DESC

    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills


FROM 
    top_paying_jobs

INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY
    salary_year_avg DESC;

/*
Expected Skill Insights from Top-Paying Data Analyst Jobs:
1. Most Common In-Demand Skills:
The query would likely reveal that the highest-paying Data Analyst roles require a mix of:
-SQL (almost certainly in all top roles)
-Python/R for data manipulation and analysis
-Data Visualization tools (Tableau, Power BI, Looker)
-Cloud platforms (AWS, Azure, GCP)
-Big Data technologies (Spark, Hadoop)

2. Salary-Driving Specialized Skills:
The top-paying roles probably require:
-Advanced analytics frameworks (TensorFlow, PyTorch for ML roles)
-Advanced SQL (window functions, CTEs, optimization)
-Data engineering skills (ETL, data pipeline tools)
-Statistical analysis expertise
-Domain-specific knowledge (finance, healthcare, etc.)

3. Skill Patterns by Industry:
Different industries in the top 10 might show:
-Tech companies: More emphasis on Python, cloud, and big data tools
-Finance companies: SQL excellence, statistical tools, domain knowledge
-Consulting firms: Broader toolset across multiple platforms

4. Important Observations:
-SQL is non-negotiable for high-paying Data Analyst roles
-Python has become essential (not just "nice to have")
-Visualization skills command premium pay
-Cloud platform experience increases market value
-Specialized domain knowledge can significantly boost salary
*/

