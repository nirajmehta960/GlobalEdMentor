-- =======================================================================================================================================
-- USERS & ROLES
-- =======================================================================================================================================
INSERT INTO user_account (user_id, name, email, country, created_at) VALUES
(1,'Niraj Mehta','niraj.mehta@globaledmentor.com','Nepal',NOW()),
(2,'Maya Patel','maya.patel@example.com','India',NOW()),
(3,'Ravi Sharma','ravi.sharma@example.com','India',NOW()),
(4,'Sofia Garcia','sofia.garcia@example.com','Spain',NOW()),
(5,'Ken Tanaka','ken.tanaka@example.com','Japan',NOW()),
(6,'Lina Müller','lina.mueller@example.com','Germany',NOW()),
(7,'Tom Baker','tom.baker@example.com','USA',NOW()),
(8,'Zara Khan','zara.khan@example.com','UAE',NOW()),
(9,'Ben Lee','ben.lee@example.com','Canada',NOW()),
(10,'Priya Nair','priya.nair@example.com','India',NOW()),
(11,'Omar Haddad','omar.haddad@example.com','Egypt',NOW()),
(12,'Eva Rossi','eva.rossi@example.com','Italy',NOW()),
(13,'Rajiv Praveen','rajiv.praveen@globalmentor.com','India',NOW()),
(14,'Mei Lin','mei.lin@example.com','China',NOW()),
(15,'Takeshi Nakamura','takeshi.nakamura@example.com','Japan',NOW()),
(16,'Jung Ho Park','jung.ho.park@example.com','South Korea',NOW()),
(17,'Nguyen Thi Lan','nguyen.lan@example.com','Vietnam',NOW()),
(18,'Farhan Ahmed','farhan.ahmed@example.com','Pakistan',NOW()),
(19,'Aung Kyaw','aung.kyaw@example.com','Myanmar',NOW()),
(20,'Nurul Hasan','nurul.hasan@example.com','Bangladesh',NOW()),
(21,'Siti Nurhaliza','siti.nurhaliza@example.com','Malaysia',NOW()),
(22,'Ananya Sharma','ananya.sharma@example.com','India',NOW()),
(23,'Dinesh Thapa','dinesh.thapa@example.com','Nepal',NOW()),
(24,'Kim Seok Jin','kim.seok.jin@example.com','South Korea',NOW()),
(25,'Thanawat Chai','thanawat.chai@example.com','Thailand',NOW()),
(26,'Hiroshi Tanaka','hiroshi.tanaka@example.com','Japan',NOW()),
(27,'Li Wei','li.wei@example.com','China',NOW()),
(28,'Ravi Patel','ravi.patel@example.com','India',NOW()),
(29,'Trung Le','trung.le@example.com','Vietnam',NOW()),
(30,'Maria Dela Cruz','maria.delacruz@example.com','Philippines',NOW()),
(31,'Sanduni Perera','sanduni.perera@example.com','Sri Lanka',NOW()),
(32,'Putri Ayu','putri.ayu@example.com','Indonesia',NOW());

INSERT INTO admin (admin_id, user_id) VALUES (1001,1), (1002,13);

INSERT INTO mentor
(mentor_id, user_id, education_level, field_of_expertise, years_of_experience, verified) VALUES
(2001,2,'MS','Computer Science',3,TRUE),
(2002,3,'PhD','Data Science',7,TRUE),
(2003,4,'MBA','Business Strategy',5,TRUE),
(2004,5,'MS','Electrical Engineering',6,FALSE),
(2005,6,'PhD','AI/ML',5,TRUE),
(2006,15,'PhD','Mechanical Engineering',10,TRUE),      
(2007,16,'MS','Computer Science',8,TRUE),                
(2008,21,'PhD','Data Analytics',9,TRUE);              

