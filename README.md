# GlobalEdMentor: Study Abroad Mentorship Platform

A comprehensive database-driven analytics application for the GlobalEdMentor platform, connecting students with mentors for study abroad guidance.

## Project Overview

GlobalEdMentor is a community-driven mentorship platform that connects students (mentees) with verified mentors who are currently studying at foreign universities, alumni of international institutions, or working professionals. The platform provides affordable, pay-per-need mentorship sessions for SOP review, resume feedback, interview practice, and general counseling.

## Features

- **MySQL Database**: Complete relational database schema with 15+ tables
- **MongoDB Implementation**: NoSQL document-based database with 5 collections
- **20 SQL Queries**: Comprehensive queries covering all required query types
- **MongoDB Queries**: Simple, complex, and aggregate queries for NoSQL demonstration
- **Python Application**: Console-based analytics application
- **Web Interface**: Flask-based web application with visualizations
- **Data Visualization**: 5+ charts (Pie, Bar, Boxplot, Histogram, Scatter Plot)
- **Real-time Analytics**: Statistics and insights from database queries

## Project Structure

```
GlobalEdMentor/
├── MySQL Implementation/
│   ├── DDL_Queries.sql        # MySQL database schema definition
│   ├── DML_Queries.sql        # MySQL sample data insertion
│   └── SQL_Queries.sql        # 20 SQL queries covering all query types
├── NoSQL Implementation/
│   ├── MongoDB_Setup.js       # MongoDB collections and sample data
│   └── MongoDB_Queries.js     # MongoDB queries (simple, complex, aggregate)
├── GlobalEdMentor_Simple.py  # Simple Python implementation (RECOMMENDED)
├── app.py                     # Flask web application
├── globaledmentor_app.py      # Console-based Python application
├── templates/
│   ├── index.html            # Web dashboard home page
│   └── query.html            # Query results template
└── README.md                  # This file
```

## Database Setup

### Prerequisites

- MySQL Server installed and running
- MySQL Workbench (recommended) or command line access

### Step 1: Create Database Schema

**Using MySQL Workbench:**

1. Open MySQL Workbench
2. Connect to your MySQL server (password: `Niraj@98420`)
3. Open `MySQL Implementation/DDL_Queries.sql` file
4. Execute the entire script (⚡ icon or `Ctrl+Shift+Enter`)

**Using Command Line:**

```bash
mysql -u root -p < "MySQL Implementation/DDL_Queries.sql"
# Enter password: Niraj@98420
```

### Step 2: Load Sample Data

**Using MySQL Workbench:**

1. Open `MySQL Implementation/DML_Queries.sql` file
2. Execute the entire script

**Using Command Line:**

```bash
mysql -u root -p < "MySQL Implementation/DML_Queries.sql"
# Enter password: Niraj@98420
```

### Step 3: Verify Setup

Run a test query in MySQL Workbench:

```sql
USE GlobalEdMentor;
SELECT COUNT(*) FROM mentor;
SELECT COUNT(*) FROM mentee;
SELECT COUNT(*) FROM university;
```

## SQL Queries

The `MySQL Implementation/SQL_Queries.sql` file contains **20 queries** covering all required query types:

### Query Types Covered:

1. ✅ **Simple Query** - Query 1
2. ✅ **Aggregate Query** - Queries 7, 8, 9, 10
3. ✅ **Inner Join** - Queries 2, 3, 5, 6, 20
4. ✅ **Outer Join (LEFT JOIN)** - Query 4
5. ✅ **Nested Query (NOT IN)** - Query 11
6. ✅ **EXISTS** - Query 12
7. ✅ **NOT EXISTS** - Query 13
8. ✅ **Correlated Subquery** - Query 14
9. ✅ **>=ALL** - Query 15
10. ✅ **>ANY** - Query 16
11. ✅ **UNION** - Query 17
12. ✅ **Subquery in SELECT** - Query 18
13. ✅ **Subquery in FROM** - Query 19

### Running Queries

**In MySQL Workbench:**

1. Open `MySQL Implementation/SQL_Queries.sql`
2. Execute queries one by one or all at once
3. Review results in the Result Grid

**From Command Line:**

```bash
mysql -u root -p GlobalEdMentor < "MySQL Implementation/SQL_Queries.sql"
```

## Python Applications

