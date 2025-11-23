CREATE DATABASE IF NOT EXISTS GlobalEdMentor;
USE GlobalEdMentor;

-- GlobalEdMentor Database Schema 

-- ===== User Accounts =====
CREATE TABLE user_account (
  user_id BIGINT PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  country VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE admin (
  admin_id BIGINT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);

CREATE TABLE message (
  message_id BIGINT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  body TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  read_at TIMESTAMP NULL,
  FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);

CREATE TABLE notification (
  notification_id BIGINT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  type VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  read_at TIMESTAMP NULL,
  FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);

-- ===== Roles =====
CREATE TABLE mentor (
  mentor_id BIGINT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  education_level VARCHAR(120) NOT NULL,
  field_of_expertise VARCHAR(200) NOT NULL,
  years_of_experience INT DEFAULT 0,
  verified BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);

CREATE TABLE mentee (
  mentee_id BIGINT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  current_education_level VARCHAR(120) NOT NULL,
  intended_study_country VARCHAR(100),
  target_degree VARCHAR(120),
  field_of_interest VARCHAR(200),
  FOREIGN KEY (user_id) REFERENCES user_account(user_id)
);

-- ===== Universities & Programs =====
CREATE TABLE university (
  university_id BIGINT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  country VARCHAR(100) NOT NULL,
  ranking INT,
  tuition_estimate DECIMAL(12,2)
);

CREATE TABLE program (
  program_id BIGINT PRIMARY KEY,
  university_id BIGINT NOT NULL,
  name VARCHAR(255) NOT NULL,
  degree_level VARCHAR(100) NOT NULL,
  requirements TEXT,
  tuition DECIMAL(12,2),
  duration_months INT,
  FOREIGN KEY (university_id) REFERENCES university(university_id)
);

CREATE TABLE mentor_university (
  mentor_id BIGINT NOT NULL,
  university_id BIGINT NOT NULL,
  relation VARCHAR(120),
  since_year INT,
  PRIMARY KEY (mentor_id, university_id),
  FOREIGN KEY (mentor_id) REFERENCES mentor(mentor_id),
  FOREIGN KEY (university_id) REFERENCES university(university_id)
);

CREATE TABLE mentee_target_program (
  mentee_id BIGINT NOT NULL,
  program_id BIGINT NOT NULL,
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (mentee_id, program_id),
  FOREIGN KEY (mentee_id) REFERENCES mentee(mentee_id),
  FOREIGN KEY (program_id) REFERENCES program(program_id)
);

-- ===== Services & Sessions =====
CREATE TABLE service (
  service_id BIGINT PRIMARY KEY,
  mentor_id BIGINT NOT NULL,
  description TEXT NOT NULL,
  price_per_hour DECIMAL(10,2) NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (mentor_id) REFERENCES mentor(mentor_id)
);

CREATE TABLE session_appointment (
  session_id BIGINT PRIMARY KEY,
  service_id BIGINT NOT NULL,
  mentee_id BIGINT NOT NULL,
  start_time DATETIME NOT NULL,
  duration_min INT NOT NULL,
  status VARCHAR(40) NOT NULL,
  FOREIGN KEY (service_id) REFERENCES service(service_id),
  FOREIGN KEY (mentee_id) REFERENCES mentee(mentee_id)
);

CREATE TABLE feedback (
  feedback_id BIGINT PRIMARY KEY,
  session_id BIGINT NOT NULL,
  rating TINYINT NOT NULL,
  comments TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (session_id) REFERENCES session_appointment(session_id)
);

CREATE TABLE document (
  document_id BIGINT PRIMARY KEY,
  mentor_id BIGINT NOT NULL,
  doc_type VARCHAR(100) NOT NULL,
  storage_url VARCHAR(500) NOT NULL,
  uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (mentor_id) REFERENCES mentor(mentor_id)
);

-- ===== Payments & Billing =====
CREATE TABLE payment (
  payment_id BIGINT PRIMARY KEY,
  amount DECIMAL(12,2) NOT NULL,
  method VARCHAR(50) NOT NULL,
  status VARCHAR(40) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE session_payment (
  payment_id BIGINT NOT NULL PRIMARY KEY,
  session_id BIGINT NOT NULL UNIQUE,
  FOREIGN KEY (payment_id) REFERENCES payment(payment_id),
  FOREIGN KEY (session_id) REFERENCES session_appointment(session_id)
);

CREATE TABLE subscription_plan (
  plan_id BIGINT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  billing_period VARCHAR(40) NOT NULL,
  price DECIMAL(12,2) NOT NULL,
  is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE mentee_subscription (
  subscription_id BIGINT PRIMARY KEY,
  mentee_id BIGINT NOT NULL,
  plan_id BIGINT NOT NULL,
  status VARCHAR(40) NOT NULL,
  started_at DATETIME NOT NULL,
  ended_at DATETIME,
  next_billing_at DATETIME,
  locked_price DECIMAL(12,2),
  FOREIGN KEY (mentee_id) REFERENCES mentee(mentee_id),
  FOREIGN KEY (plan_id) REFERENCES subscription_plan(plan_id)
);

CREATE TABLE subscription_payment (
  payment_id BIGINT NOT NULL PRIMARY KEY,
  subscription_id BIGINT NOT NULL,
  period_start DATETIME NOT NULL,
  period_end DATETIME NOT NULL,
  FOREIGN KEY (payment_id) REFERENCES payment(payment_id),
  FOREIGN KEY (subscription_id) REFERENCES mentee_subscription(subscription_id)
);

CREATE TABLE payout (
  payout_id BIGINT PRIMARY KEY,
  mentor_id BIGINT NOT NULL,
  amount_total DECIMAL(12,2) NOT NULL,
  period_start DATETIME NOT NULL,
  period_end DATETIME NOT NULL,
  status VARCHAR(40) NOT NULL,
  FOREIGN KEY (mentor_id) REFERENCES mentor(mentor_id)
);