INSERT INTO mentee
(mentee_id, user_id, current_education_level, intended_study_country, target_degree, field_of_interest) VALUES
(3001,7,'BTech','USA','MS','Computer Science'),
(3002,8,'BSc','Canada','MS','Data Science'),
(3003,9,'BEng','USA','MS','Software Engineering'),
(3004,10,'BTech','USA','MEM','Engineering Management'),
(3005,11,'BSc','UK','MBA','Management'),
(3006,12,'BSc','Canada','MS','Analytics'),
(3007,14,'BTech','USA','MS','Artificial Intelligence'),      
(3008,17,'BSc','Canada','MS','Data Science'),                 
(3009,18,'BBA','UK','MBA','International Business'),          
(3010,19,'BSc','Australia','MS','Computer Science'),          
(3011,20,'BEng','Germany','MS','Mechanical Engineering'),     
(3012,22,'BTech','USA','MS','Software Engineering'),          
(3013,23,'BEng','USA','MS','Civil Engineering'),              
(3014,24,'BBA','UK','MBA','Finance and Analytics'),           
(3015,25,'BTech','USA','MS','Information Systems'),          
(3016,26,'BSc','Canada','MS','Robotics'),                     
(3017,27,'BEng','USA','MS','Electrical Engineering'),         
(3018,28,'BTech','USA','MS','Data Analytics'),                
(3019,29,'BSc','Canada','MS','Artificial Intelligence'),      
(3020,30,'BBA','UK','MBA','Marketing Management'),            
(3021,31,'BSc','Australia','MS','Bioinformatics'),            
(3022,32,'BTech','USA','MS','Computer Engineering');    

-- =======================================================================================================================================
-- Messages from mentors, mentees, and admins
-- =======================================================================================================================================
INSERT INTO message (message_id, user_id, body, created_at, read_at) VALUES
(6001,7,'Hi, I would like to confirm my session with Mentor Maya for tomorrow.','2025-01-09 10:30:00','2025-01-09 11:00:00'),
(6002,2,'Yes, the session is confirmed for 10:00 AM. Please be prepared with your resume.','2025-01-09 11:15:00','2025-01-09 11:30:00'),
(6003,8,'Can I reschedule my SOP review session for next week?','2025-01-14 09:00:00','2025-01-14 10:00:00'),
(6004,3,'Sure, please cancel and rebook via your dashboard.','2025-01-14 10:05:00','2025-01-14 11:00:00'),
(6005,11,'Is there any additional charge for mock interviews?','2025-01-16 08:00:00','2025-01-16 08:30:00'),
(6006,6,'Mock interview costs $45 per hour. You can book it anytime.','2025-01-16 09:00:00','2025-01-16 09:15:00'),
(6007,17,'Thank you for today''s SOP guidance session! It was very helpful.','2025-02-12 21:00:00','2025-02-13 09:00:00'),
(6008,15,'Glad to help! Feel free to share your next draft before final submission.','2025-02-13 09:30:00','2025-02-13 10:00:00'),
(6009,18,'Hi, my mock interview session was cancelled. Can I get a refund?','2025-02-20 09:00:00','2025-02-20 10:00:00'),
(6010,1,'We have processed your refund successfully. Please check your dashboard.','2025-02-20 11:00:00',NULL);

-- =======================================================================================================================================
-- Notifications for mentors and mentees
-- =======================================================================================================================================
INSERT INTO notification (notification_id, user_id, type, created_at, read_at) VALUES
(7001,7,'SESSION_REMINDER','2025-01-09 08:00:00','2025-01-09 09:00:00'),           
(7002,8,'PAYMENT_SUCCESS','2025-01-14 10:10:00','2025-01-14 10:30:00'),            
(7003,11,'NEW_FEEDBACK','2025-01-18 15:30:00',NULL),                               
(7004,2,'MENTEE_BOOKED_SESSION','2025-01-09 10:00:00','2025-01-09 10:10:00'),      
(7005,3,'SESSION_CANCELLED','2025-01-22 16:10:00','2025-01-22 16:20:00'),          
(7006,15,'MENTEE_FEEDBACK_RECEIVED','2025-02-12 21:10:00','2025-02-13 09:30:00'),  
(7007,21,'NEW_SESSION_BOOKED','2025-02-18 18:05:00',NULL),                         
(7008,17,'SESSION_COMPLETED','2025-02-12 22:00:00','2025-02-13 08:00:00'),         
(7009,18,'REFUND_PROCESSED','2025-02-20 11:00:00',NULL),                           
(7010,14,'SUBSCRIPTION_RENEWAL','2025-03-01 09:00:00',NULL);                       
 
