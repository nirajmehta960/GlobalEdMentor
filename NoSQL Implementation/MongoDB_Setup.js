// MongoDB Setup for GlobalEdMentor Platform
// Use this file in MongoDB Compass or MongoDB Shell
// Database: GlobalEdMentor

use("GlobalEdMentor");

// =======================================================================================================================================
// COLLECTION 1: mentors
// Embedded user_account information for denormalized structure
// =======================================================================================================================================
db.mentors.insertMany([
  {
    mentor_id: 2001,
    user: {
      user_id: 2,
      name: "Maya Patel",
      email: "maya.patel@example.com",
      country: "India",
    },
    education_level: "MS",
    field_of_expertise: "Computer Science",
    years_of_experience: 3,
    verified: true,
    universities: [
      {
        university_id: 4003,
        name: "Massachusetts Institute of Technology (MIT)",
        country: "USA",
        relation: "alumni",
        since_year: 2020,
      },
    ],
  },
  {
    mentor_id: 2002,
    user: {
      user_id: 3,
      name: "Ravi Sharma",
      email: "ravi.sharma@example.com",
      country: "India",
    },
    education_level: "PhD",
    field_of_expertise: "Data Science",
    years_of_experience: 7,
    verified: true,
    universities: [
      {
        university_id: 4002,
        name: "Northeastern University",
        country: "USA",
        relation: "alumni",
        since_year: 2018,
      },
    ],
  },
  {
    mentor_id: 2003,
    user: {
      user_id: 4,
      name: "Sofia Garcia",
      email: "sofia.garcia@example.com",
      country: "Spain",
    },
    education_level: "MBA",
    field_of_expertise: "Business Strategy",
    years_of_experience: 5,
    verified: true,
    universities: [
      {
        university_id: 4001,
        name: "Harvard University",
        country: "USA",
        relation: "alumni",
        since_year: 2020,
      },
    ],
  },
  {
    mentor_id: 2004,
    user: {
      user_id: 5,
      name: "Ken Tanaka",
      email: "ken.tanaka@example.com",
      country: "Japan",
    },
    education_level: "MS",
    field_of_expertise: "Electrical Engineering",
    years_of_experience: 6,
    verified: false,
    universities: [
      {
        university_id: 4008,
        name: "Georgia Institute of Technology",
        country: "USA",
        relation: "alumni",
        since_year: 2019,
      },
    ],
  },
  {
    mentor_id: 2005,
    user: {
      user_id: 6,
      name: "Lina Müller",
      email: "lina.mueller@example.com",
      country: "Germany",
    },
    education_level: "PhD",
    field_of_expertise: "AI/ML",
    years_of_experience: 5,
    verified: true,
    universities: [
      {
        university_id: 4003,
        name: "Massachusetts Institute of Technology (MIT)",
        country: "USA",
        relation: "alumni",
        since_year: 2020,
      },
    ],
  },
  {
    mentor_id: 2006,
    user: {
      user_id: 15,
      name: "Takeshi Nakamura",
      email: "takeshi.nakamura@example.com",
      country: "Japan",
    },
    education_level: "PhD",
    field_of_expertise: "Mechanical Engineering",
    years_of_experience: 10,
    verified: true,
    universities: [
      {
        university_id: 4003,
        name: "Massachusetts Institute of Technology (MIT)",
        country: "USA",
        relation: "alumni",
        since_year: 2015,
      },
    ],
  },
  {
    mentor_id: 2007,
    user: {
      user_id: 16,
      name: "Jung Ho Park",
      email: "jung.ho.park@example.com",
      country: "South Korea",
    },
    education_level: "MS",
    field_of_expertise: "Computer Science",
    years_of_experience: 8,
    verified: true,
    universities: [
      {
        university_id: 4004,
        name: "Stanford University",
        country: "USA",
        relation: "alumni",
        since_year: 2017,
      },
    ],
  },
  {
    mentor_id: 2008,
    user: {
      user_id: 21,
      name: "Siti Nurhaliza",
      email: "siti.nurhaliza@example.com",
      country: "Malaysia",
    },
    education_level: "PhD",
    field_of_expertise: "Data Analytics",
    years_of_experience: 9,
    verified: true,
    universities: [
      {
        university_id: 4002,
        name: "Northeastern University",
        country: "USA",
        relation: "alumni",
        since_year: 2016,
      },
    ],
  },
]);

