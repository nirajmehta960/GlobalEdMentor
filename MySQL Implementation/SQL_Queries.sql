USE GlobalEdMentor;

-- =====================================================
-- 1. SIMPLE QUERY: Find the most expensive mentorship service offered on the platform
-- =====================================================
SELECT description, price_per_hour
FROM service
ORDER BY price_per_hour DESC
LIMIT 1;

-- =====================================================
-- 2. INNER JOIN: List all mentors with their expertise, education level, and years of experience
-- =====================================================
SELECT m.mentor_id, ua.name AS mentor_name, m.field_of_expertise, m.education_level, m.years_of_experience
FROM mentor m
JOIN user_account ua ON m.user_id = ua.user_id
ORDER BY m.years_of_experience DESC;

-- =====================================================
-- 3. INNER JOIN: Show all mentees with their current education level and target study destination
-- =====================================================
SELECT me.mentee_id, ua.name AS mentee_name, me.current_education_level, 
       me.intended_study_country, me.target_degree, me.field_of_interest
FROM mentee me
JOIN user_account ua ON me.user_id = ua.user_id
ORDER BY me.intended_study_country;

-- =====================================================
-- 4. OUTER JOIN (LEFT JOIN): Show all mentors and their university affiliations, including mentors without any university affiliation
-- =====================================================
SELECT ua.name AS mentor_name, u.name AS university_name, mu.relation, mu.since_year
FROM mentor m
JOIN user_account ua ON m.user_id = ua.user_id
LEFT JOIN mentor_university mu ON m.mentor_id = mu.mentor_id
LEFT JOIN university u ON mu.university_id = u.university_id
ORDER BY ua.name;

-- =====================================================
-- 5. INNER JOIN: Display all mentees and the specific programs they are targeting for admission
-- =====================================================
SELECT ua.name AS mentee_name, p.name AS target_program, u.name AS university_name
FROM mentee_target_program mtp
JOIN mentee me ON mtp.mentee_id = me.mentee_id
JOIN user_account ua ON me.user_id = ua.user_id
JOIN program p ON mtp.program_id = p.program_id
JOIN university u ON p.university_id = u.university_id
ORDER BY ua.name;

-- =====================================================
-- 6. INNER JOIN: Show all session appointments with both mentor and mentee names
-- =====================================================
SELECT sa.session_id, s.description AS service, ua_m.name AS mentor_name, ua_me.name AS mentee_name, 
       sa.start_time, sa.duration_min, sa.status
FROM session_appointment sa
JOIN service s ON sa.service_id = s.service_id
JOIN mentor m ON s.mentor_id = m.mentor_id
JOIN user_account ua_m ON m.user_id = ua_m.user_id
JOIN mentee me ON sa.mentee_id = me.mentee_id
JOIN user_account ua_me ON me.user_id = ua_me.user_id
ORDER BY sa.start_time;

-- =====================================================
-- 7. AGGREGATE: Calculate the total number of sessions with 'completed' status for each mentor
-- =====================================================
SELECT ua.name AS mentor_name, COUNT(sa.session_id) AS completed_sessions
FROM session_appointment sa
JOIN service s ON sa.service_id = s.service_id
JOIN mentor m ON s.mentor_id = m.mentor_id
JOIN user_account ua ON m.user_id = ua.user_id
WHERE sa.status = 'completed'
GROUP BY ua.name
ORDER BY completed_sessions DESC;

-- =====================================================
-- 8. AGGREGATE: Calculate total earnings per mentor from captured payments
-- =====================================================
SELECT ua.name AS mentor_name, SUM(p.amount) AS total_earnings
FROM payment p
JOIN session_payment sp ON p.payment_id = sp.payment_id
JOIN session_appointment sa ON sp.session_id = sa.session_id
JOIN service s ON sa.service_id = s.service_id
JOIN mentor m ON s.mentor_id = m.mentor_id
JOIN user_account ua ON m.user_id = ua.user_id
WHERE p.status = 'captured'
GROUP BY ua.name
ORDER BY total_earnings DESC;