-- =======================================================================================================================================
-- UNIVERSITIES 
-- =======================================================================================================================================
INSERT INTO university (university_id, name, country, ranking, tuition_estimate) VALUES
(4001,'Harvard University','USA',3,65500),
(4002,'Northeastern University','USA',53,59000),
(4003,'Massachusetts Institute of Technology (MIT)','USA',1,58000),
(4004,'Stanford University','USA',4,62000),
(4005,'University of California, Berkeley','USA',20,48000),
(4006,'Carnegie Mellon University','USA',22,57000),
(4007,'University of Washington','USA',60,42000),
(4008,'Georgia Institute of Technology','USA',44,39000),
(4009,'University of Michigan, Ann Arbor','USA',25,47000),
(4010,'University of British Columbia','Canada',40,32000),
(4011,'University of Oxford','United Kingdom',5,48000),
(4012,'ETH Zurich','Switzerland',7,2000),
(4013,'University of Toronto','Canada',18,45000),
(4014,'National University of Singapore (NUS)','Singapore',8,30000),
(4015,'University of Cambridge','United Kingdom',2,50000),
(4016,'Imperial College London','United Kingdom',6,45000),
(4017,'University of Melbourne','Australia',34,36000),
(4018,'Technical University of Munich (TUM)','Germany',37,2000);

-- =======================================================================================================================================
-- PROGRAM DATA for each Universities
-- =======================================================================================================================================
-- 1. Harvard University
INSERT INTO program (program_id, university_id, name, degree_level, requirements, tuition, duration_months) VALUES
(5001,4001,'MBA','MBA','SOP, Resume, 2–3 LORs, GMAT/GRE, essays, leadership experience, optional mock interview',65500,24),
(5002,4001,'MS in Computer Science','MS','SOP, Resume, 3 LORs, transcripts, strong math/CS foundation, portfolio preferred',65500,24);

-- 2. Northeastern University
INSERT INTO program VALUES
(5003,4002,'MS in Engineering Management','MS','SOP, Resume, 2 LORs, transcripts, GRE optional, interview may be required',59000,18),
(5004,4002,'MS in Computer Science','MS','SOP, Resume, 3 LORs, DSA background, coding assessment or portfolio preferred',59000,24),
(5005,4002,'MS in Data Science','MS','SOP, Resume, 3 LORs, Stats/Programming, Python/R proficiency, technical interview possible',59000,20);

-- 3. Massachusetts Institute of Technology (MIT)
INSERT INTO program VALUES
(5006,4003,'MS in Computer Science','MS','SOP, Resume, 3 LORs, research statement, coding portfolio, publications preferred',58000,24),
(5007,4003,'MS in Artificial Intelligence','MS','SOP, Resume, 3 LORs, Math/ML/AI background, research papers, GitHub portfolio',58000,24),
(5008,4003,'MS in Electrical Engineering','MS','SOP, Resume, 3 LORs, circuits/systems background, project report or mock interview',58000,24);

-- 4. Stanford University
INSERT INTO program VALUES
(5009,4004,'MS in Computer Science','MS','SOP, Resume, 3 LORs, CS theory and systems, coding test may apply',62000,24),
(5010,4004,'MS in Data Science','MS','SOP, Resume, 3 LORs, Stats/ML/Programming, Python/R test, case study optional',62000,24),
(5011,4004,'MS in Management Science & Engineering','MS','SOP, Resume, 2–3 LORs, quantitative reasoning, optional interview',62000,24);

-- 5. University of California, Berkeley
INSERT INTO program VALUES
(5012,4005,'MEng in EECS','MEng','SOP, Resume, 2–3 LORs, project portfolio, optional mock interview',48000,12),
(5013,4005,'MS in Data Science','MS','SOP, Resume, 3 LORs, Stats/Programming, analytics case or coding exercise',48000,18),
(5014,4005,'MS in Computer Science','MS','SOP, Resume, 3 LORs, research statement, coding test optional',48000,24);