// =======================================================================================================================================
// COLLECTION 2: mentees
// Embedded user_account and target programs information
// =======================================================================================================================================
db.mentees.insertMany([
  {
    mentee_id: 3001,
    user: {
      user_id: 7,
      name: "Tom Baker",
      email: "tom.baker@example.com",
      country: "USA",
    },
    current_education_level: "BTech",
    intended_study_country: "USA",
    target_degree: "MS",
    field_of_interest: "Computer Science",
    target_programs: [
      {
        program_id: 5004,
        program_name: "MS in Computer Science",
        university_name: "Northeastern University",
        university_country: "USA",
      },
    ],
  },
  {
    mentee_id: 3002,
    user: {
      user_id: 8,
      name: "Zara Khan",
      email: "zara.khan@example.com",
      country: "UAE",
    },
    current_education_level: "BSc",
    intended_study_country: "Canada",
    target_degree: "MS",
    field_of_interest: "Data Science",
    target_programs: [
      {
        program_id: 5005,
        program_name: "MS in Data Science",
        university_name: "Northeastern University",
        university_country: "USA",
      },
    ],
  },
  {
    mentee_id: 3003,
    user: {
      user_id: 9,
      name: "Ben Lee",
      email: "ben.lee@example.com",
      country: "Canada",
    },
    current_education_level: "BEng",
    intended_study_country: "USA",
    target_degree: "MS",
    field_of_interest: "Software Engineering",
    target_programs: [
      {
        program_id: 5004,
        program_name: "MS in Computer Science",
        university_name: "Northeastern University",
        university_country: "USA",
      },
    ],
  },
  {
    mentee_id: 3004,
    user: {
      user_id: 10,
      name: "Priya Nair",
      email: "priya.nair@example.com",
      country: "India",
    },
    current_education_level: "BTech",
    intended_study_country: "USA",
    target_degree: "MEM",
    field_of_interest: "Engineering Management",
    target_programs: [
      {
        program_id: 5003,
        program_name: "MS in Engineering Management",
        university_name: "Northeastern University",
        university_country: "USA",
      },
    ],
  },
  {
    mentee_id: 3005,
    user: {
      user_id: 11,
      name: "Omar Haddad",
      email: "omar.haddad@example.com",
      country: "Egypt",
    },
    current_education_level: "BSc",
    intended_study_country: "UK",
    target_degree: "MBA",
    field_of_interest: "Management",
    target_programs: [
      {
        program_id: 5001,
        program_name: "MBA",
        university_name: "Harvard University",
        university_country: "USA",
      },
    ],
  },
  {
    mentee_id: 3006,
    user: {
      user_id: 12,
      name: "Eva Rossi",
      email: "eva.rossi@example.com",
      country: "Italy",
    },
    current_education_level: "BSc",
    intended_study_country: "Canada",
    target_degree: "MS",
    field_of_interest: "Analytics",
    target_programs: [
      {
        program_id: 5005,
        program_name: "MS in Data Science",
        university_name: "Northeastern University",
        university_country: "USA",
      },
    ],
  },
  {
    mentee_id: 3007,
    user: {
      user_id: 14,
      name: "Mei Lin",
      email: "mei.lin@example.com",
      country: "China",
    },
    current_education_level: "BTech",
    intended_study_country: "USA",
    target_degree: "MS",
    field_of_interest: "Artificial Intelligence",
    target_programs: [
      {
        program_id: 5007,
        program_name: "MS in Artificial Intelligence",
        university_name: "Massachusetts Institute of Technology (MIT)",
        university_country: "USA",
      },
    ],
  },
  {
    mentee_id: 3008,
    user: {
      user_id: 17,
      name: "Nguyen Thi Lan",
      email: "nguyen.lan@example.com",
      country: "Vietnam",
    },
    current_education_level: "BSc",
    intended_study_country: "Canada",
    target_degree: "MS",
    field_of_interest: "Data Science",
    target_programs: [
      {
        program_id: 5005,
        program_name: "MS in Data Science",
        university_name: "Northeastern University",
        university_country: "USA",
      },
    ],
  },
  {
    mentee_id: 3009,
    user: {
      user_id: 18,
      name: "Farhan Ahmed",
      email: "farhan.ahmed@example.com",
      country: "Pakistan",
    },
    current_education_level: "BBA",
    intended_study_country: "UK",
    target_degree: "MBA",
    field_of_interest: "International Business",
    target_programs: [
      {
        program_id: 5001,
        program_name: "MBA",
        university_name: "Harvard University",
        university_country: "USA",
      },
    ],
  },
  {
    mentee_id: 3010,
    user: {
      user_id: 19,
      name: "Aung Kyaw",
      email: "aung.kyaw@example.com",
      country: "Myanmar",
    },
    current_education_level: "BSc",
    intended_study_country: "Australia",
    target_degree: "MS",
    field_of_interest: "Computer Science",
    target_programs: [
      {
        program_id: 5004,
        program_name: "MS in Computer Science",
        university_name: "Northeastern University",
        university_country: "USA",
      },
    ],
  },
]);

