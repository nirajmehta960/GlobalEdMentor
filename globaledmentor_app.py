"""
GlobalEdMentor Database Analytics Application
Python application connecting to MySQL database and performing analytics
"""

import mysql.connector
from mysql.connector import Error
from typing import Optional
import matplotlib.pyplot as plt
import numpy as np
import os


class GlobalEdMentorAnalytics:
    """Main class for GlobalEdMentor database analytics"""
    
    def __init__(self, host='localhost', database='GlobalEdMentor', 
                 user='root', password='', auth_plugin='mysql_native_password'):
        """Initialize database connection parameters"""
        self.host = host
        self.database = database
        self.user = user
        self.password = password
        self.auth_plugin = auth_plugin
        self.connection = None
        self.cursor = None
    
    def connect(self) -> bool:
        """Establish connection to MySQL database"""
        try:
            self.connection = mysql.connector.connect(
                host=self.host,
                database=self.database,
                user=self.user,
                password=self.password,
                auth_plugin=self.auth_plugin
            )
            
            if self.connection.is_connected():
                self.cursor = self.connection.cursor()
                db_info = self.connection.server_info
                self.cursor.execute("SELECT database();")
                db_name = self.cursor.fetchone()[0]
                
                print("=" * 70)
                print(f"Connected to MySQL Server version {db_info}")
                print(f"Connected to database: {db_name}")
                print("=" * 70)
                print()
                return True
            return False
            
        except Error as e:
            print(f"Error while connecting to MySQL: {e}")
            return False
    
    def disconnect(self):
        """Close database connection"""
        if self.connection and self.connection.is_connected():
            if self.cursor:
                self.cursor.close()
            self.connection.close()
            print("\nMySQL connection is closed")
    
    def execute_query(self, query: str):
        """Execute a SQL query and return results"""
        try:
            self.cursor.execute(query)
            return self.cursor.fetchall()
        except Error as e:
            print(f"Error executing query: {e}")
            return None
    
    def create_chart_1_pie_education_levels(self, education_levels: dict):
        """Chart 1: Pie chart showing education level distribution"""
        if not education_levels:
            return
        
        labels = list(education_levels.keys())
        sizes = list(education_levels.values())
        colors = plt.cm.Set3(np.linspace(0, 1, len(labels)))
        
        plt.figure(figsize=(8, 6))
        plt.pie(sizes, labels=labels, autopct='%1.1f%%', colors=colors, startangle=90)
        plt.title('Mentor Education Level Distribution', fontsize=14, fontweight='bold')
        plt.axis('equal')
        plt.tight_layout()
        plt.show()
        print("✓ Chart 1 displayed: Pie Chart - Education Level Distribution\n")
    
    def create_chart_2_bar_mentor_earnings(self, earnings_data: list):
        """Chart 2: Bar chart showing mentor earnings"""
        if not earnings_data:
            return
        
        names = [row[0] for row in earnings_data]
        earnings = [float(row[1]) for row in earnings_data]
        
        plt.figure(figsize=(10, 6))
        bars = plt.bar(range(len(names)), earnings, color='steelblue', edgecolor='navy', alpha=0.7)
        plt.xlabel('Mentors', fontsize=12)
        plt.ylabel('Total Earnings ($)', fontsize=12)
        plt.title('Total Earnings per Mentor', fontsize=14, fontweight='bold')
        plt.xticks(range(len(names)), names, rotation=45, ha='right')
        plt.grid(axis='y', alpha=0.3)
        
        # Add value labels on bars
        for i, (bar, value) in enumerate(zip(bars, earnings)):
            plt.text(bar.get_x() + bar.get_width()/2, bar.get_height() + max(earnings)*0.01,
                    f'${value:,.0f}', ha='center', va='bottom', fontsize=9)
        
        plt.tight_layout()
        plt.show()
        print("✓ Chart 2 displayed: Bar Chart - Mentor Earnings\n")
    
    def create_chart_3_boxplot_ratings(self, ratings_data: list):
        """Chart 3: Boxplot showing feedback rating distribution"""
        if not ratings_data:
            return
        
        ratings = [float(row[1]) for row in ratings_data]
        
        plt.figure(figsize=(8, 6))
        plt.boxplot(ratings, vert=True, patch_artist=True,
                   boxprops=dict(facecolor='lightblue', alpha=0.7),
                   medianprops=dict(color='red', linewidth=2),
                   whiskerprops=dict(color='black', linewidth=1.5),
                   capprops=dict(color='black', linewidth=1.5))
        plt.ylabel('Rating', fontsize=12)
        plt.title('Feedback Rating Distribution (Boxplot)', fontsize=14, fontweight='bold')
        plt.grid(axis='y', alpha=0.3)
        plt.xticks([1], ['Mentor Ratings'])
        
        # Add statistics text
        stats_text = f'Min: {min(ratings):.2f}\nQ1: {np.percentile(ratings, 25):.2f}\nMedian: {np.median(ratings):.2f}\nQ3: {np.percentile(ratings, 75):.2f}\nMax: {max(ratings):.2f}'
        plt.text(1.15, np.median(ratings), stats_text, fontsize=10,
                bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.5))
        
        plt.tight_layout()
        plt.show()
        print("✓ Chart 3 displayed: Boxplot - Rating Distribution\n")
    
    def create_chart_4_histogram_years_experience(self, years_data: list):
        """Chart 4: Histogram showing years of experience distribution"""
        if not years_data:
            return
        
        years = [row[4] for row in years_data]  # years_of_experience is 5th column (index 4)
        
        plt.figure(figsize=(8, 6))
        plt.hist(years, bins=range(min(years), max(years)+2), color='coral', edgecolor='black', alpha=0.7)
        plt.xlabel('Years of Experience', fontsize=12)
        plt.ylabel('Number of Mentors', fontsize=12)
        plt.title('Distribution of Mentor Years of Experience', fontsize=14, fontweight='bold')
        plt.grid(axis='y', alpha=0.3)
        plt.xticks(range(min(years), max(years)+1))
        
        # Add mean line
        mean_years = np.mean(years)
        plt.axvline(mean_years, color='red', linestyle='--', linewidth=2, 
                   label=f'Mean: {mean_years:.1f} years')
        plt.legend()
        
        plt.tight_layout()
        plt.show()
        print("✓ Chart 4 displayed: Histogram - Years of Experience Distribution\n")
    
    def create_chart_5_scatter_sessions_vs_earnings(self, sessions_data: list, earnings_data: list):
        """Chart 5: Scatter plot showing relationship between sessions and earnings"""
        if not sessions_data or not earnings_data:
            return
        
        # Create a dictionary to match mentors
        earnings_dict = {row[0]: float(row[1]) for row in earnings_data}
        
        sessions = []
        earnings = []
        mentor_names = []
        
        for row in sessions_data:
            mentor_name = row[0]
            session_count = row[1]
            if mentor_name in earnings_dict:
                sessions.append(session_count)
                earnings.append(earnings_dict[mentor_name])
                mentor_names.append(mentor_name)
        
        if not sessions:
            return
        
        plt.figure(figsize=(10, 6))
        plt.scatter(sessions, earnings, s=100, alpha=0.6, c='green', edgecolors='darkgreen', linewidth=2)
        
        # Add labels for each point
        for i, name in enumerate(mentor_names):
            plt.annotate(name, (sessions[i], earnings[i]), 
                        xytext=(5, 5), textcoords='offset points', fontsize=8)
        
        plt.xlabel('Number of Completed Sessions', fontsize=12)
        plt.ylabel('Total Earnings ($)', fontsize=12)
        plt.title('Relationship: Sessions vs Earnings (Scatter Plot)', fontsize=14, fontweight='bold')
        plt.grid(True, alpha=0.3)
        
        # Add trend line
        if len(sessions) > 1:
            z = np.polyfit(sessions, earnings, 1)
            p = np.poly1d(z)
            plt.plot(sessions, p(sessions), "r--", alpha=0.5, label='Trend Line')
            plt.legend()
        
        plt.tight_layout()
        plt.show()
        print("✓ Chart 5 displayed: Scatter Plot - Sessions vs Earnings\n")
    
    def query_1_mentors_expertise(self):
        """
        QUERY 1: List all mentors with their expertise and education level
        Analytics: Calculate distribution by education level and average years of experience
        """
        print("QUERY 1: List of All Mentors with Expertise and Education Level")
        print("-" * 70)
        
        sql_query = """
            SELECT m.mentor_id, ua.name AS mentor_name, m.field_of_expertise, 
                   m.education_level, m.years_of_experience
            FROM mentor m
            JOIN user_account ua ON m.user_id = ua.user_id
            ORDER BY m.years_of_experience DESC
        """
        
        records = self.execute_query(sql_query)
        
        if records:
            print(f"Total Mentors: {len(records)}")
            print(f"{'Mentor ID':<12} {'Name':<25} {'Field of Expertise':<30} {'Education':<20} {'Years Exp':<10}")
            print("-" * 70)
            
            # Analytics: Calculate statistics
            education_levels = {}
            total_years = 0
            
            for row in records:
                mentor_id, name, expertise, education, years = row
                print(f"{mentor_id:<12} {name:<25} {expertise:<30} {education:<20} {years:<10}")
                
                # Track education level distribution
                education_levels[education] = education_levels.get(education, 0) + 1
                total_years += years
            
            # Display analytics
            print("-" * 70)
            print("ANALYTICS:")
            avg_years = total_years / len(records) if records else 0
            print(f"Average Years of Experience: {avg_years:.2f}")
            print(f"Education Level Distribution:")
            for edu_level, count in sorted(education_levels.items()):
                percentage = (count / len(records)) * 100
                print(f"  {edu_level}: {count} mentors ({percentage:.1f}%)")
            
            # Create visualizations
            print("\n" + "=" * 70)
            print("CREATING VISUALIZATIONS...")
            print("=" * 70)
            self.create_chart_1_pie_education_levels(education_levels)
            self.create_chart_4_histogram_years_experience(records)
        else:
            print("No mentors found.")
        
        print("\n")
    
    def query_2_mentor_earnings(self):
        """
        QUERY 2: Calculate total earnings per mentor
        Analytics: Calculate total revenue, average earnings, and identify top earners
        """
        print("QUERY 2: Total Earnings per Mentor (from Completed Sessions)")
        print("-" * 70)
        
        sql_query = """
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
        
        records = self.execute_query(sql_query)
        
        if records:
            print(f"{'Mentor Name':<30} {'Total Earnings ($)':<20}")
            print("-" * 70)
            
            total_all_earnings = 0
            earnings_list = []
            
            for row in records:
                mentor_name, earnings = row
                earnings = float(earnings) if earnings else 0
                total_all_earnings += earnings
                earnings_list.append(earnings)
                print(f"{mentor_name:<30} ${earnings:,.2f}")
            
            # Analytics: Calculate comprehensive statistics
            print("-" * 70)
            print("ANALYTICS:")
            avg_earnings = total_all_earnings / len(records) if records else 0
            max_earnings = max(earnings_list) if earnings_list else 0
            min_earnings = min(earnings_list) if earnings_list else 0
            
            print(f"Total Revenue (All Mentors): ${total_all_earnings:,.2f}")
            print(f"Average Earnings per Mentor: ${avg_earnings:,.2f}")
            print(f"Highest Earnings: ${max_earnings:,.2f}")
            print(f"Lowest Earnings: ${min_earnings:,.2f}")
            print(f"Number of Earning Mentors: {len(records)}")
            
            # Identify top earners (above average)
            top_earners = [r for r in records if float(r[1]) > avg_earnings]
            if top_earners:
                print(f"Top Performers (Above Average): {len(top_earners)} mentors")
            
            # Create visualization
            print("\n" + "=" * 70)
            print("CREATING VISUALIZATION...")
            print("=" * 70)
            self.create_chart_2_bar_mentor_earnings(records)
        else:
            print("No earnings data found.")
        
        print("\n")
    
    def query_3_top_rated_mentors(self):
        """
        QUERY 3: Find top-rated mentors based on average feedback rating
        Analytics: Calculate rating distribution, identify highest rated mentors
        """
        print("QUERY 3: Top-Rated Mentors (Average Feedback Rating >= 4.0)")
        print("-" * 70)
        
        sql_query = """
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
        
        records = self.execute_query(sql_query)
        
        if records:
            print(f"{'Mentor Name':<30} {'Avg Rating':<15} {'Total Feedbacks':<20}")
            print("-" * 70)
            
            ratings_list = []
            total_feedbacks = 0
            
            for row in records:
                mentor_name, rating, feedback_count = row
                rating = float(rating)
                ratings_list.append(rating)
                total_feedbacks += feedback_count
                print(f"{mentor_name:<30} {rating:<15.2f} {feedback_count:<20}")
            
            # Analytics: Calculate comprehensive statistics
            print("-" * 70)
            print("ANALYTICS:")
            max_rating = max(ratings_list) if ratings_list else 0
            min_rating = min(ratings_list) if ratings_list else 0
            overall_avg = sum(ratings_list) / len(ratings_list) if ratings_list else 0
            avg_feedbacks = total_feedbacks / len(records) if records else 0
            
            print(f"Overall Average Rating: {overall_avg:.2f}")
            print(f"Highest Rating: {max_rating:.2f}")
            print(f"Lowest Rating: {min_rating:.2f}")
            print(f"Total Top-Rated Mentors: {len(records)}")
            print(f"Average Feedbacks per Mentor: {avg_feedbacks:.2f}")
            print(f"Total Feedbacks: {total_feedbacks}")
            
            # Rating distribution
            excellent = len([r for r in ratings_list if r >= 4.8])
            very_good = len([r for r in ratings_list if 4.5 <= r < 4.8])
            good = len([r for r in ratings_list if 4.0 <= r < 4.5])
            
            print(f"Rating Distribution:")
            print(f"  Excellent (4.8+): {excellent} mentors")
            print(f"  Very Good (4.5-4.7): {very_good} mentors")
            print(f"  Good (4.0-4.4): {good} mentors")
            
            # Create visualization
            print("\n" + "=" * 70)
            print("CREATING VISUALIZATION...")
            print("=" * 70)
            self.create_chart_3_boxplot_ratings(records)
        else:
            print("No feedback data found.")
        
        print("\n")
    
    def query_4_completed_sessions(self):
        """
        QUERY 4: Count completed sessions per mentor
        Analytics: Calculate session statistics and identify most active mentors
        """
        print("QUERY 4: Completed Sessions per Mentor")
        print("-" * 70)
        
        sql_query = """
            SELECT ua.name AS mentor_name, COUNT(sa.session_id) AS completed_sessions
            FROM session_appointment sa
            JOIN service s ON sa.service_id = s.service_id
            JOIN mentor m ON s.mentor_id = m.mentor_id
            JOIN user_account ua ON m.user_id = ua.user_id
            WHERE sa.status = 'completed'
            GROUP BY ua.name
            ORDER BY completed_sessions DESC
        """
        
        records = self.execute_query(sql_query)
        
        if records:
            print(f"{'Mentor Name':<30} {'Completed Sessions':<20}")
            print("-" * 70)
            
            total_sessions = 0
            session_counts = []
            
            for row in records:
                mentor_name, sessions = row
                total_sessions += sessions
                session_counts.append(sessions)
                print(f"{mentor_name:<30} {sessions:<20}")
            
            # Analytics: Calculate statistics
            print("-" * 70)
            print("ANALYTICS:")
            avg_sessions = total_sessions / len(records) if records else 0
            max_sessions = max(session_counts) if session_counts else 0
            min_sessions = min(session_counts) if session_counts else 0
            
            print(f"Total Completed Sessions: {total_sessions}")
            print(f"Average Sessions per Mentor: {avg_sessions:.2f}")
            print(f"Maximum Sessions (Single Mentor): {max_sessions}")
            print(f"Minimum Sessions (Single Mentor): {min_sessions}")
            print(f"Number of Active Mentors: {len(records)}")
            
            # Identify most active mentors
            most_active = [r for r in records if r[1] > avg_sessions]
            if most_active:
                print(f"Highly Active Mentors (Above Average): {len(most_active)} mentors")
            
            # Get earnings data for scatter plot
            earnings_query = """
                SELECT ua.name AS mentor_name, SUM(p.amount) AS total_earnings
                FROM payment p
                JOIN session_payment sp ON p.payment_id = sp.payment_id
                JOIN session_appointment sa ON sp.session_id = sa.session_id
                JOIN service s ON sa.service_id = s.service_id
                JOIN mentor m ON s.mentor_id = m.mentor_id
                JOIN user_account ua ON m.user_id = ua.user_id
                WHERE p.status = 'captured'
                GROUP BY ua.name
            """
            earnings_data = self.execute_query(earnings_query)
            
            # Create visualization
            if earnings_data:
                print("\n" + "=" * 70)
                print("CREATING VISUALIZATION...")
                print("=" * 70)
                self.create_chart_5_scatter_sessions_vs_earnings(records, earnings_data)
        else:
            print("No completed sessions found.")
        
        print("\n")
    
    def query_5_mentee_target_programs(self):
        """
        QUERY 5: Show mentees and their target programs
        Analytics: Analyze program popularity and university preferences
        """
        print("QUERY 5: Mentees and Their Target Programs")
        print("-" * 70)
        
        sql_query = """
            SELECT ua.name AS mentee_name, p.name AS target_program, u.name AS university_name,
                   u.country AS university_country
            FROM mentee_target_program mtp
            JOIN mentee me ON mtp.mentee_id = me.mentee_id
            JOIN user_account ua ON me.user_id = ua.user_id
            JOIN program p ON mtp.program_id = p.program_id
            JOIN university u ON p.university_id = u.university_id
            ORDER BY ua.name
        """
        
        records = self.execute_query(sql_query)
        
        if records:
            print(f"{'Mentee Name':<25} {'Target Program':<40} {'University':<30}")
            print("-" * 70)
            
            # Analytics: Track program and country popularity
            program_counts = {}
            country_counts = {}
            university_counts = {}
            
            for row in records:
                mentee_name, program, university, country = row
                print(f"{mentee_name:<25} {program[:38]:<40} {university[:28]:<30}")
                
                # Track analytics
                program_counts[program] = program_counts.get(program, 0) + 1
                country_counts[country] = country_counts.get(country, 0) + 1
                university_counts[university] = university_counts.get(university, 0) + 1
            
            # Display analytics
            print("-" * 70)
            print("ANALYTICS:")
            print(f"Total Target Programs: {len(records)}")
            print(f"Unique Universities Targeted: {len(university_counts)}")
            print(f"Unique Programs Targeted: {len(program_counts)}")
            print(f"Unique Countries Targeted: {len(country_counts)}")
            
            # Top 3 most popular programs
            top_programs = sorted(program_counts.items(), key=lambda x: x[1], reverse=True)[:3]
            print(f"\nTop 3 Most Popular Programs:")
            for i, (program, count) in enumerate(top_programs, 1):
                print(f"  {i}. {program[:50]}: {count} mentees")
            
            # Top 3 most popular countries
            top_countries = sorted(country_counts.items(), key=lambda x: x[1], reverse=True)[:3]
            print(f"\nTop 3 Most Popular Study Countries:")
            for i, (country, count) in enumerate(top_countries, 1):
                print(f"  {i}. {country}: {count} programs")
        else:
            print("No target programs found.")
        
        print("\n")
    
    def generate_analytics_summary(self):
        """
        Generate comprehensive analytics summary
        """
        print("=" * 70)
        print("COMPREHENSIVE ANALYTICS SUMMARY")
        print("=" * 70)
        
        # Get total counts
        total_mentors = self.execute_query("SELECT COUNT(*) FROM mentor")[0][0]
        total_mentees = self.execute_query("SELECT COUNT(*) FROM mentee")[0][0]
        total_completed_sessions = self.execute_query(
            "SELECT COUNT(*) FROM session_appointment WHERE status = 'completed'"
        )[0][0]
        total_scheduled_sessions = self.execute_query(
            "SELECT COUNT(*) FROM session_appointment WHERE status = 'scheduled'"
        )[0][0]
        total_cancelled_sessions = self.execute_query(
            "SELECT COUNT(*) FROM session_appointment WHERE status = 'cancelled'"
        )[0][0]
        total_feedbacks = self.execute_query("SELECT COUNT(*) FROM feedback")[0][0]
        total_universities = self.execute_query("SELECT COUNT(*) FROM university")[0][0]
        total_programs = self.execute_query("SELECT COUNT(*) FROM program")[0][0]
        
        # Calculate total revenue
        revenue_result = self.execute_query(
            "SELECT SUM(amount) FROM payment WHERE status = 'captured'"
        )
        total_revenue = float(revenue_result[0][0]) if revenue_result and revenue_result[0][0] else 0
        
        # Calculate average rating
        avg_rating_result = self.execute_query("SELECT AVG(rating) FROM feedback")
        avg_rating = float(avg_rating_result[0][0]) if avg_rating_result and avg_rating_result[0][0] else 0
        
        print(f"Total Mentors in System: {total_mentors}")
        print(f"Total Mentees in System: {total_mentees}")
        print(f"Total Universities: {total_universities}")
        print(f"Total Programs: {total_programs}")
        print(f"Total Completed Sessions: {total_completed_sessions}")
        print(f"Total Scheduled Sessions: {total_scheduled_sessions}")
        print(f"Total Cancelled Sessions: {total_cancelled_sessions}")
        print(f"Total Feedbacks Received: {total_feedbacks}")
        print(f"Total Revenue: ${total_revenue:,.2f}")
        print(f"Average Feedback Rating: {avg_rating:.2f}")
        
        # Calculate ratios and rates
        if total_mentors > 0:
            mentee_to_mentor_ratio = total_mentees / total_mentors
            print(f"\nMentee to Mentor Ratio: {mentee_to_mentor_ratio:.2f}")
        
        total_sessions = total_completed_sessions + total_scheduled_sessions + total_cancelled_sessions
        if total_sessions > 0:
            completion_rate = (total_completed_sessions / total_sessions) * 100
            cancellation_rate = (total_cancelled_sessions / total_sessions) * 100
            print(f"Session Completion Rate: {completion_rate:.2f}%")
            print(f"Session Cancellation Rate: {cancellation_rate:.2f}%")
        
        if total_completed_sessions > 0:
            feedback_rate = (total_feedbacks / total_completed_sessions) * 100
            print(f"Feedback Rate: {feedback_rate:.2f}%")
        
        if total_mentors > 0:
            active_mentors = self.execute_query(
                "SELECT COUNT(DISTINCT m.mentor_id) FROM mentor m "
                "JOIN service s ON m.mentor_id = s.mentor_id "
                "JOIN session_appointment sa ON s.service_id = sa.service_id "
                "WHERE sa.status = 'completed'"
            )[0][0]
            mentor_activity_rate = (active_mentors / total_mentors) * 100
            print(f"Active Mentor Rate: {mentor_activity_rate:.2f}% ({active_mentors}/{total_mentors})")
        
        print("=" * 70)
    
    def run_all_queries(self):
        """Execute all queries and generate analytics"""
        if not self.connection or not self.connection.is_connected():
            print("Error: Not connected to database")
            return
        
        # Execute all queries
        self.query_1_mentors_expertise()
        self.query_2_mentor_earnings()
        self.query_3_top_rated_mentors()
        self.query_4_completed_sessions()
        self.query_5_mentee_target_programs()
        
        # Generate summary
        self.generate_analytics_summary()


def main():
    """Main function to run the application"""
    from dotenv import load_dotenv
    load_dotenv()
    
    DB_CONFIG = {
        'host': os.getenv('DB_HOST', 'localhost'),
        'database': os.getenv('DB_NAME', 'GlobalEdMentor'),
        'user': os.getenv('DB_USER', 'root'),
        'password': os.getenv('DB_PASSWORD', ''),
        'auth_plugin': 'mysql_native_password'
    }
    
    # Create analytics instance
    analytics = GlobalEdMentorAnalytics(**DB_CONFIG)
    
    try:
        if analytics.connect():
            analytics.run_all_queries()
        else:
            print("Failed to connect to database")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        analytics.disconnect()


if __name__ == "__main__":
    main()

