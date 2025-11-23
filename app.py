"""
GlobalEdMentor Database Analytics Application - Web Interface
Simple Flask frontend to display database queries and visualizations
"""

from flask import Flask, render_template, jsonify
import mysql.connector
from mysql.connector import Error
import matplotlib
matplotlib.use('Agg')  # Use non-interactive backend for web
import matplotlib.pyplot as plt
import numpy as np
import base64
from io import BytesIO
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

app = Flask(__name__)

# Database configuration from environment variables
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'database': os.getenv('DB_NAME', 'GlobalEdMentor'),
    'user': os.getenv('DB_USER', 'root'),
    'password': os.getenv('DB_PASSWORD', ''),
    'auth_plugin': 'mysql_native_password'
}


def get_db_connection():
    """Create and return database connection"""
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        return connection
    except Error as e:
        print(f"Error connecting to database: {e}")
        return None


def execute_query(query):
    """Execute SQL query and return results"""
    connection = get_db_connection()
    if not connection:
        return None
    
    try:
        cursor = connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]
        cursor.close()
        connection.close()
        return {'columns': columns, 'data': results}
    except Error as e:
        print(f"Error executing query: {e}")
        if connection:
            connection.close()
        return None


def create_chart_image(chart_func, *args):
    """Create chart and return as base64 encoded image"""
    plt.figure(figsize=(10, 6))
    chart_func(*args)
    img = BytesIO()
    plt.savefig(img, format='png', bbox_inches='tight', dpi=100)
    img.seek(0)
    plt.close()
    img_base64 = base64.b64encode(img.getvalue()).decode()
    return img_base64


def chart_1_pie_education(education_levels):
    """Pie chart for education level distribution"""
    labels = list(education_levels.keys())
    sizes = list(education_levels.values())
    colors = plt.cm.Set3(np.linspace(0, 1, len(labels)))
    plt.pie(sizes, labels=labels, autopct='%1.1f%%', colors=colors, startangle=90)
    plt.title('Mentor Education Level Distribution', fontsize=14, fontweight='bold')
    plt.axis('equal')


def chart_2_bar_earnings(earnings_data):
    """Bar chart for mentor earnings"""
    names = [row[0] for row in earnings_data]
    earnings = [float(row[1]) for row in earnings_data]
    bars = plt.bar(range(len(names)), earnings, color='steelblue', edgecolor='navy', alpha=0.7)
    plt.xlabel('Mentors', fontsize=12)
    plt.ylabel('Total Earnings ($)', fontsize=12)
    plt.title('Total Earnings per Mentor', fontsize=14, fontweight='bold')
    plt.xticks(range(len(names)), names, rotation=45, ha='right')
    plt.grid(axis='y', alpha=0.3)
    for i, (bar, value) in enumerate(zip(bars, earnings)):
        plt.text(bar.get_x() + bar.get_width()/2, bar.get_height() + max(earnings)*0.01,
                f'${value:,.0f}', ha='center', va='bottom', fontsize=9)


def chart_3_boxplot_ratings(ratings_data):
    """Boxplot for rating distribution"""
    ratings = [float(row[1]) for row in ratings_data]
    plt.boxplot(ratings, vert=True, patch_artist=True,
               boxprops=dict(facecolor='lightblue', alpha=0.7),
               medianprops=dict(color='red', linewidth=2))
    plt.ylabel('Rating', fontsize=12)
    plt.title('Feedback Rating Distribution (Boxplot)', fontsize=14, fontweight='bold')
    plt.grid(axis='y', alpha=0.3)
    plt.xticks([1], ['Mentor Ratings'])


def chart_4_histogram_experience(years_data):
    """Histogram for years of experience"""
    years = [row[4] for row in years_data]
    plt.hist(years, bins=range(min(years), max(years)+2), color='coral', edgecolor='black', alpha=0.7)
    plt.xlabel('Years of Experience', fontsize=12)
    plt.ylabel('Number of Mentors', fontsize=12)
    plt.title('Distribution of Mentor Years of Experience', fontsize=14, fontweight='bold')
    plt.grid(axis='y', alpha=0.3)
    plt.xticks(range(min(years), max(years)+1))
    mean_years = np.mean(years)
    plt.axvline(mean_years, color='red', linestyle='--', linewidth=2, 
               label=f'Mean: {mean_years:.1f} years')
    plt.legend()