-- =====================================================
-- 9. AGGREGATE WITH HAVING: Find top-rated mentors with an average feedback rating of 4.5 or higher
-- =====================================================
SELECT ua.name AS mentor_name, ROUND(AVG(f.rating),2) AS avg_rating, COUNT(f.feedback_id) AS total_feedbacks
FROM feedback f
JOIN session_appointment sa ON f.session_id = sa.session_id
JOIN service s ON sa.service_id = s.service_id
JOIN mentor m ON s.mentor_id = m.mentor_id
JOIN user_account ua ON m.user_id = ua.user_id
GROUP BY ua.name
HAVING avg_rating >= 4.5
ORDER BY avg_rating DESC;

-- =====================================================
-- 10. AGGREGATE: Show how many graduate programs each university has in the system
-- =====================================================
SELECT u.name AS university_name, COUNT(p.program_id) AS total_programs
FROM university u
JOIN program p ON u.university_id = p.university_id
GROUP BY u.name
ORDER BY total_programs DESC;

-- =====================================================
-- 11. NESTED QUERY (NOT IN): Find mentors who have no session appointments of any kind
-- =====================================================
SELECT ua.name AS mentor_name
FROM mentor m
JOIN user_account ua ON m.user_id = ua.user_id
WHERE m.mentor_id NOT IN (
    SELECT DISTINCT s.mentor_id 
    FROM service s 
    INNER JOIN session_appointment sa ON s.service_id = sa.service_id
)
ORDER BY ua.name;

-- =====================================================
-- 12. EXISTS: Find mentees who currently have active subscriptions
-- =====================================================
SELECT ua.name AS mentee_name, me.current_education_level, me.intended_study_country
FROM mentee me
JOIN user_account ua ON me.user_id = ua.user_id
WHERE EXISTS (SELECT 1 FROM mentee_subscription ms WHERE ms.mentee_id = me.mentee_id AND ms.status = 'active')
ORDER BY ua.name;

-- =====================================================
-- 13. NOT EXISTS: Find universities that have no programs registered in the system
-- =====================================================
SELECT u.name AS university_name, u.country, u.ranking
FROM university u
WHERE NOT EXISTS (SELECT 1 FROM program p WHERE p.university_id = u.university_id)
ORDER BY u.name;

-- =====================================================
-- 14. CORRELATED SUBQUERY: Find mentors who have completed more sessions than the average mentor
-- =====================================================
SELECT ua.name AS mentor_name, 
       (SELECT COUNT(sa.session_id) 
        FROM session_appointment sa
        JOIN service s ON sa.service_id = s.service_id
        WHERE s.mentor_id = m.mentor_id AND sa.status = 'completed') AS completed_sessions
FROM mentor m
JOIN user_account ua ON m.user_id = ua.user_id
WHERE (SELECT COUNT(sa.session_id) 
       FROM session_appointment sa
       JOIN service s ON sa.service_id = s.service_id
       WHERE s.mentor_id = m.mentor_id AND sa.status = 'completed') > 
      (SELECT AVG(session_count) 
       FROM (SELECT COUNT(sa.session_id) AS session_count
             FROM session_appointment sa
             JOIN service s ON sa.service_id = s.service_id
             WHERE sa.status = 'completed'
             GROUP BY s.mentor_id) AS avg_sessions);

-- =====================================================
-- 15. >=ALL: Find the mentor(s) with the highest earnings (equal to or greater than all other mentors)
-- =====================================================
SELECT ua.name AS mentor_name, SUM(p.amount) AS total_earnings
FROM payment p
JOIN session_payment sp ON p.payment_id = sp.payment_id
JOIN session_appointment sa ON sp.session_id = sa.session_id
JOIN service s ON sa.service_id = s.service_id
JOIN mentor m ON s.mentor_id = m.mentor_id
JOIN user_account ua ON m.user_id = ua.user_id
WHERE p.status = 'captured'
GROUP BY ua.name
HAVING SUM(p.amount) >= ALL (
    SELECT SUM(p2.amount)
    FROM payment p2
    JOIN session_payment sp2 ON p2.payment_id = sp2.payment_id
    JOIN session_appointment sa2 ON sp2.session_id = sa2.session_id
    JOIN service s2 ON sa2.service_id = s2.service_id
    WHERE p2.status = 'captured'
    GROUP BY s2.mentor_id
);

