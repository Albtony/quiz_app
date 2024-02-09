-- Populate the "user" table
INSERT INTO "user" ("name", "email", "password_hash")
VALUES ('John Doe', 'john@example.com', 'password123'),
       ('Jane Smith', 'jane@example.com', 'password456');

-- Populate the "quiz" table
INSERT INTO "quiz" ("title")
VALUES ('Biology Quiz'),
       ('History Quiz');

-- Populate the "role" table
INSERT INTO "role" ("name")
VALUES ('Student'),
       ('Lecturer');

-- Populate the "user_role_quiz" table
INSERT INTO "user_role_quiz" ("user_id", "role_id", "quiz_id")
VALUES (1, 1, 1),
       (1, 2, 2),
       (2, 1, 2),
       (2, 2, 1);
       

-- Populate the "tag" table
INSERT INTO "tag" ("name")
VALUES ('Biology'),
       ('History'),
       ('Easy'),
       ('Hard'),
       ('Tricky');

-- Populate the "quiz_tag" table
INSERT INTO "quiz_tag" ("quiz_id", "tag_id")
VALUES (1, 1),
       (2, 2);

-- Populate the "section" table
INSERT INTO "section" ("quiz_id", "title", "time_limit")
VALUES (1, 'True or False', 3600),
       (2, 'Multiple Choice', NULL);

-- Populate the "problem" table
INSERT INTO "problem" ("section_id", "media", "statement", "correct_option_id", "weight")
VALUES (1, NULL, 'Mitochondria is the powerhouse of the cell', NULL, 1),
       (1, NULL, 'Jellyfish have hearts', NULL, 1),
       (2, NULL, 'In which country was Adolf Hitler born?', NULL, 1);

-- Populate the "option" table
INSERT INTO "option" ("problem_id", "statement")
VALUES (1, 'True'),
       (1, 'False'),
       (2, 'True'),
       (2, 'False'),
       (3, 'France'),
       (3, 'Germany'),
       (3, 'Austria'),
       (3, 'Hungary');

-- Populate the "problem_tag" table
INSERT INTO "problem_tag" ("problem_id", "tag_id")
VALUES (1, 3),
       (2, 4),
       (2, 5),
       (3, 3);

-- Specify the correct "option" on the "problem" table
UPDATE "problem" SET "correct_option_id" = 1 WHERE "id" = 1;
UPDATE "problem" SET "correct_option_id" = 4 WHERE "id" = 2;
UPDATE "problem" SET "correct_option_id" = 7 WHERE "id" = 3;