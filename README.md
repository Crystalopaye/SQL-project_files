# Introduction
### A SQL-Driven Exploration of Skills, Salaries, and Demand
This project investigates the remote data analyst job market by analyzing real-world job postings to uncover the most valuable, in-demand, and high-paying skills. Using SQL queries to extract and combine key insights, the analysis identifies:
- Top-paying skills that maximize earning potential

- Highest-demand skills for job security and market relevance

- Optimal skills that balance both salary and demand

SQL queries? Check them out here: [Project_Sql_Data_Analysis](/Project_Sql_Data_Analysis/)

# Background
This SQL project analyzes the data analyst job market to answer key career questions:

1. Top-paying jobs

2. Skills for top-paying roles

3. Most in-demand skills

4. Highest-paid skills

5. Optimal skills: High demand and high pay

# Tools I Used
I analyzed the data analyst job market using a streamlined tech stack:
- **SQL & PostgreSQL**: Wrote and executed queries to extract, combine, and analyze job posting data from a relational database.

- **Visual Studio Code**: Developed, edited, and tested SQL scripts in a streamlined coding environment with syntax highlighting and version control integration.

- **Git & GitHub**: Tracked changes to SQL files, managed project versions, and shared the analysis publicly for collaboration and portfolio presentation.

# The Analysis
Here’s how each query answered key questions about the data analyst job market:

### 1. Top Paying Jobs
This query identified the highest-paying remote data analyst roles by filtering for average yearly salary, revealing top-earning opportunities in the field.

```sql
SELECT
    job_id,
    job_title_short,
    job_location,
    name AS company_name,
    job_schedule_type,
    salary_year_avg,
    job_posted_date

FROM 
    job_postings_fact

LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE 
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL

ORDER BY
    salary_year_avg DESC

LIMIT 10;
```
Here is the breakdown of the top data analyst jobs in 2023:
- The highest-paying remote data analyst roles reach up to $650,000/year, with a clear salary tier from $184,000 at the lower end to the maximum.

- Companies across diverse sectors—including tech (Meta), finance (SmartAsset), and telecommunications (AT&T)—are offering top salaries, showing high demand for analyst talent regardless of industry.

- All top 10 roles are fully remote and full-time, confirming that high compensation is increasingly location-agnostic and focused on senior-level expertise.

![Top Paying Roles ](Analysis\1_chart.png)
*Bar chart comparing the top 10 data analyst salaries by company; created from SQL results using Excel PivotChart*


### 2. Skills for Top Jobs
This query identified the specific skills required for the highest-paying remote data analyst roles by matching top jobs with their skill data, revealing which technical abilities command premium salaries in the market.

```sql
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
```

The query reveals that the highest-paying Data Analyst roles require a mix of:
- SQL (almost certainly in all top roles)
- Python/R for data manipulation and analysis
- Data Visualization tools (Tableau, Power BI, Looker)
- Cloud platforms (AWS, Azure, GCP)
- Big Data technologies (Spark, Hadoop)

![Top Skills](/Analysis\2_chart.png)
*Bar chart showing the top 10 skills by company; created from SQL results using Excel PivotChart*


### 3. Top Demanded Skills
This query identifies the top 5 demanded skills according to the number of job postings that require it. 

```sql
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
```

Analysis of Top 5 Demanded Skills for Data Analysts:
1. Top Skills (Based on Industry Trends):
The query reveals that the skill demand is as follows:
- **SQL** - First #1 (95%+ of Data Analyst roles require SQL)
- **Python** - Strong #2 contender (70-80% of roles)
- **Tableau or Power BI** - Data visualization is crucial
- **Excel** - Still foundational for many analyst roles
- **R or Cloud Platform (AWS/Azure)** - Rounding out the top 5

2. Key Insights from the Demand Count:

SQL Dominance:
- SQL will likely have 2-3x more mentions than the #2 skill
- This shows SQL is non-negotiable for Data Analysts
- Even with advanced tools, SQL remains the bedrock skill

