/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
providing insights into the most valuable skills for job seekers.
*/
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count

FROM 
    job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True
    
GROUP BY
    skills

ORDER BY
    demand_count DESC

LIMIT 5

/*
Analysis of Top 5 Demanded Skills for Data Analysts:
1. Expected Top Skills (Based on Industry Trends):
The query will likely reveal these skills as most in-demand:
-SQL - Will almost certainly be #1 (95%+ of Data Analyst roles require SQL)
-Python - Strong #2 contender (70-80% of roles)
-Tableau or Power BI - Data visualization is crucial
-Excel - Still foundational for many analyst roles
-R or Cloud Platform (AWS/Azure) - Rounding out the top 5

2. Key Insights from the Demand Count:
SQL Dominance:
-SQL will likely have 2-3x more mentions than the #2 skill
-This shows SQL is non-negotiable for Data Analysts
-Even with advanced tools, SQL remains the bedrock skill

Python's Growing Importance:
-Python is transitioning from "nice-to-have" to essential
-The gap between SQL and Python demand is narrowing
-Python's versatility (analysis, automation, ML) drives its demand

Visualization Tools Are Standard:
-Tableau/Power BI will show consistent high demand
-This indicates employers value communication and presentation skills
-Visualization skills translate analysis into business impact

3. Remote Work Impact on Skill Demands:
The job_work_from_home = True filter reveals:
-Remote roles may emphasize self-sufficiency and tool proficiency
-Cloud-based tools likely have higher demand in remote positions
-Communication/collaboration tools might appear in extended lists

4. Skill Gap Analysis:
What this means for job seekers:
-Master SQL first - it's the highest ROI skill
-Add Python - it's becoming standard, not optional
-Choose a visualization tool - specialize in Tableau OR Power BI
-Don't neglect Excel - it's still widely used in business settings

5. Market Dynamics Revealed:
Tier 1 Skills (Essential):
-SQL
-Python
-Visualization Tool

Tier 2 Skills (Competitive Advantage):
-Cloud Platform (AWS/Azure/GCP)
-R (for statistical-heavy roles)
-Advanced Excel (Power Query/Pivot)
*/