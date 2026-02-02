/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for data analyst positions
- Focus on roles with specified salaries, regardless of the location
- Why? It reveals how different skills impact salary levels for data analysts and 
helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS average_salary

FROM 
    job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True
GROUP BY
    skills_dim.skills

ORDER BY
    average_salary DESC

LIMIT 25

/*
Top-Paying Skills are Specialized Technical Skills
-Big Data tools (Spark, Hadoop), cloud platforms (AWS, Azure), 
and machine learning frameworks (TensorFlow) command the highest 
salaries, often 30–50% above foundational skills like SQL or Excel.

-High-Paying "Data Analyst" Roles Are Blending with Data Science & Engineering
Roles requiring data engineering, ML, or real-time analytics skills 
offer premium pay, signaling that top-tier analyst positions now expect skills traditionally 
associated with data scientists or data engineers.

-Cloud and Multi-Platform Expertise Carries a Salary Premium
Experience with cloud ecosystems and the ability to integrate multiple tools
 (e.g., Airflow, dbt, Kafka) results in higher compensation, especially in remote roles
  where scalable, production-ready analytics are highly valued.
*/