def chart_5_scatter_sessions_earnings(sessions_data, earnings_data):
    """Scatter plot for sessions vs earnings"""
    earnings_dict = {row[0]: float(row[1]) for row in earnings_data}
    sessions = []
    earnings = []
    for row in sessions_data:
        mentor_name = row[0]
        session_count = row[1]
        if mentor_name in earnings_dict:
            sessions.append(session_count)
            earnings.append(earnings_dict[mentor_name])
    
    if sessions:
        plt.scatter(sessions, earnings, s=100, alpha=0.6, c='green', edgecolors='darkgreen', linewidth=2)
        plt.xlabel('Number of Completed Sessions', fontsize=12)
        plt.ylabel('Total Earnings ($)', fontsize=12)
        plt.title('Relationship: Sessions vs Earnings (Scatter Plot)', fontsize=14, fontweight='bold')
        plt.grid(True, alpha=0.3)
        if len(sessions) > 1:
            z = np.polyfit(sessions, earnings, 1)
            p = np.poly1d(z)
            plt.plot(sessions, p(sessions), "r--", alpha=0.5, label='Trend Line')
            plt.legend()


@app.route('/')
def index():
    """Main page with overview"""
    db_status = {'connected': False, 'message': 'Disconnected'}
    stats = {}
    
    try:
        connection = get_db_connection()
        
        if connection and connection.is_connected():
            cursor = connection.cursor()
            
            # Check connection status
            db_status = {'connected': True, 'message': 'Connected'}
            cursor.execute("SELECT database();")
            db_name = cursor.fetchone()[0]
            db_status['database'] = db_name
            db_status['server_info'] = connection.server_info
            
            # Get summary statistics
            cursor.execute("SELECT COUNT(*) FROM mentor")
            stats['total_mentors'] = cursor.fetchone()[0]
            
            cursor.execute("SELECT COUNT(*) FROM mentee")
            stats['total_mentees'] = cursor.fetchone()[0]
            
            cursor.execute("SELECT COUNT(*) FROM session_appointment WHERE status = 'completed'")
            stats['completed_sessions'] = cursor.fetchone()[0]
            
            cursor.execute("SELECT COUNT(*) FROM feedback")
            stats['total_feedbacks'] = cursor.fetchone()[0]
            
            cursor.execute("SELECT SUM(amount) FROM payment WHERE status = 'captured'")
            revenue = cursor.fetchone()[0]
            stats['total_revenue'] = float(revenue) if revenue else 0
            
            cursor.execute("SELECT AVG(rating) FROM feedback")
            avg_rating = cursor.fetchone()[0]
            stats['avg_rating'] = float(avg_rating) if avg_rating else 0
            
            cursor.close()
            connection.close()
        else:
            db_status = {'connected': False, 'message': 'Could not connect to database'}
            
    except Error as e:
        db_status = {'connected': False, 'message': f'Error: {str(e)}'}
    except Exception as e:
        db_status = {'connected': False, 'message': f'Error: {str(e)}'}
    
    # Set default values if stats are empty
    if not stats:
        stats = {
            'total_mentors': 0,
            'total_mentees': 0,
            'completed_sessions': 0,
            'total_feedbacks': 0,
            'total_revenue': 0,
            'avg_rating': 0
        }
    
    return render_template('index.html', stats=stats, db_status=db_status)


@app.route('/query1')
def query1():
    """Query 1: Mentors with expertise"""
    query = """
        SELECT m.mentor_id, ua.name AS mentor_name, m.field_of_expertise, 
               m.education_level, m.years_of_experience
        FROM mentor m
        JOIN user_account ua ON m.user_id = ua.user_id
        ORDER BY m.years_of_experience DESC
    """
    
    result = execute_query(query)
    if not result:
        return "Error executing query"
    
    # Calculate analytics
    education_levels = {}
    total_years = 0
    for row in result['data']:
        education = row[3]
        years = row[4]
        education_levels[education] = education_levels.get(education, 0) + 1
        total_years += years
    
    avg_years = total_years / len(result['data']) if result['data'] else 0
    
    # Create charts
    chart1 = create_chart_image(chart_1_pie_education, education_levels)
    chart2 = create_chart_image(chart_4_histogram_experience, result['data'])
    
    return render_template('query.html', 
                         query_num=1,
                         query_title="List of All Mentors with Expertise and Education Level",
                         result=result,
                         analytics={'education_levels': education_levels, 'avg_years': avg_years},
                         charts=[chart1, chart2])