-- 6. Carnegie Mellon University
INSERT INTO program VALUES
(5015,4006,'MS in Software Engineering','MS','SOP, Resume, 3 LORs, SE project portfolio, technical interview',57000,18),
(5016,4006,'MS in Artificial Intelligence & Innovation','MS','SOP, Resume, 3 LORs, ML project portfolio, product pitch presentation',57000,18),
(5017,4006,'MS in Information Security','MS','SOP, Resume, 3 LORs, cybersecurity experience, CTF/portfolio preferred',57000,18);

-- 7. University of Washington
INSERT INTO program VALUES
(5018,4007,'MS in Computer Science & Engineering','MS','SOP, Resume, 3 LORs, systems/ML focus, coding assessment',42000,24),
(5019,4007,'MS in Data Science','MS','SOP, Resume, 3 LORs, Stats/Programming, Python test or interview',42000,20),
(5020,4007,'MS in Information Management','MS','SOP, Resume, 2–3 LORs, statement of purpose video optional',42000,18);

-- 8. Georgia Institute of Technology
INSERT INTO program VALUES
(5021,4008,'MS in Analytics','MS','SOP, Resume, 3 LORs, Calc/Stats, Python proficiency, analytics case exercise',39000,24),
(5022,4008,'MS in Computer Science','MS','SOP, Resume, 3 LORs, algorithms/systems, coding test may apply',39000,24),
(5023,4008,'MS in Electrical & Computer Engineering','MS','SOP, Resume, 3 LORs, ECE foundation, project portfolio',39000,24);

-- 9. University of Michigan, Ann Arbor
INSERT INTO program VALUES
(5024,4009,'MS in Computer Science and Engineering','MS','SOP, Resume, 3 LORs, CS background, coding samples or project report',47000,24),
(5025,4009,'MS in Robotics','MS','SOP, Resume, 3 LORs, Mech/EE/CS background, video portfolio optional',47000,24),
(5026,4009,'MS in Data Science','MS','SOP, Resume, 3 LORs, Stats/ML, Python coding test optional',47000,24);

-- 10. University of British Columbia
INSERT INTO program VALUES
(5027,4010,'MEng in Electrical & Computer Engineering','MEng','SOP, Resume, 2–3 LORs, project portfolio',32000,18),
(5028,4010,'Master of Data Science','MS','SOP, Resume, 3 LORs, Stats/Programming, coding test or case',31000,10),
(5029,4010,'MS in Computer Science','MS','SOP, Resume, 3 LORs, research experience, GitHub portfolio optional',30000,24);

-- 11. University of Oxford
INSERT INTO program VALUES
(5030,4011,'MSc in Computer Science','MS','SOP, Resume, 3 LORs, written test/interview',48000,12),
(5031,4011,'MSc in Advanced Computer Science','MS','SOP, Resume, 3 LORs, research statement, interview',48000,12),
(5032,4011,'MSc in Software Engineering','MS','SOP, Resume, 3 LORs, professional experience, interview required',47000,24);

-- 12. ETH Zurich
INSERT INTO program VALUES
(5033,4012,'MSc in Computer Science','MS','SOP, Resume, 2–3 LORs, strong math/CS foundation, project portfolio',1800,24),
(5034,4012,'MSc in Data Science','MS','SOP, Resume, 3 LORs, Stats/ML/Python, research project optional',1800,24),
(5035,4012,'MSc in Electrical Engineering & IT','MS','SOP, Resume, 2–3 LORs, EE fundamentals, design portfolio',1800,24);

-- 13. University of Toronto
INSERT INTO program VALUES
(5036,4013,'MS in Computer Science','MS','SOP, Resume, 3 LORs, CS background, coding test or interview',45000,24),
(5037,4013,'Master of Data Science','MS','SOP, Resume, 3 LORs, Stats/Programming, case study exercise',44000,20),
(5038,4013,'MEng in Electrical & Computer Engineering','MEng','SOP, Resume, 2–3 LORs, project work, optional interview',42000,18);

-- 14. National University of Singapore (NUS)
INSERT INTO program VALUES
(5039,4014,'MComp (Computer Science)','MS','SOP, Resume, 3 LORs, coding assessment required, portfolio optional',30000,24),
(5040,4014,'MSc in Data Science & Machine Learning','MS','SOP, Resume, 3 LORs, Stats/ML, Python test',31000,18),
(5041,4014,'MSc in Cybersecurity','MS','SOP, Resume, 3 LORs, security projects, interview required',30000,18);

