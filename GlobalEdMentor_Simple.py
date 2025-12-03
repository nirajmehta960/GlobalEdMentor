"""
GLOBALEDMENTOR - PYTHON APPLICATION
Simple implementation for database queries and visualizations
"""

# =============================================================================
# 1. CONNECT TO MYSQL DATABASE
# =============================================================================

import warnings
warnings.filterwarnings('ignore')

import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt

# Set matplotlib to display inline (for Jupyter)
# %matplotlib inline

# Database connection
connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Niraj@98420",
    database="GlobalEdMentor",
    auth_plugin='mysql_native_password'
)

print("Connected to MySQL successfully!")

# =============================================================================
# 2. EXECUTE QUERIES (5 Required Queries)
# =============================================================================

# Query 1: List all mentors with their expertise
query1 = """
SELECT m.mentor_id, ua.name AS mentor_name, m.field_of_expertise, 
       m.education_level, m.years_of_experience
FROM mentor m
JOIN user_account ua ON m.user_id = ua.user_id
ORDER BY m.years_of_experience DESC
"""

df_mentors = pd.read_sql(query1, connection)
print("\n--- Mentors Data ---")
print(df_mentors)

# Query 2: Mentor earnings from completed sessions
query2 = """
SELECT ua.name AS mentor_name, SUM(p.amount) AS total_earnings
FROM payment p
JOIN session_payment sp ON p.payment_id = sp.payment_id
JOIN session_appointment sa ON sp.session_id = sa.session_id
JOIN service s ON sa.service_id = s.service_id
JOIN mentor m ON s.mentor_id = m.mentor_id
JOIN user_account ua ON m.user_id = ua.user_id
WHERE p.status = 'captured'
GROUP BY ua.name
ORDER BY total_earnings DESC
"""

df_earnings = pd.read_sql(query2, connection)
print("\n--- Mentor Earnings ---")
print(df_earnings)

# Query 3: Top-rated mentors
query3 = """
SELECT ua.name AS mentor_name, ROUND(AVG(f.rating), 2) AS avg_rating, 
       COUNT(f.feedback_id) AS total_feedbacks
FROM feedback f
JOIN session_appointment sa ON f.session_id = sa.session_id
JOIN service s ON sa.service_id = s.service_id
JOIN mentor m ON s.mentor_id = m.mentor_id
JOIN user_account ua ON m.user_id = ua.user_id
GROUP BY ua.name
HAVING avg_rating >= 4.0
ORDER BY avg_rating DESC
"""

df_ratings = pd.read_sql(query3, connection)
print("\n--- Top-Rated Mentors ---")
print(df_ratings)

# Query 4: Completed sessions per mentor
query4 = """
SELECT ua.name AS mentor_name, COUNT(sa.session_id) AS completed_sessions
FROM session_appointment sa
JOIN service s ON sa.service_id = s.service_id
JOIN mentor m ON s.mentor_id = m.mentor_id
JOIN user_account ua ON m.user_id = ua.user_id
WHERE sa.status = 'completed'
GROUP BY ua.name
ORDER BY completed_sessions DESC
"""

df_sessions = pd.read_sql(query4, connection)
print("\n--- Completed Sessions ---")
print(df_sessions)

# Query 5: Mentees and target programs
query5 = """
SELECT ua.name AS mentee_name, p.name AS target_program, u.name AS university_name
FROM mentee_target_program mtp
JOIN mentee me ON mtp.mentee_id = me.mentee_id
JOIN user_account ua ON me.user_id = ua.user_id
JOIN program p ON mtp.program_id = p.program_id
JOIN university u ON p.university_id = u.university_id
ORDER BY ua.name
"""

df_programs = pd.read_sql(query5, connection)
print("\n--- Mentees and Target Programs ---")
print(df_programs.head(10))

# =============================================================================
# 3. SIMPLE ANALYTICS (NO MODEL REQUIRED)
# =============================================================================

# Average years of experience
avg_experience = df_mentors["years_of_experience"].mean()
print(f"\nAverage Years of Experience: {avg_experience:.2f} years")

# Total revenue
total_revenue = df_earnings["total_earnings"].sum()
print(f"Total Revenue: ${total_revenue:,.2f}")

# Average rating
avg_rating = df_ratings["avg_rating"].mean()
print(f"Average Rating: {avg_rating:.2f}")

# Total completed sessions
total_sessions = df_sessions["completed_sessions"].sum()
print(f"Total Completed Sessions: {total_sessions}")

# =============================================================================
# 4. VISUALIZATIONS
# =============================================================================

# Graph 1: Education Level Distribution (Pie Chart)
education_counts = df_mentors["education_level"].value_counts()

plt.figure(figsize=(8, 5))
plt.pie(education_counts.values, labels=education_counts.index, autopct='%1.1f%%', startangle=90)
plt.title("Mentor Education Level Distribution")
plt.axis('equal')
plt.show()

# Graph 2: Mentor Earnings (Bar Chart)
plt.figure(figsize=(10, 5))
plt.bar(df_earnings["mentor_name"], df_earnings["total_earnings"])
plt.title("Total Earnings per Mentor")
plt.xlabel("Mentor Name")
plt.ylabel("Total Earnings ($)")
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.show()

# Graph 3: Rating Distribution (Boxplot)
plt.figure(figsize=(8, 5))
plt.boxplot(df_ratings["avg_rating"])
plt.title("Feedback Rating Distribution")
plt.ylabel("Rating")
plt.xticks([1], ['Mentor Ratings'])
plt.grid(axis='y', alpha=0.3)
plt.show()

# Graph 4: Years of Experience (Histogram)
plt.figure(figsize=(8, 5))
plt.hist(df_mentors["years_of_experience"], bins=10, edgecolor='black')
plt.title("Distribution of Mentor Years of Experience")
plt.xlabel("Years of Experience")
plt.ylabel("Number of Mentors")
plt.grid(axis='y', alpha=0.3)
plt.show()

# Graph 5: Sessions vs Earnings (Scatter Plot)
# Merge sessions and earnings data
merged = pd.merge(df_sessions, df_earnings, on='mentor_name', how='inner')

plt.figure(figsize=(10, 5))
plt.scatter(merged["completed_sessions"], merged["total_earnings"], s=100, alpha=0.6)
plt.title("Relationship: Sessions vs Earnings")
plt.xlabel("Number of Completed Sessions")
plt.ylabel("Total Earnings ($)")
plt.grid(True, alpha=0.3)
plt.show()

# Close database connection
connection.close()
print("\nDatabase connection closed.")

