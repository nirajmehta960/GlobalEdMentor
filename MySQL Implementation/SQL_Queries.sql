USE GlobalEdMentor;

-- =====================================================
-- 1. SIMPLE QUERY: Find the most expensive mentorship service
-- =====================================================
SELECT description, price_per_hour
FROM service
ORDER BY price_per_hour DESC
LIMIT 1;

-- =====================================================
-- 2. INNER JOIN: List all mentors with their expertise and education level
-- =====================================================
SELECT m.mentor_id, ua.name AS mentor_name, m.field_of_expertise, m.education_level, m.years_of_experience
FROM mentor m
JOIN user_account ua ON m.user_id = ua.user_id
ORDER BY m.years_of_experience DESC;

-- =====================================================
-- 3. INNER JOIN: Show all mentees and their intended study countries
-- =====================================================
SELECT me.mentee_id, ua.name AS mentee_name, me.current_education_level, 
       me.intended_study_country, me.target_degree, me.field_of_interest
FROM mentee me
JOIN user_account ua ON me.user_id = ua.user_id
ORDER BY me.intended_study_country;

-- =====================================================
-- 4. OUTER JOIN (LEFT JOIN): Show all mentors and their university affiliations
-- (including mentors without any university affiliation)
-- =====================================================
SELECT ua.name AS mentor_name, u.name AS university_name, mu.relation, mu.since_year
FROM mentor m
JOIN user_account ua ON m.user_id = ua.user_id
LEFT JOIN mentor_university mu ON m.mentor_id = mu.mentor_id
LEFT JOIN university u ON mu.university_id = u.university_id
ORDER BY ua.name;

-- =====================================================
-- 5. INNER JOIN: Display all mentees and the programs they are targeting
-- =====================================================
SELECT ua.name AS mentee_name, p.name AS target_program, u.name AS university_name
FROM mentee_target_program mtp
JOIN mentee me ON mtp.mentee_id = me.mentee_id
JOIN user_account ua ON me.user_id = ua.user_id
JOIN program p ON mtp.program_id = p.program_id
JOIN university u ON p.university_id = u.university_id
ORDER BY ua.name;

-- =====================================================
-- 6. INNER JOIN: Show all session appointments with mentor and mentee names
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
-- 7. AGGREGATE: Count how many sessions each mentor has completed
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
-- 8. AGGREGATE: Calculate total earnings per mentor
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
-- 9. AGGREGATE WITH HAVING: Find top-rated mentors (average feedback rating ≥ 4.5)
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
-- 10. AGGREGATE: Count total number of programs per university
-- =====================================================
SELECT u.name AS university_name, COUNT(p.program_id) AS total_programs
FROM university u
JOIN program p ON u.university_id = p.university_id
GROUP BY u.name
ORDER BY total_programs DESC;

-- =====================================================
-- 11. NESTED QUERY (NOT IN): Find mentors who have never conducted any sessions
-- (This finds mentors with NO session_appointment records at all)
-- Note: Ken has scheduled/cancelled sessions but no completed sessions with payments
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
-- 12. EXISTS: Find mentees who have active subscriptions
-- =====================================================
SELECT ua.name AS mentee_name, me.current_education_level, me.intended_study_country
FROM mentee me
JOIN user_account ua ON me.user_id = ua.user_id
WHERE EXISTS (SELECT 1 FROM mentee_subscription ms WHERE ms.mentee_id = me.mentee_id AND ms.status = 'active')
ORDER BY ua.name;

-- =====================================================
-- 13. NOT EXISTS: Find universities that have no programs
-- =====================================================
SELECT u.name AS university_name, u.country, u.ranking
FROM university u
WHERE NOT EXISTS (SELECT 1 FROM program p WHERE p.university_id = u.university_id)
ORDER BY u.name;

-- =====================================================
-- 14. CORRELATED SUBQUERY: Find mentors who have more completed sessions than the average
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
-- 15. >=ALL: Find mentors with highest earnings (greater than or equal to ALL others)
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
-- 16. >ANY: Find mentors earning more than ANY mentor in 'Data Science' field
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
-- 17. UNION: Combine active and paused subscriptions
-- =====================================================
SELECT ua.name AS mentee_name, sp.name AS plan_name, ms.status
FROM mentee_subscription ms
JOIN subscription_plan sp ON ms.plan_id = sp.plan_id
JOIN mentee me ON ms.mentee_id = me.mentee_id
JOIN user_account ua ON me.user_id = ua.user_id
WHERE ms.status = 'active'

UNION

SELECT ua.name AS mentee_name, sp.name AS plan_name, ms.status
FROM mentee_subscription ms
JOIN subscription_plan sp ON ms.plan_id = sp.plan_id
JOIN mentee me ON ms.mentee_id = me.mentee_id
JOIN user_account ua ON me.user_id = ua.user_id
WHERE ms.status = 'paused'
ORDER BY mentee_name;

-- =====================================================
-- 18. SUBQUERY IN SELECT CLAUSE: Show mentor name with total earnings as calculated column
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
-- 19. SUBQUERY IN FROM CLAUSE: Use derived table for mentor statistics
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
-- 20. INNER JOIN: List mentees who have given feedback with ratings and comments
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