### Simple Python Implementation (`GlobalEdMentor_Simple.py`) ⭐ RECOMMENDED

A simple, straightforward Python script for database queries and visualizations. Perfect for Jupyter notebooks and presentations.

**Installation:**

Install required packages:

```bash
pip install mysql-connector-python pandas matplotlib
```

**Usage:**

1. **For Jupyter Notebook:**

   - Copy the code from `GlobalEdMentor_Simple.py`
   - Paste into Jupyter notebook cells
   - Run cells sequentially

2. **For Python Script:**
   ```bash
   python3 GlobalEdMentor_Simple.py
   ```

**Features:**

- ✅ Simple, clean code structure
- ✅ Executes 5 main queries
- ✅ Simple analytics (averages, sums, counts)
- ✅ 5 visualizations (Pie, Bar, Boxplot, Histogram, Scatter Plot)
- ✅ Warnings suppressed for clean output
- ✅ Uses `mysql.connector` directly
- ✅ Perfect for presentations

**Code Structure:**

```
1. CONNECT TO MYSQL DATABASE
2. EXECUTE QUERIES (5 queries)
3. SIMPLE ANALYTICS
4. VISUALIZATIONS (5 graphs)
```

### Console Application (`globaledmentor_app.py`)

A command-line application that executes queries and displays analytics.

**Installation:**

Install required packages:

```bash
pip install mysql-connector-python matplotlib numpy flask
```

**Run:**

```bash
python3 globaledmentor_app.py
```

**Features:**

- Executes 5 main queries
- Performs analytics on retrieved data
- Displays formatted results in console
- Generates visualizations (charts open in separate windows)

### Web Application (`app.py`)

A Flask-based web interface for viewing queries and visualizations.

**Installation:**

Install required packages:

```bash
pip install mysql-connector-python matplotlib numpy flask
```

**Run:**

```bash
python3 app.py
```

**Access:**
Open your browser and navigate to: `http://127.0.0.1:5000`

**Features:**

- Dashboard with key statistics
- Database connection status indicator
- Interactive query pages
- Embedded charts and visualizations
- Clean, simple interface

## Database Connection

### Connection Parameters

Update the database credentials in the following files:

- `GlobalEdMentor_Simple.py` - Update connection parameters in the script
- `app.py` - Update `DB_CONFIG` dictionary
- `globaledmentor_app.py` - Update `DB_CONFIG` dictionary in the `main()` function

**Default configuration:**

- **Host**: `localhost`
- **Port**: `3306` (default MySQL port)
- **Database**: `GlobalEdMentor`
- **User**: `root`
- **Password**: `Niraj@98420` (update with your MySQL password)
- **Auth Plugin**: `mysql_native_password`

**Note:** The simple Python implementation uses `warnings.filterwarnings('ignore')` to suppress pandas warnings when using `mysql.connector` with `pd.read_sql()`.

## Data Visualization

The application includes **5 types of charts**:

1. **Pie Chart** - Education level distribution
2. **Bar Chart** - Mentor earnings comparison
3. **Boxplot** - Feedback rating distribution
4. **Histogram** - Years of experience distribution
5. **Scatter Plot** - Sessions vs earnings relationship

Charts are generated using matplotlib and displayed:

- In separate windows (console app)
- Embedded in web pages (web app)

## Requirements

### Python Packages

**For Simple Implementation (`GlobalEdMentor_Simple.py`):**

- `mysql-connector-python` >= 8.0.33
- `pandas` >= 1.3.0
- `matplotlib` >= 3.5.0

```bash
pip install mysql-connector-python pandas matplotlib
```

**For Full Applications:**

- `mysql-connector-python` >= 8.0.33
- `matplotlib` >= 3.5.0
- `numpy` >= 1.21.0
- `flask` >= 2.0.0

```bash
pip install mysql-connector-python matplotlib numpy flask pandas
```

### System Requirements

- Python 3.6+
- MySQL Server 5.7+ or 8.0+
- Web browser (for web application)

## Troubleshooting

### Database Connection Issues

**"Access denied" error:**

- Verify MySQL server is running
- Check password: `Niraj@98420`
- Ensure user `root` has proper permissions

**"Database not found":**

- Run `MySQL Implementation/DDL_Queries.sql` to create the database
- Verify database name is exactly `GlobalEdMentor`

**Authentication plugin error:**