// =======================================================================================================================================
// COLLECTION 3: sessions
// Embedded service, mentor, mentee, and feedback information
// =======================================================================================================================================
db.sessions.insertMany([
  {
    session_id: 7101,
    service: {
      service_id: 7002,
      description: "Resume Review",
      price_per_hour: 35.0,
      mentor_id: 2001,
    },
    mentor: {
      mentor_id: 2001,
      name: "Maya Patel",
      field_of_expertise: "Computer Science",
    },
    mentee: {
      mentee_id: 3001,
      name: "Tom Baker",
      field_of_interest: "Computer Science",
    },
    start_time: ISODate("2025-01-10T10:00:00Z"),
    duration_min: 60,
    status: "completed",
    feedback: {
      rating: 5,
      comments: "Excellent resume review! Very detailed feedback.",
    },
    payment: {
      amount: 35.0,
      status: "captured",
      method: "card",
    },
  },
  {
    session_id: 7102,
    service: {
      service_id: 7024,
      description: "SOP Guidance",
      price_per_hour: 40.0,
      mentor_id: 2008,
    },
    mentor: {
      mentor_id: 2008,
      name: "Siti Nurhaliza",
      field_of_expertise: "Data Analytics",
    },
    mentee: {
      mentee_id: 3005,
      name: "Omar Haddad",
      field_of_interest: "Management",
    },
    start_time: ISODate("2025-01-12T09:00:00Z"),
    duration_min: 60,
    status: "completed",
    feedback: {
      rating: 4,
      comments: "Good guidance on SOP structure.",
    },
    payment: {
      amount: 40.0,
      status: "captured",
      method: "card",
    },
  },
  {
    session_id: 7103,
    service: {
      service_id: 7013,
      description: "Comprehensive Application Mentorship",
      price_per_hour: 400.0,
      mentor_id: 2003,
    },
    mentor: {
      mentor_id: 2003,
      name: "Sofia Garcia",
      field_of_expertise: "Business Strategy",
    },
    mentee: {
      mentee_id: 3002,
      name: "Zara Khan",
      field_of_interest: "Data Science",
    },
    start_time: ISODate("2025-01-15T20:00:00Z"),
    duration_min: 60,
    status: "completed",
    feedback: {
      rating: 5,
      comments: "Comprehensive and professional guidance!",
    },
    payment: {
      amount: 400.0,
      status: "captured",
      method: "card",
    },
  },
  {
    session_id: 7104,
    service: {
      service_id: 7021,
      description: "Mock Interview",
      price_per_hour: 45.0,
      mentor_id: 2008,
    },
    mentor: {
      mentor_id: 2008,
      name: "Siti Nurhaliza",
      field_of_expertise: "Data Analytics",
    },
    mentee: {
      mentee_id: 3005,
      name: "Omar Haddad",
      field_of_interest: "Management",
    },
    start_time: ISODate("2025-01-18T14:00:00Z"),
    duration_min: 60,
    status: "completed",
    feedback: {
      rating: 4,
      comments: "Helpful interview practice.",
    },
    payment: {
      amount: 45.0,
      status: "captured",
      method: "card",
    },
  },
  {
    session_id: 7105,
    service: {
      service_id: 7044,
      description: "Resume Review",
      price_per_hour: 35.0,
      mentor_id: 2006,
    },
    mentor: {
      mentor_id: 2006,
      name: "Takeshi Nakamura",
      field_of_expertise: "Mechanical Engineering",
    },
    mentee: {
      mentee_id: 3006,
      name: "Eva Rossi",
      field_of_interest: "Analytics",
    },
    start_time: ISODate("2025-01-20T08:30:00Z"),
    duration_min: 60,
    status: "completed",
    feedback: {
      rating: 5,
      comments: "Great resume feedback!",
    },
    payment: {
      amount: 35.0,
      status: "captured",
      method: "card",
    },
  },
  {
    session_id: 7106,
    service: {
      service_id: 7033,
      description: "SOP Guidance",
      price_per_hour: 40.0,
      mentor_id: 2004,
    },
    mentor: {
      mentor_id: 2004,
      name: "Ken Tanaka",
      field_of_expertise: "Electrical Engineering",
    },
    mentee: {
      mentee_id: 3004,
      name: "Priya Nair",
      field_of_interest: "Engineering Management",
    },
    start_time: ISODate("2025-02-05T11:00:00Z"),
    duration_min: 60,
    status: "scheduled",
    payment: null,
  },
  {
    session_id: 7107,
    service: {
      service_id: 7014,
      description: "Mock Interview",
      price_per_hour: 45.0,
      mentor_id: 2002,
    },
    mentor: {
      mentor_id: 2002,
      name: "Ravi Sharma",
      field_of_expertise: "Data Science",
    },
    mentee: {
      mentee_id: 3002,
      name: "Zara Khan",
      field_of_interest: "Data Science",
    },
    start_time: ISODate("2025-02-06T19:00:00Z"),
    duration_min: 60,
    status: "scheduled",
    payment: null,
  },
  {
    session_id: 7108,
    service: {
      service_id: 7032,
      description: "Resume Review",
      price_per_hour: 35.0,
      mentor_id: 2004,
    },
    mentor: {
      mentor_id: 2004,
      name: "Ken Tanaka",
      field_of_expertise: "Electrical Engineering",
    },
    mentee: {
      mentee_id: 3002,
      name: "Zara Khan",
      field_of_interest: "Data Science",
    },
    start_time: ISODate("2025-01-22T16:00:00Z"),
    duration_min: 60,
    status: "cancelled",
    payment: {
      amount: 35.0,
      status: "refunded",
      method: "card",
    },
  },
  {
    session_id: 7109,
    service: {
      service_id: 7012,
      description: "SOP Guidance",
      price_per_hour: 40.0,
      mentor_id: 2002,
    },
    mentor: {
      mentor_id: 2002,
      name: "Ravi Sharma",
      field_of_expertise: "Data Science",
    },
    mentee: {
      mentee_id: 3002,
      name: "Zara Khan",
      field_of_interest: "Data Science",
    },
    start_time: ISODate("2025-02-01T18:30:00Z"),
    duration_min: 60,
    status: "completed",
    feedback: {
      rating: 5,
      comments: "Excellent SOP review session!",
    },
    payment: {
      amount: 40.0,
      status: "captured",
      method: "card",
    },
  },
  {
    session_id: 7110,
    service: {
      service_id: 7022,
      description: "Mock Interview",
      price_per_hour: 45.0,
      mentor_id: 2008,
    },
    mentor: {
      mentor_id: 2008,
      name: "Siti Nurhaliza",
      field_of_expertise: "Data Analytics",
    },
    mentee: {
      mentee_id: 3005,
      name: "Omar Haddad",
      field_of_interest: "Management",
    },
    start_time: ISODate("2025-02-03T12:00:00Z"),
    duration_min: 60,
    status: "completed",
    feedback: {
      rating: 4,
      comments: "Good interview practice session.",
    },
    payment: {
      amount: 35.0,
      status: "captured",
      method: "card",
    },
  },
]);