@app.route('/query2')
def query2():
    """Query 2: Mentor earnings"""
    query = """
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
    
    result = execute_query(query)
    if not result:
        return "Error executing query"
    
    # Calculate analytics
    earnings_list = [float(row[1]) for row in result['data']]
    total_earnings = sum(earnings_list)
    avg_earnings = total_earnings / len(earnings_list) if earnings_list else 0
    
    # Create chart
    chart = create_chart_image(chart_2_bar_earnings, result['data'])
    
    return render_template('query.html',
                         query_num=2,
                         query_title="Total Earnings per Mentor",
                         result=result,
                         analytics={'total_earnings': total_earnings, 'avg_earnings': avg_earnings},
                         charts=[chart])


@app.route('/query3')
def query3():
    """Query 3: Top-rated mentors"""
    query = """
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
    
    result = execute_query(query)
    if not result:
        return "Error executing query"
    
    # Calculate analytics
    ratings = [float(row[1]) for row in result['data']]
    total_feedbacks = sum([row[2] for row in result['data']])
    avg_rating = sum(ratings) / len(ratings) if ratings else 0
    
    # Create chart
    chart = create_chart_image(chart_3_boxplot_ratings, result['data'])
    
    return render_template('query.html',
                         query_num=3,
                         query_title="Top-Rated Mentors (Average Rating >= 4.0)",
                         result=result,
                         analytics={'ratings': ratings, 'total_feedbacks': total_feedbacks, 'avg_rating': avg_rating},
                         charts=[chart])


@app.route('/query4')
def query4():
    """Query 4: Completed sessions"""
    query = """
        SELECT ua.name AS mentor_name, COUNT(sa.session_id) AS completed_sessions
        FROM session_appointment sa
        JOIN service s ON sa.service_id = s.service_id
        JOIN mentor m ON s.mentor_id = m.mentor_id
        JOIN user_account ua ON m.user_id = ua.user_id
        WHERE sa.status = 'completed'
        GROUP BY ua.name
        ORDER BY completed_sessions DESC
    """
    
    result = execute_query(query)
    if not result:
        return "Error executing query"
    
    # Get earnings for scatter plot
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
    earnings_result = execute_query(earnings_query)
    
    # Calculate analytics
    sessions = [row[1] for row in result['data']]
    total_sessions = sum(sessions)
    avg_sessions = total_sessions / len(sessions) if sessions else 0
    
    # Create chart
    chart = None
    if earnings_result:
        chart = create_chart_image(chart_5_scatter_sessions_earnings, result['data'], earnings_result['data'])
    
    return render_template('query.html',
                         query_num=4,
                         query_title="Completed Sessions per Mentor",
                         result=result,
                         analytics={'total_sessions': total_sessions, 'avg_sessions': avg_sessions},
                         charts=[chart] if chart else [])


@app.route('/query5')
def query5():
    """Query 5: Mentees and target programs"""
    query = """
        SELECT ua.name AS mentee_name, p.name AS target_program, u.name AS university_name
        FROM mentee_target_program mtp
        JOIN mentee me ON mtp.mentee_id = me.mentee_id
        JOIN user_account ua ON me.user_id = ua.user_id
        JOIN program p ON mtp.program_id = p.program_id
        JOIN university u ON p.university_id = u.university_id
        ORDER BY ua.name
    """
    
    result = execute_query(query)
    if not result:
        return "Error executing query"
    
    # Calculate analytics
    program_counts = {}
    university_counts = {}
    for row in result['data']:
        program = row[1]
        university = row[2]
        program_counts[program] = program_counts.get(program, 0) + 1
        university_counts[university] = university_counts.get(university, 0) + 1
    
    return render_template('query.html',
                         query_num=5,
                         query_title="Mentees and Their Target Programs",
                         result=result,
                         analytics={'program_counts': program_counts, 'university_counts': university_counts},
                         charts=[])


if __name__ == '__main__':
    print("=" * 70)
    print("Starting GlobalEdMentor Analytics Web Application")
    print("=" * 70)
    print("\nOpen your browser and navigate to: http://127.0.0.1:5000")
    print("Press Ctrl+C to stop the server\n")
    app.run(debug=True, host='127.0.0.1', port=5000)