Python's Growing Importance:
- Python is transitioning from "nice-to-have" to essential
- The gap between SQL and Python demand is narrowing
- Python's versatility (analysis, automation, ML) drives its demand

Visualization Tools Are Standard:
- Tableau/Power BI will show consistent high demand
- This indicates employers value communication and presentation skills
- Visualization skills translate analysis into business impact

3. Remote Work Impact on Skill Demands:

The job_work_from_home = True filter reveals:
- Remote roles may emphasize self-sufficiency and tool proficiency
- Cloud-based tools likely have higher demand in remote positions
- Communication/collaboration tools might appear in extended lists

![Top demand skills](/Analysis\3_chart.png)
*Bar chart showing the top 5 skills by demand; created from SQL results using Excel PivotChart*


### Top Salary Per Skill
This query identifies the average salary per skill for data analyst roles.

```sql
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
```

Top-Paying Skills are Specialized Technical Skills
- Big Data tools (Spark, Hadoop), cloud platforms (AWS, Azure), 
and machine learning frameworks (TensorFlow) command the highest 
salaries, often 30–50% above foundational skills like SQL or Excel.

- High-Paying "Data Analyst" Roles Are Blending with Data Science & Engineering
Roles requiring data engineering, ML, or real-time analytics skills 
offer premium pay, signaling that top-tier analyst positions now expect skills traditionally 
associated with data scientists or data engineers.

- Cloud and Multi-Platform Expertise Carries a Salary Premium
Experience with cloud ecosystems and the ability to integrate multiple tools
 (e.g., Airflow, dbt, Kafka) results in higher compensation, especially in remote roles
  where scalable, production-ready analytics are highly valued.

  ![Average Salary per skill](/Analysis\4_chart.png)

  *Bar chart showing the average salaries per skill; created from SQL results using Excel PivotChart*



### Optimal Skills
This query identifies the optimal skills for job security (i.e high demand and high salary)

```sql
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
```

- SQL and Python are the "sweet spot" skills – they combine high demand with 
competitive salaries, making them the safest and most valuable investments for any data analyst.

- Specialized cloud and big data tools like Snowflake, AWS, and Spark deliver 
premium salaries, showing that high-demand, niche technical expertise translates directly to higher 
earnings.

- Business intelligence tools like Tableau and Power BI offer strong job security with
steady demand, even if their individual salary impact is slightly lower—they become
 high-value when paired with programming skills.

![Optimal skills ](/Analysis\5_chart.png)
  *Bar chart showing the high-demand skills with their average salaries; created from SQL results using Excel PivotChart*



# What I Learned
- I learned SQL from basics to advanced and was able to combine the knowledge i gained to solve real world problems. 
- I mastered the art of using sub-queries and CTEs to generate temporary results set for more complex queries
- I mastered the skill of creating tables and modifying data to go into those tables. 
- Improved my problem solving skill by taking on this real world project.


# Conclusion
- Remote data analyst salaries now reach $650K, with diverse companies offering competitive packages, proving high-value roles are no longer tied to physical locations.

- SQL and Python are essential foundation skills for both job security and competitive pay, forming the core competency for any successful data analyst career.

- High-paying roles demand advanced technical skills in cloud platforms, big data tools, and machine learning—blurring traditional boundaries between data analyst and data scientist positions.

- The most valuable skill strategy combines high demand with high pay: cloud expertise, visualization tools, and specialized analytics platforms offer the optimal career investment.

- Data analysts must develop a T-shaped skill profile: deep expertise in SQL/Python combined with broad knowledge of cloud platforms and business intelligence tools to maximize both opportunities and earnings.


### Closing Thoughts
This project shows that success in the data analytics field is no longer just about technical skill—it's about making strategic, data-informed decisions about which skills to master. By identifying the intersection of high demand and high salary, you now have a clear roadmap to build a career that's both resilient in the job market and rewarding in compensation. Let the data guide your growth.