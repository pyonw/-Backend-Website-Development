-- Citation for the following page:
-- Date: 12/5/2022
-- Adapted from: 
-- Source URL: https://canvas.oregonstate.edu/courses/1890458/pages/exploration-database-application-design?module_item_id=22339349
--------------  User PAGE  --------------
 
-- Get all user we currently store
SELECT * FROM Users;
 
-- Adding a new user
INSERT INTO Users (full_name, language, university, gpa, location, linkedin)
VALUES (:full_nameInput, :languageInput, :universityInput, :gpaInput, :locationInput, :linkedinInput);
 
-- Update existing user
UPDATE Users SET
   full_name = :full_nameInput,
   language = :languageInput,
   university = :universityInput,
   gpa = :gpaInput,
   location = :locationInput,
   linkedin = :streetAddressInput
WHERE user_id = :user_idInput;
 
-- Delete existing user
DELETE FROM Users WHERE user_id = :user_idInput;
 
--------------  Questions PAGE  --------------
 
-- Get all questions we currently store
SELECT * FROM Questions;
 
-- Adding a new question
INSERT INTO Questions (problem, difficulty, q_link)
VALUES (:problemInput, :difficultyInput, :q_linkInput);
 
-- Update existing question
UPDATE Questions SET
   problem = :problemInput,
   difficulty = :difficultyInput,
   q_link = :q_linkInput
WHERE question_id = :question_idInput;
 
-- Delete existing question
DELETE FROM Questions WHERE question_id = :question_idInput;
 
--------------  Classes PAGE  --------------
 
-- Get all classes we currently store
SELECT * FROM Classes;
 
-- Adding a new class
INSERT INTO Classes (name)
VALUES (:nameInput);
 
-- Update existing class
UPDATE Questions SET
   name = :nameInput
WHERE class_id = :class_idInput;
 
-- Delete existing classes
DELETE FROM Classes WHERE class_id = :class_idInput;
 
--------------  Projects PAGE  --------------
 
-- Get all projects we currently store
SELECT Projects.project_id, Users.full_name, Projects.description, Projects.language, Projects.github_link 
FROM Projects JOIN Users 
ON Users.user_id = Projects.user_id;
 
-- Adding a new project
INSERT INTO Projects (user_id, description, language, github_link)
VALUES (:user_idInput, :descriptionInput, :languageInput, :github_linkInput);
 
-- Update existing project
UPDATE Projects SET
   description = :descriptionInput,
   language = :languageInput,
   github_link = :github_linkInput
WHERE project_id = :project_idInput;
 
-- Delete existing class
DELETE FROM Projects WHERE project_id = :project_idInput;
 
--------------  Internships PAGE  --------------
 
-- Get all internships we currently store
SELECT * FROM Internships;
 
-- Adding a new internship
INSERT INTO Internships (user_id, start_date, end_date, company)
VALUES (:user_idInput, :start_dateInput, :end_dateInput, :companyInput);
 
-- Update existing internship
UPDATE Internships SET
   start_date = :start_dateInput,
   end_date = :end_dateInput,
   company = :companyInput
WHERE Internships = :internship_id;
 
-- Delete existing internship
DELETE FROM Internships WHERE internship_id = :internship_id;

--------------  Users Questions PAGE  --------------
 
-- Get all User and Question pairs we currently store
SELECT full_name, problem FROM Users_Questions
JOIN Users ON Users_Questions.user_id = Users.user_id
JOIN Questions ON Users_Questions.question_id = Questions.question_id;
 
-- Adding a new User and Question pair
INSERT INTO Users_Questions ( (SELECT user_id FROM Users WHERE full_name = user_question_name),
 (SELECT question_id FROM Questions WHERE problem = question_user_name))
VALUES (:user_idInput, :question_idInput);


--------------  Users Classes PAGE  --------------
 
-- Get all User and Classes pairs we currently store
SELECT Users_Classes.user_id, full_name, Classes.class_id, Classes.name FROM Users_Classes
JOIN Users ON Users_Classes.user_id = Users.user_id
JOIN Classes ON Users_Classes.class_id = Classes.class_id;
 
-- Adding a new User and Classes pair
INSERT INTO Users_Classes ( (SELECT user_id FROM Users WHERE full_name = user_class_name),
 (SELECT class_id FROM Classes WHERE name = class_user_name))
VALUES (:user_idInput, :class_idInput);
 