// =======================================================================================================================================
// COLLECTION 4: universities
// Embedded programs information
// =======================================================================================================================================
db.universities.insertMany([
  {
    university_id: 4001,
    name: "Harvard University",
    country: "USA",
    ranking: 3,
    tuition_estimate: 65500,
    programs: [
      {
        program_id: 5001,
        name: "MBA",
        degree_level: "MBA",
        tuition: 65500,
        duration_months: 24,
      },
      {
        program_id: 5002,
        name: "MS in Computer Science",
        degree_level: "MS",
        tuition: 65500,
        duration_months: 24,
      },
    ],
  },
  {
    university_id: 4002,
    name: "Northeastern University",
    country: "USA",
    ranking: 53,
    tuition_estimate: 59000,
    programs: [
      {
        program_id: 5003,
        name: "MS in Engineering Management",
        degree_level: "MS",
        tuition: 59000,
        duration_months: 18,
      },
      {
        program_id: 5004,
        name: "MS in Computer Science",
        degree_level: "MS",
        tuition: 59000,
        duration_months: 24,
      },
      {
        program_id: 5005,
        name: "MS in Data Science",
        degree_level: "MS",
        tuition: 59000,
        duration_months: 20,
      },
    ],
  },
  {
    university_id: 4003,
    name: "Massachusetts Institute of Technology (MIT)",
    country: "USA",
    ranking: 1,
    tuition_estimate: 58000,
    programs: [
      {
        program_id: 5006,
        name: "MS in Computer Science",
        degree_level: "MS",
        tuition: 58000,
        duration_months: 24,
      },
      {
        program_id: 5007,
        name: "MS in Artificial Intelligence",
        degree_level: "MS",
        tuition: 58000,
        duration_months: 24,
      },
      {
        program_id: 5008,
        name: "MS in Electrical Engineering",
        degree_level: "MS",
        tuition: 58000,
        duration_months: 24,
      },
    ],
  },
  {
    university_id: 4004,
    name: "Stanford University",
    country: "USA",
    ranking: 4,
    tuition_estimate: 62000,
    programs: [
      {
        program_id: 5009,
        name: "MS in Computer Science",
        degree_level: "MS",
        tuition: 62000,
        duration_months: 24,
      },
    ],
  },
  {
    university_id: 4005,
    name: "University of California, Berkeley",
    country: "USA",
    ranking: 20,
    tuition_estimate: 48000,
    programs: [
      {
        program_id: 5010,
        name: "MS in Data Science",
        degree_level: "MS",
        tuition: 48000,
        duration_months: 20,
      },
    ],
  },
]);