-- 15. University of Cambridge
INSERT INTO program VALUES
(5042,4015,'MPhil in Advanced Computer Science','MS','SOP, Resume, 3 LORs, research proposal, interview required',50000,12),
(5043,4015,'MPhil in Machine Learning & Machine Intelligence','MS','SOP, Resume, 3 LORs, math/ML depth, coding test',50000,12),
(5044,4015,'MPhil in Technology Policy','MS','SOP, Resume, 2–3 LORs, policy essay, interview',48000,9);

-- 16. Imperial College London
INSERT INTO program VALUES
(5045,4016,'MSc Computing','MS','SOP, Resume, 3 LORs, algorithms/systems, coding test required',46000,12),
(5046,4016,'MSc Artificial Intelligence','MS','SOP, Resume, 3 LORs, ML/AI portfolio, interview optional',45000,12),
(5047,4016,'MSc Advanced Computing (ML/AI)','MS','SOP, Resume, 3 LORs, research statement, project portfolio',47000,12);

-- 17. University of Melbourne
INSERT INTO program VALUES
(5048,4017,'Master of Information Technology','MS','SOP, Resume, 2–3 LORs, CS/IT background, coding samples',36000,24),
(5049,4017,'Master of Data Science','MS','SOP, Resume, 3 LORs, Stats/ML, Python test optional',37000,24),
(5050,4017,'Master of Engineering (Software)','MEng','SOP, Resume, 2–3 LORs, software projects, interview required',35000,24);

-- 18. Technical University of Munich (TUM)
INSERT INTO program VALUES
(5051,4018,'MSc in Informatics (Computer Science)','MS','SOP, Resume, 2–3 LORs, math/CS, portfolio optional',2000,24),
(5052,4018,'MSc in Data Engineering & Analytics','MS','SOP, Resume, 3 LORs, Stats/ML, Python test',2000,24),
(5053,4018,'MSc in Electrical Engineering & Information Technology','MS','SOP, Resume, 2–3 LORs, EE fundamentals, design portfolio',2000,24);

-- Mentor affiliations (a few samples)
INSERT INTO mentor_university (mentor_id, university_id, relation, since_year) VALUES
(2001,4002,'alumni',2018),
(2002,4006,'current_student',2025),
(2003,4001,'alumni',2017),
(2004,4008,'alumni',2019),
(2005,4012,'current_student',2025),
(2006,4009,'alumni',2016),          
(2007,4004,'alumni',2015),          
(2008,4015,'current_student',2023); 

-- Mentee program targets (corrected IDs)
INSERT INTO mentee_target_program (mentee_id, program_id, added_at) VALUES
(3001,5004,NOW()),  
(3001,5009,NOW()),  
(3002,5028,NOW()),  
(3003,5021,NOW()),  
(3004,5003,NOW()),  
(3005,5030,NOW()),  
(3006,5013,NOW()),
(3007,5005,NOW()),  
(3008,5028,NOW()),  
(3009,5001,NOW()),  
(3010,5022,NOW()),  
(3011,5053,NOW()),  
(3012,5015,NOW()),  
(3013,5025,NOW()),  
(3014,5044,NOW()),  
(3015,5004,NOW()),  
(3016,5036,NOW()), 
(3017,5023,NOW()),  
(3018,5021,NOW()),  
(3019,5007,NOW()), 
(3020,5001,NOW()),  
(3021,5049,NOW()),  
(3022,5024,NOW());  