-- =====================================================
-- 16. >ANY: Find mentors earning more than any mentor specializing in Data Science
-- =====================================================
SELECT ua.name AS mentor_name, SUM(p.amount) AS total_earnings
FROM payment p
JOIN session_payment sp ON p.payment_id = sp.payment_id
JOIN session_appointment sa ON sp.session_id = sa.session_id
JOIN service s ON sa.service_id = s.service_id
JOIN mentor m ON s.mentor_id = m.mentor_id
JOIN user_account ua ON m.user_id = ua.user_id
WHERE p.status = 'captured'
GROUP BY ua.name
HAVING SUM(p.amount) > ANY (
    SELECT SUM(p2.amount)
    FROM payment p2
    JOIN session_payment sp2 ON p2.payment_id = sp2.payment_id
    JOIN session_appointment sa2 ON sp2.session_id = sa2.session_id
    JOIN service s2 ON sa2.service_id = s2.service_id
    JOIN mentor m2 ON s2.mentor_id = m2.mentor_id
    WHERE m2.field_of_expertise = 'Data Science' AND p2.status = 'captured'
    GROUP BY s2.mentor_id
);

-- =====================================================
-- 17. UNION: Compare total revenue generated from sessions versus subscriptions
-- =====================================================
SELECT 'Session Revenue' AS revenue_type, SUM(p.amount) AS total_amount
FROM payment p
JOIN session_payment sp ON p.payment_id = sp.payment_id
WHERE p.status = 'captured'

UNION

SELECT 'Subscription Revenue' AS revenue_type, SUM(p.amount) AS total_amount
FROM payment p
JOIN subscription_payment subp ON p.payment_id = subp.payment_id
WHERE p.status = 'captured';

-- =====================================================
-- 18. SUBQUERY IN SELECT CLAUSE: Display each mentor's name, field of expertise, and total earnings using a calculated column
-- =====================================================
SELECT ua.name AS mentor_name,
       m.field_of_expertise,
       COALESCE((SELECT SUM(p.amount) 
        FROM payment p
        JOIN session_payment sp ON p.payment_id = sp.payment_id
        JOIN session_appointment sa ON sp.session_id = sa.session_id
        JOIN service s ON sa.service_id = s.service_id
        WHERE s.mentor_id = m.mentor_id AND p.status = 'captured'), 0) AS total_earnings
FROM mentor m
JOIN user_account ua ON m.user_id = ua.user_id
ORDER BY total_earnings DESC;

-- =====================================================
-- 19. SUBQUERY IN FROM CLAUSE: Create a derived table with mentor name, total completed sessions, and total earnings
-- =====================================================
SELECT mentor_stats.mentor_name,
       mentor_stats.total_sessions,
       mentor_stats.total_earnings
FROM (
    SELECT ua.name AS mentor_name,
           COUNT(sa.session_id) AS total_sessions,
           COALESCE(SUM(p.amount), 0) AS total_earnings
    FROM mentor m
    JOIN user_account ua ON m.user_id = ua.user_id
    LEFT JOIN service s ON m.mentor_id = s.mentor_id
    LEFT JOIN session_appointment sa ON s.service_id = sa.service_id AND sa.status = 'completed'
    LEFT JOIN session_payment sp ON sa.session_id = sp.session_id
    LEFT JOIN payment p ON sp.payment_id = p.payment_id AND p.status = 'captured'
    GROUP BY ua.name
) AS mentor_stats
ORDER BY mentor_stats.total_earnings DESC;

-- =====================================================
-- 20. INNER JOIN: Display all feedback submitted by mentees including mentor names, ratings, and comments
-- =====================================================
SELECT ua_me.name AS mentee_name, ua_m.name AS mentor_name, f.rating, f.comments
FROM feedback f
JOIN session_appointment sa ON f.session_id = sa.session_id
JOIN service s ON sa.service_id = s.service_id
JOIN mentor m ON s.mentor_id = m.mentor_id
JOIN user_account ua_m ON m.user_id = ua_m.user_id
JOIN mentee me ON sa.mentee_id = me.mentee_id
JOIN user_account ua_me ON me.user_id = ua_me.user_id
ORDER BY f.rating DESC;