```sql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Niraj@98420';
FLUSH PRIVILEGES;
```

### Web Application Issues

**Port 5000 already in use:**

- Stop other Flask applications
- Or change port in `app.py`: `app.run(debug=True, host='127.0.0.1', port=5001)`

**Charts not displaying:**

- Ensure matplotlib is installed: `pip install matplotlib`
- Check browser console for errors

### Python Application Issues

**Module not found:**

```bash
pip install mysql-connector-python matplotlib numpy flask
```

**Charts not opening:**

- On headless servers, charts won't display
- Web application works better for remote access

## Key Queries Overview

1. **Simple Query**: Most expensive service
2. **Inner Joins**: Mentors, mentees, sessions, programs
3. **Outer Join**: All mentors with/without university affiliations
4. **Aggregates**: Counts, sums, averages with GROUP BY
5. **Nested Queries**: NOT IN, EXISTS, NOT EXISTS
6. **Correlated**: Mentors above average performance
7. **Comparison**: >=ALL, >ANY operators
8. **Set Operations**: UNION for subscriptions
9. **Subqueries**: In SELECT and FROM clauses

## Analytics Provided

- Mentor statistics (count, experience, education distribution)
- Revenue and earnings analysis
- Session completion rates
- Feedback and rating statistics
- Program and university popularity
- Mentee-to-mentor ratios
- Activity and engagement metrics

## Notes

- All data is retrieved directly from MySQL database
- Queries are tested and ready for demonstration
- **Simple Python implementation** (`GlobalEdMentor_Simple.py`) is recommended for Jupyter notebooks and presentations
- Web interface provides clean visualization of results
- Console app is useful for quick data analysis
- Charts are generated on-the-fly from database queries
- Warnings are suppressed in the simple implementation for cleaner output

## MongoDB Implementation (NoSQL)

### Overview

A NoSQL implementation using MongoDB with document-based data modeling. Includes 5 collections with embedded documents and arrays.

### Collections

1. **mentors** (8 documents) - Mentor profiles with embedded user and university information
2. **mentees** (10 documents) - Mentee profiles with embedded user and target programs
3. **sessions** (10 documents) - Session records with embedded service, mentor, mentee, feedback, and payment
4. **universities** (5 documents) - University information with embedded programs array
5. **payments** (8 documents) - Payment records with embedded session information

### Setup

**Using MongoDB Compass:**

1. Open MongoDB Compass
2. Connect to your MongoDB instance
3. Open MongoDB Shell (MONGOSH tab)
4. Copy and paste entire content of `NoSQL Implementation/MongoDB_Setup.js`
5. Execute to create collections and data

**Using MongoDB Online Playground:**

1. Go to https://mongoplayground.net/ or https://try.mongodb.com/
2. Copy content from `NoSQL Implementation/MongoDB_Setup.js`
3. Paste and execute

### MongoDB Queries

The `NoSQL Implementation/MongoDB_Queries.js` file contains **7 queries** including:

1. **Simple Query** ✅

   - Find verified mentors with PhD degree
   - Simple find with conditions

2. **Complex Query** ✅

   - Completed sessions with multiple conditions (status, rating, payment)
   - Uses $gte, $exists operators
   - Sorting and field projection
   - Alternative query with $or operator

3. **Aggregate Query** ✅
   - Total earnings per mentor
   - Uses $match, $group, $sum, $avg, $sort, $project
   - Groups by mentor and calculates statistics

**Additional Queries:**

- Aggregate: Count mentees by country
- Aggregate: University program statistics
- Complex: Mentors with USA university affiliation
- Aggregate: Average price by service type

### Running MongoDB Queries

**In MongoDB Compass:**

1. Open MongoDB Shell
2. Copy queries from `NoSQL Implementation/MongoDB_Queries.js`
3. Paste and execute

**In Online Playground:**

1. Copy individual queries
2. Paste into playground
3. Execute

### Data Model

- **Denormalized Structure**: User information embedded in mentors/mentees
- **Arrays**: Multiple programs per university, multiple universities per mentor
- **Embedded Documents**: Session includes all related information in one document
- **No Joins Required**: All related data accessible from single document

## Contact & Support

For issues or questions about the database or application, refer to the query comments in `MySQL Implementation/SQL_Queries.sql` or `NoSQL Implementation/MongoDB_Queries.js` or check the application error messages.