-- =======================================================================================================================================
-- SERVICES per mentor
-- =======================================================================================================================================
INSERT INTO service (service_id, mentor_id, description, price_per_hour, is_active) VALUES
(7001,2001,'Comprehensive Application Mentorship',400.00,TRUE),
(7002,2001,'Resume Review',35.00,TRUE),
(7003,2001,'SOP Guidance',40.00,TRUE),
(7004,2001,'Mock Interview',45.00,TRUE),
(7011,2002,'Comprehensive Application Mentorship',400.00,TRUE),
(7012,2002,'Resume Review',35.00,TRUE),
(7013,2002,'SOP Guidance',40.00,TRUE),
(7014,2002,'Mock Interview',45.00,TRUE),
(7021,2003,'Comprehensive Application Mentorship',400.00,TRUE),
(7022,2003,'Resume Review',35.00,TRUE),
(7023,2003,'SOP Guidance',40.00,TRUE),
(7024,2003,'Mock Interview',45.00,TRUE),
(7031,2004,'Comprehensive Application Mentorship',400.00,TRUE),
(7032,2004,'Resume Review',35.00,TRUE),
(7033,2004,'SOP Guidance',40.00,TRUE),
(7034,2004,'Mock Interview',45.00,TRUE),
(7041,2005,'Comprehensive Application Mentorship',400.00,TRUE),
(7042,2005,'Resume Review',35.00,TRUE),
(7043,2005,'SOP Guidance',40.00,TRUE),
(7044,2005,'Mock Interview',45.00,TRUE),
(7051,2006,'Resume Review',35.00,TRUE),
(7052,2006,'SOP Guidance',40.00,TRUE),
(7061,2007,'Comprehensive Application Mentorship',400.00,TRUE),
(7062,2007,'Mock Interview',45.00,TRUE),
(7071,2008,'Resume Review',35.00,TRUE),
(7072,2008,'SOP Guidance',40.00,TRUE),
(7073,2008,'Mock Interview',45.00,TRUE);

-- =======================================================================================================================================
-- SESSIONS (all 60 minutes) + PAYMENTS + FEEDBACK
-- mix of completed, scheduled, cancelled
-- =======================================================================================================================================
INSERT INTO session_appointment
(session_id, service_id, mentee_id, start_time, duration_min, status) VALUES
(7101,7002,3001,'2025-01-10 10:00:00',60,'completed'),  
(7102,7024,3005,'2025-01-12 09:00:00',60,'completed'),  
(7103,7013,3002,'2025-01-15 20:00:00',60,'completed'),  
(7104,7021,3005,'2025-01-18 14:00:00',60,'completed'),  
(7105,7044,3006,'2025-01-20 08:30:00',60,'completed'),  
(7106,7033,3004,'2025-02-05 11:00:00',60,'scheduled'),  
(7107,7014,3002,'2025-02-06 19:00:00',60,'scheduled'),  
(7108,7032,3002,'2025-01-22 16:00:00',60,'cancelled'),  
(7109,7012,3002,'2025-02-01 18:30:00',60,'completed'),  
(7110,7022,3005,'2025-02-03 12:00:00',60,'completed'),
(7111,7051,3007,'2025-02-10 09:00:00',60,'completed'),   
(7112,7052,3008,'2025-02-12 20:00:00',60,'completed'),   
(7113,7051,3012,'2025-02-22 11:00:00',60,'completed'),   
(7114,7052,3015,'2025-03-02 14:00:00',60,'scheduled'),   
(7115,7071,3009,'2025-02-15 08:30:00',60,'scheduled'),   
(7116,7073,3010,'2025-02-18 18:00:00',60,'completed'),   
(7117,7072,3011,'2025-02-20 10:00:00',60,'cancelled'),  
(7118,7071,3013,'2025-02-25 19:30:00',60,'completed'),   
(7119,7073,3014,'2025-02-28 07:30:00',60,'scheduled'),   
(7120,7072,3016,'2025-03-05 16:00:00',60,'completed');   

-- =======================================================================================================================================
-- PAYMENTS (captured/refunded) + link to sessions
-- =======================================================================================================================================
INSERT INTO payment (payment_id, amount, method, status, created_at) VALUES
(9001,35.00,'card','captured','2025-01-10 10:10:00'),  
(9002,45.00,'card','captured','2025-01-12 09:50:00'),   
(9003,40.00,'paypal','captured','2025-01-15 20:05:00'), 
(9004,400.00,'card','captured','2025-01-18 14:05:00'),  
(9005,45.00,'card','captured','2025-01-20 08:40:00'),  
(9006,35.00,'card','refunded','2025-01-22 16:10:00'),   
(9007,35.00,'card','captured','2025-02-01 18:40:00'),   
(9008,35.00,'card','captured','2025-02-03 12:05:00'),
(9013,35.00,'card','captured','2025-02-10 09:10:00'),   
(9014,40.00,'card','captured','2025-02-12 20:05:00'),   
(9015,35.00,'paypal','captured','2025-02-22 11:10:00'), 
(9016,40.00,'card','pending','2025-03-02 14:10:00'),    
(9017,35.00,'card','pending','2025-02-15 08:40:00'),    
(9018,45.00,'card','captured','2025-02-18 18:10:00'),   
(9019,40.00,'card','refunded','2025-02-20 10:15:00'),   
(9020,35.00,'paypal','captured','2025-02-25 19:40:00'), 
(9021,45.00,'card','pending','2025-02-28 07:40:00'),    
(9022,40.00,'card','captured','2025-03-05 16:10:00');   

