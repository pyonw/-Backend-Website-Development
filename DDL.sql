-- Citation for the following page:
-- Date: 12/5/2022
-- Adapted from: 
-- Source URL: https://canvas.oregonstate.edu/courses/1890458/pages/activity-1-creating-a-customer-object-table?module_item_id=22339320

-- COMMENTS: 
-- DDL file below creates the Users, Questions, Users_Questions, Classes, Users_Classes, Projects, and Internships Entities
-- Sample data is also inserted for each entity below with insertion queries

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

CREATE OR REPLACE TABLE Users (
 user_id int(11) not NULL UNIQUE AUTO_INCREMENT,
 full_name varchar(100) not NULL,
 language varchar(100) not NULL,
 university varchar(100) not NULL,
 gpa decimal(19,2),
 location varchar(100) not NULL,
 linkedin varchar(100) not NULL,
 PRIMARY KEY (user_id)
);

CREATE OR REPLACE TABLE Questions (
 question_id int(11) NOT NULL UNIQUE AUTO_INCREMENT,
 problem varchar(100) not NULL,
 difficulty varchar(50) not NULL,
 q_link varchar(100) not NULL,
 PRIMARY KEY (question_id)
);

CREATE OR REPLACE TABLE Users_Questions (
 users_questions_id int(11) NOT NULL UNIQUE AUTO_INCREMENT,
 user_id int(11) NOT NULL,
 question_id int(11) NOT NULL,
 FOREIGN KEY(user_id) REFERENCES Users(user_id)
 ON DELETE CASCADE 
 ON UPDATE CASCADE,
 FOREIGN KEY(question_id) REFERENCES Questions(question_id)
 ON DELETE CASCADE 
 ON UPDATE CASCADE
);

CREATE OR REPLACE TABLE Classes (
class_id int(11) NOT NULL UNIQUE AUTO_INCREMENT,
name varchar(100) not NULL,
PRIMARY KEY (class_id)
);

CREATE OR REPLACE TABLE Users_Classes (
 users_classes_id int(11) NOT NULL UNIQUE AUTO_INCREMENT,
 user_id int(11) NOT NULL,
 class_id int(11) NOT NULL,
 FOREIGN KEY(user_id) REFERENCES Users(user_id) 
 ON DELETE CASCADE 
 ON UPDATE CASCADE,
 FOREIGN KEY(class_id) REFERENCES Classes(class_id)
 ON DELETE CASCADE 
 ON UPDATE CASCADE
);

CREATE OR REPLACE TABLE Projects (
 project_id int(11) NOT NULL UNIQUE AUTO_INCREMENT,
 user_id int(11),
 description LONGTEXT not NULL,
 language varchar(50) not NULL,
 github_link varchar(100) not NULL,
 PRIMARY KEY (project_id),
 FOREIGN KEY(user_id) REFERENCES Users(user_id) 
 ON DELETE CASCADE
);

CREATE OR REPLACE TABLE Internships (
 internship_id int(11) NOT NULL UNIQUE AUTO_INCREMENT,
 user_id int(11) NOT NULL,
 start_date DATE not NULL,
 end_date DATE not NULL,
 company varchar(200) not NULL,
 PRIMARY KEY (internship_id),
 FOREIGN KEY(user_id) REFERENCES Users(user_id) 
 ON DELETE CASCADE
);

INSERT INTO Users (full_name, language, university, gpa, location, linkedin)
VALUES ('John Doe', 'Python, Javascript', 'Harvard', 4.0, 'Irvine, CA', 'www.linkedin.com/in/john-doe'),
('Sammy Smith', 'C++', 'MIT', 3.9, 'Cambridge, MA', 'www.linkedin.com/in/sammy-smith'),
('Stacee Lopez', 'C, Javascript, CSS, HTML', 'Oregon State', 3.5, 'Seattle, WA', 'www.linkedin.com/in/stacee-lopez');

INSERT INTO Questions (problem, difficulty, q_link)
VALUES ('Two Sum', 'Easy', 'https://leetcode.com/problems/two-sum/'),
('Trapping Rain Water', 'Hard', 'https://leetcode.com/problems/trapping-rain-water/'),
('Snakes and Ladders', 'Medium', 'https://leetcode.com/problems/snakes-and-ladders/');

INSERT INTO Users_Questions (user_id, question_id)
VALUES ((SELECT user_id FROM Users WHERE full_name = 'John Doe'), (SELECT question_id FROM Questions WHERE problem = 'Two Sum')),
((SELECT user_id FROM Users WHERE full_name = 'Sammy Smith'), (SELECT question_id FROM Questions WHERE problem = 'Trapping Rain Water')),
((SELECT user_id FROM Users WHERE full_name = 'Stacee Lopez'), (SELECT question_id FROM Questions WHERE problem = 'Trapping Rain Water')),
((SELECT user_id FROM Users WHERE full_name = 'Stacee Lopez'), (SELECT question_id FROM Questions WHERE problem = 'Snakes and Ladders'));

INSERT INTO Classes (name)
VALUES ('Data Structures'),
('Web Development'),
('Algorithms');

INSERT INTO Users_Classes (user_id, class_id)
VALUES ((SELECT user_id FROM Users WHERE full_name = 'John Doe'), (SELECT class_id FROM Classes WHERE name = 'Data Structures')),
((SELECT user_id FROM Users WHERE full_name = 'Sammy Smith'), (SELECT class_id FROM Classes WHERE name = 'Data Structures')),
((SELECT user_id FROM Users WHERE full_name = 'Stacee Lopez'), (SELECT class_id FROM Classes WHERE name = 'Web Development')),
((SELECT user_id FROM Users WHERE full_name = 'Sammy Smith'), (SELECT class_id FROM Classes WHERE name = 'Algorithms'));

INSERT INTO Projects (user_id, description, language, github_link)
VALUES ((SELECT user_id FROM Users WHERE full_name = 'John Doe'), 'Created a battleship game', 'Python', 'https://github.com/doej/battleship'),
((SELECT user_id FROM Users WHERE full_name = 'Sammy Smith'), 'Created a tetris game', 'C++', 'https://github.com/smiths/sammy_tetris'),
((SELECT user_id FROM Users WHERE full_name = 'Stacee Lopez'), 'Developed a full stack website', 'Javascript, CSS, HTML', 'https://github.com/lopezs/website');

INSERT INTO Internships (user_id, start_date, end_date, company)
VALUES ((SELECT user_id FROM Users WHERE full_name = 'John Doe'), '2016-05-25', '2016-09-10', 'Red Fruit'),
((SELECT user_id FROM Users WHERE full_name = 'Sammy Smith'), '2012-10-15', '2012-02-10', 'Rainforest'),
((SELECT user_id FROM Users WHERE full_name = 'Stacee Lopez'), '2015-05-11', '2015-09-11', 'Checks');

SET FOREIGN_KEY_CHECKS=1;
COMMIT;

SELECT * FROM Users;
SELECT * FROM Questions;
SELECT * FROM Users_Questions;
SELECT * FROM Classes;
SELECT * FROM Users_Classes;
SELECT * FROM Projects;
SELECT * FROM Internships;