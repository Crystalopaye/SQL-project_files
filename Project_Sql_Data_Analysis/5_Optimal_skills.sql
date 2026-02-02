/* 
Question: What are the most optimal skills to learn ?(i.e it's in high demand and a high-paying skill)
- Identify skills in high demand and assiciated with high average salaries for data analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security(high demand) and financial benefits(high salaries),
offering strategic insights for career development in data analysis
*/

WITH skills_demand AS( 
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count

    FROM 
        job_postings_fact

    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

    WHERE 
        job_title_short = 'Data Analyst' AND
        job_work_from_home = True AND
        salary_year_avg IS NOT NULL
        
    GROUP BY
        skills_dim.skill_id
),

average_salary AS (
    SELECT
        skills_job_dim.skill_id,
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
        skills_job_dim.skill_id
    )

    SELECT
        skills_demand.skill_id,
        skills_demand.skills,
        demand_count,
        average_salary
    
    FROM skills_demand
    INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
    
    WHERE
        demand_count > 10

    ORDER BY
        average_salary DESC,
        demand_count DESC

    LIMIT 25;

/*
-SQL and Python are the "sweet spot" skills – they combine high demand with 
competitive salaries, making them the safest and most valuable investments for any data analyst.

-Specialized cloud and big data tools like Snowflake, AWS, and Spark deliver 
premium salaries, showing that high-demand, niche technical expertise translates directly to higher 
earnings.

-Business intelligence tools like Tableau and Power BI offer strong job security with
steady demand, even if their individual salary impact is slightly lower—they become
 high-value when paired with programming skills.
*/