INSERT INTO session_payment (payment_id, session_id) VALUES
(9001,7101),
(9002,7102),
(9003,7103),
(9004,7104),
(9005,7105),
(9007,7109),
(9008,7110),
(9013,7111),
(9014,7112),
(9015,7113),
(9016,7114),
(9017,7115),
(9018,7116),
(9020,7118),
(9021,7119),
(9022,7120);

-- =======================================================================================================================================
-- FEEDBACK for completed sessions only
-- =======================================================================================================================================
INSERT INTO feedback (feedback_id, session_id, rating, comments, created_at) VALUES
(9501,7101,5,'Great resume structure and bullet points.',NOW()),
(9502,7102,4,'Mock interview felt realistic and helpful.',NOW()),
(9503,7103,5,'SOP guidance clarified my narrative.',NOW()),
(9504,7104,5,'Comprehensive mentorship covered everything I needed.',NOW()),
(9505,7105,5,'Excellent AI/ML interview practice.',NOW()),
(9506,7109,4,'Concise resume polish with clear impact metrics.',NOW()),
(9507,7110,4,'Useful feedback on achievements and ordering.',NOW()),
(9508,7111,5,'Very clear resume suggestions tailored to my target roles.',NOW()),
(9509,7112,4,'SOP review helped me refine my story and career goals.',NOW()),
(9510,7113,5,'Resume feedback was detailed and easy to apply.',NOW()),
(9511,7116,5,'Mock interview felt realistic and boosted my confidence.',NOW()),
(9512,7118,4,'Good resume review with concrete examples to improve impact.',NOW()),
(9513,7120,5,'SOP guidance clarified my motivation and future plans.',NOW());

-- =======================================================================================================================================
-- DOCUMENTS (example mentor resources)
-- =======================================================================================================================================
INSERT INTO document (document_id, mentor_id, doc_type, storage_url, uploaded_at) VALUES
(9601,2001,'Guide','https://files.example.com/guides/cs_sop_tips.pdf',NOW()),
(9602,2003,'Template','https://files.example.com/templates/mba_resume.docx',NOW()),
(9603,2005,'Checklist','https://files.example.com/checklists/ml_application.csv',NOW()),
(9604,2006,'Template','https://files.example.com/templates/mechanical_resume_template.docx',NOW()),
(9605,2006,'Guide','https://files.example.com/guides/statement_of_purpose_mechanical.pdf',NOW()),
(9606,2007,'Guide','https://files.example.com/guides/mit_interview_tips.pdf',NOW()),
(9607,2007,'Checklist','https://files.example.com/checklists/application_essentials_cs.csv',NOW()),
(9608,2008,'Guide','https://files.example.com/guides/data_analytics_portfolio_tips.pdf',NOW()),
(9609,2008,'Template','https://files.example.com/templates/data_analytics_resume.docx',NOW());

-- =======================================================================================================================================
-- SUBSCRIPTIONS 
-- Monthly = 1 hourly credit; Yearly = comprehensive package included
-- =======================================================================================================================================
INSERT INTO subscription_plan (plan_id, name, billing_period, price, is_active) VALUES
(10001,'Monthly Mentor Access','monthly',49.99,TRUE),
(10002,'Yearly Comprehensive Mentorship','yearly',499.00,TRUE);

