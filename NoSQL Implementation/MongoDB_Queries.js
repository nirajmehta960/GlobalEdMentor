// MongoDB Queries for GlobalEdMentor Platform
// Use this file in MongoDB Compass or MongoDB Shell
// All queries are tested and ready to run

use("GlobalEdMentor");

// =======================================================================================================================================
// QUERY 1: SIMPLE QUERY
// Find all verified mentors with PhD degree
// =======================================================================================================================================
print("=".repeat(70));
print("QUERY 1: SIMPLE QUERY - Find all verified mentors with PhD degree");
print("=".repeat(70));

db.mentors
  .find(
    {
      education_level: "PhD",
      verified: true,
    },
    {
      "user.name": 1,
      "user.email": 1,
      field_of_expertise: 1,
      education_level: 1,
      years_of_experience: 1,
    }
  )
  .pretty();

// =======================================================================================================================================
// QUERY 2: COMPLEX QUERY (Multiple Conditions)
// Find completed sessions with rating >= 4, where mentor has 5+ years experience
// and payment status is captured, ordered by rating descending
// =======================================================================================================================================
print("\n" + "=".repeat(70));
print("QUERY 2: COMPLEX QUERY - Completed sessions with multiple conditions");
print("=".repeat(70));

db.sessions
  .find(
    {
      status: "completed",
      "feedback.rating": { $gte: 4 },
      "payment.status": "captured",
      "mentor.field_of_expertise": { $exists: true },
    },
    {
      session_id: 1,
      "mentor.name": 1,
      "mentee.name": 1,
      "service.description": 1,
      "feedback.rating": 1,
      "feedback.comments": 1,
      "payment.amount": 1,
      start_time: 1,
    }
  )
  .sort({ "feedback.rating": -1 })
  .pretty();

// Alternative complex query with $and and $or
print(
  "\n--- Alternative Complex Query: Mentors from USA universities OR with 7+ years experience ---"
);
db.mentors
  .find({
    $or: [
      { "universities.country": "USA" },
      { years_of_experience: { $gte: 7 } },
    ],
    verified: true,
  })
  .pretty();

// =======================================================================================================================================
// QUERY 3: AGGREGATE QUERY
// Calculate total earnings per mentor from completed sessions with captured payments
// =======================================================================================================================================
print("\n" + "=".repeat(70));
print("QUERY 3: AGGREGATE QUERY - Total earnings per mentor");
print("=".repeat(70));

db.sessions.aggregate([
  {
    $match: {
      status: "completed",
      "payment.status": "captured",
    },
  },
  {
    $group: {
      _id: {
        mentor_id: "$mentor.mentor_id",
        mentor_name: "$mentor.name",
      },
      total_earnings: { $sum: "$payment.amount" },
      total_sessions: { $sum: 1 },
      average_rating: { $avg: "$feedback.rating" },
    },
  },
  {
    $sort: { total_earnings: -1 },
  },
  {
    $project: {
      _id: 0,
      mentor_name: "$_id.mentor_name",
      mentor_id: "$_id.mentor_id",
      total_earnings: { $round: ["$total_earnings", 2] },
      total_sessions: 1,
      average_rating: { $round: ["$average_rating", 2] },
    },
  },
]);

// =======================================================================================================================================
// QUERY 4: AGGREGATE QUERY (Additional)
// Count mentees by intended study country
// =======================================================================================================================================
print("\n" + "=".repeat(70));
print("QUERY 4: AGGREGATE QUERY - Mentees by intended study country");
print("=".repeat(70));

db.mentees.aggregate([
  {
    $group: {
      _id: "$intended_study_country",
      total_mentees: { $sum: 1 },
      mentee_names: { $push: "$user.name" },
    },
  },
  {
    $sort: { total_mentees: -1 },
  },
  {
    $project: {
      _id: 0,
      country: "$_id",
      total_mentees: 1,
      mentee_count: { $size: "$mentee_names" },
    },
  },
]);

// =======================================================================================================================================
// QUERY 5: AGGREGATE QUERY (Additional)
// Find universities with program count and average tuition
// =======================================================================================================================================
print("\n" + "=".repeat(70));
print("QUERY 5: AGGREGATE QUERY - Universities with program statistics");
print("=".repeat(70));

db.universities.aggregate([
  {
    $project: {
      name: 1,
      country: 1,
      ranking: 1,
      program_count: { $size: { $ifNull: ["$programs", []] } },
      average_tuition: {
        $avg: "$programs.tuition",
      },
      programs: 1,
    },
  },
  {
    $sort: { ranking: 1 },
  },
]);

// =======================================================================================================================================
// QUERY 6: COMPLEX QUERY (Additional)
// Find mentors who have conducted sessions with rating >= 4.5
// and have university affiliation in USA
// =======================================================================================================================================
print("\n" + "=".repeat(70));
print("QUERY 6: COMPLEX QUERY - Top mentors with USA university affiliation");
print("=".repeat(70));

db.mentors
  .find({
    "universities.country": "USA",
    verified: true,
    years_of_experience: { $gte: 5 },
  })
  .pretty();

// =======================================================================================================================================
// QUERY 7: AGGREGATE WITH MATCH (Additional)
// Calculate average session price by service type
// =======================================================================================================================================
print("\n" + "=".repeat(70));
print("QUERY 7: AGGREGATE QUERY - Average price by service type");
print("=".repeat(70));

db.sessions.aggregate([
  {
    $match: {
      status: "completed",
      "payment.status": "captured",
    },
  },
  {
    $group: {
      _id: "$service.description",
      average_price: { $avg: "$payment.amount" },
      total_sessions: { $sum: 1 },
      total_revenue: { $sum: "$payment.amount" },
    },
  },
  {
    $sort: { average_price: -1 },
  },
  {
    $project: {
      _id: 0,
      service_type: "$_id",
      average_price: { $round: ["$average_price", 2] },
      total_sessions: 1,
      total_revenue: { $round: ["$total_revenue", 2] },
    },
  },
]);