// =======================================================================================================================================
// COLLECTION 5: payments
// Embedded session and subscription payment information
// =======================================================================================================================================
db.payments.insertMany([
  {
    payment_id: 9001,
    amount: 35.0,
    method: "card",
    status: "captured",
    created_at: ISODate("2025-01-10T10:10:00Z"),
    session_payment: {
      session_id: 7101,
      mentor_name: "Maya Patel",
      mentee_name: "Tom Baker",
    },
  },
  {
    payment_id: 9002,
    amount: 40.0,
    method: "card",
    status: "captured",
    created_at: ISODate("2025-01-12T09:10:00Z"),
    session_payment: {
      session_id: 7102,
      mentor_name: "Siti Nurhaliza",
      mentee_name: "Omar Haddad",
    },
  },
  {
    payment_id: 9003,
    amount: 400.0,
    method: "card",
    status: "captured",
    created_at: ISODate("2025-01-15T20:10:00Z"),
    session_payment: {
      session_id: 7103,
      mentor_name: "Sofia Garcia",
      mentee_name: "Zara Khan",
    },
  },
  {
    payment_id: 9004,
    amount: 45.0,
    method: "card",
    status: "captured",
    created_at: ISODate("2025-01-18T14:10:00Z"),
    session_payment: {
      session_id: 7104,
      mentor_name: "Siti Nurhaliza",
      mentee_name: "Omar Haddad",
    },
  },
  {
    payment_id: 9005,
    amount: 35.0,
    method: "card",
    status: "captured",
    created_at: ISODate("2025-01-20T08:40:00Z"),
    session_payment: {
      session_id: 7105,
      mentor_name: "Takeshi Nakamura",
      mentee_name: "Eva Rossi",
    },
  },
  {
    payment_id: 9006,
    amount: 35.0,
    method: "card",
    status: "refunded",
    created_at: ISODate("2025-01-22T16:10:00Z"),
    session_payment: {
      session_id: 7108,
      mentor_name: "Ken Tanaka",
      mentee_name: "Zara Khan",
    },
  },
  {
    payment_id: 9007,
    amount: 40.0,
    method: "card",
    status: "captured",
    created_at: ISODate("2025-02-01T18:40:00Z"),
    session_payment: {
      session_id: 7109,
      mentor_name: "Ravi Sharma",
      mentee_name: "Zara Khan",
    },
  },
  {
    payment_id: 9008,
    amount: 35.0,
    method: "card",
    status: "captured",
    created_at: ISODate("2025-02-03T12:10:00Z"),
    session_payment: {
      session_id: 7110,
      mentor_name: "Siti Nurhaliza",
      mentee_name: "Omar Haddad",
    },
  },
]);

print("MongoDB collections created successfully!");
print("Collections: mentors, mentees, sessions, universities, payments");