INSERT INTO mentee_subscription
(subscription_id, mentee_id, plan_id, status, started_at, ended_at, next_billing_at, locked_price) VALUES
(11001,3001,10001,'active','2025-01-01',NULL,'2025-02-01',49.99),
(11002,3002,10002,'active','2024-09-01',NULL,'2025-09-01',499.00),
(11003,3005,10001,'paused','2025-01-05',NULL,'2025-02-05',49.99),
(11004,3007,10001,'active','2025-02-01',NULL,'2025-03-01',49.99),   
(11005,3008,10002,'active','2025-01-10',NULL,'2026-01-10',499.00), 
(11006,3009,10001,'active','2025-02-05',NULL,'2025-03-05',49.99),  
(11007,3010,10001,'active','2025-02-05',NULL,'2025-03-05',49.99),  
(11008,3011,10002,'active','2025-01-20',NULL,'2026-01-20',499.00), 
(11009,3012,10001,'cancelled','2025-01-05','2025-02-05',NULL,49.99), 
(11010,3013,10001,'active','2025-02-01',NULL,'2025-03-01',49.99),  
(11011,3014,10002,'active','2025-01-12',NULL,'2026-01-12',499.00), 
(11012,3015,10001,'active','2025-02-07',NULL,'2025-03-07',49.99),  
(11013,3016,10001,'paused','2025-02-10',NULL,'2025-03-10',49.99);  

INSERT INTO payment (payment_id, amount, method, status, created_at) VALUES
(8010,49.99,'card','captured','2025-01-01 00:10:00'),
(8011,499.00,'card','captured','2024-09-01 00:20:00'),
(8012,49.99,'card','captured','2025-02-01 00:10:00'),
(9023,49.99,'card','captured','2025-02-01 00:10:00'),   
(9024,499.00,'card','captured','2025-01-10 00:15:00'),  
(9025,49.99,'paypal','captured','2025-02-05 00:20:00'), 
(9026,49.99,'card','captured','2025-02-05 00:25:00'),   
(9027,499.00,'card','captured','2025-01-20 00:30:00'),  
(9028,49.99,'card','refunded','2025-02-05 00:35:00'),   
(9029,49.99,'card','captured','2025-02-01 00:40:00'),   
(9030,499.00,'card','captured','2025-01-12 00:45:00'),  
(9031,49.99,'card','captured','2025-02-07 00:50:00'),   
(9032,49.99,'card','pending','2025-02-10 00:55:00');    

INSERT INTO subscription_payment (payment_id, subscription_id, period_start, period_end) VALUES
(8010,11001,'2025-01-01','2025-01-31'),
(8011,11002,'2024-09-01','2025-08-31'),
(8012,11001,'2025-02-01','2025-02-28'),
(9023,11004,'2025-02-01','2025-02-28'),
(9024,11005,'2025-01-10','2026-01-09'),
(9025,11006,'2025-02-05','2025-03-04'),
(9026,11007,'2025-02-05','2025-03-04'),
(9027,11008,'2025-01-20','2026-01-19'),
(9028,11009,'2025-01-05','2025-02-05'),
(9029,11010,'2025-02-01','2025-02-28'),
(9030,11011,'2025-01-12','2026-01-11'),
(9031,11012,'2025-02-07','2025-03-06'),
(9032,11013,'2025-02-10','2025-03-09');

-- =======================================================================================================================================
-- PAYOUTS (example aggregates for Jan 2025, consistent with above)
-- mentor 2001: 35 | mentor 2002: 40+35=75 | mentor 2003: 45+400+35=480 | mentor 2004: 0 | mentor 2005: 45 | mentor 2006: 35+40+35
-- mentor 2008: 45+35+40
-- =======================================================================================================================================
INSERT INTO payout (payout_id, mentor_id, amount_total, period_start, period_end, status) VALUES
(12001,2001,35.00,'2025-01-01','2025-01-31','paid'),
(12002,2002,75.00,'2025-01-01','2025-01-31','paid'),
(12003,2003,480.00,'2025-01-01','2025-01-31','paid'),
(12004,2004,0.00,'2025-01-01','2025-01-31','paid'),
(12005,2005,45.00,'2025-01-01','2025-01-31','paid'),
(12006,2006,110.00,'2025-02-01','2025-02-28','paid'),  
(12007,2007,0.00,'2025-02-01','2025-02-28','paid'),    
(12008,2008,120.00,'2025-02-01','2025-02-28','paid');  

