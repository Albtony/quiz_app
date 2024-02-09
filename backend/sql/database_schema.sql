CREATE TABLE "user" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) UNIQUE NOT NULL,
  "email" VARCHAR(255) UNIQUE NOT NULL,
  "password_hash" VARCHAR(255) NOT NULL
);

CREATE TABLE "quiz" (
  "id" SERIAL PRIMARY KEY,
  "title" VARCHAR(255) NOT NULL
);

CREATE TABLE "config" (
  "id" SERIAL PRIMARY KEY,
  "quiz_id" INTEGER UNIQUE,
  "visibility" BOOLEAN NOT NULL DEFAULT FALSE,
  "max_attempts" INTEGER DEFAULT NULL,
  "max_participants" INTEGER DEFAULT NULL,
  "data_fingerprinting_enabled" BOOLEAN NOT NULL DEFAULT FALSE,
  "time_limit" INTEGER DEFAULT NULL,
  "randomize_problem" BOOLEAN NOT NULL DEFAULT FALSE,
  "randomize_options" BOOLEAN NOT NULL DEFAULT FALSE,
  "start_date" TIMESTAMP WITH TIME ZONE DEFAULT NULL,
  "end_date" TIMESTAMP WITH TIME ZONE DEFAULT NULL
);

CREATE TABLE "section" (
  "id" SERIAL PRIMARY KEY,
  "quiz_id" INTEGER,
  "title" VARCHAR(255) NOT NULL,
  "time_limit" INTEGER DEFAULT NULL
);


CREATE TABLE "problem" (
  "id" SERIAL PRIMARY KEY,
  "section_id" INTEGER,
  "media" VARCHAR(255),
  "statement" TEXT,
  "correct_option_id" INTEGER DEFAULT NULL,
  "weight" INTEGER
);

CREATE TABLE "option" (
  "id" SERIAL PRIMARY KEY,
  "problem_id" INTEGER,
  "statement" TEXT
);

CREATE TABLE "user_role_quiz" (
  "quiz_id" INTEGER,
  "user_id" INTEGER,
  "role_id" INTEGER
);

CREATE TABLE "role" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(255)
);

CREATE TABLE "quiz_attempt" (
  "id" SERIAL PRIMARY KEY,
  "user_id" INTEGER,
  "quiz_id" INTEGER,
  "score" INTEGER DEFAULT NULL
);

CREATE TABLE "section_attempt" (
  "id" SERIAL PRIMARY KEY,
  "quiz_attempt_id" INTEGER,
  "section_id" INTEGER,
  "time_taken" INTEGER DEFAULT NULL
);

CREATE TABLE "problem_attempt" (
  "id" SERIAL PRIMARY KEY,
  "section_attempt_id" INTEGER,
  "problem_id" INTEGER,
  "option_id" INTEGER,
  "time_taken" INTEGER DEFAULT NULL
);

CREATE TABLE "tag" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(255)
);

CREATE TABLE "problem_tag" (
  "problem_id" INTEGER,
  "tag_id" INTEGER
);

CREATE TABLE "quiz_tag" (
  "quiz_id" INTEGER,
  "tag_id" INTEGER
);

ALTER TABLE "user_role_quiz" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "user_role_quiz" ADD FOREIGN KEY ("role_id") REFERENCES "role" ("id");
ALTER TABLE "user_role_quiz" ADD FOREIGN KEY ("quiz_id") REFERENCES "quiz" ("id");
ALTER TABLE "section" ADD FOREIGN KEY ("quiz_id") REFERENCES "quiz" ("id");
ALTER TABLE "problem" ADD FOREIGN KEY ("section_id") REFERENCES "section" ("id");
ALTER TABLE "problem" ADD FOREIGN KEY ("correct_option_id") REFERENCES "option" ("id");
ALTER TABLE "option" ADD FOREIGN KEY ("problem_id") REFERENCES "problem" ("id");
ALTER TABLE "quiz_attempt" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "quiz_attempt" ADD FOREIGN KEY ("quiz_id") REFERENCES "quiz" ("id");
ALTER TABLE "section_attempt" ADD FOREIGN KEY ("quiz_attempt_id") REFERENCES "quiz_attempt" ("id");
ALTER TABLE "section_attempt" ADD FOREIGN KEY ("section_id") REFERENCES "section" ("id");
ALTER TABLE "problem_attempt" ADD FOREIGN KEY ("section_attempt_id") REFERENCES "section_attempt" ("id");
ALTER TABLE "problem_attempt" ADD FOREIGN KEY ("problem_id") REFERENCES "problem" ("id");
ALTER TABLE "problem_attempt" ADD FOREIGN KEY ("option_id") REFERENCES "option" ("id");
ALTER TABLE "quiz_tag" ADD FOREIGN KEY ("quiz_id") REFERENCES "quiz" ("id");
ALTER TABLE "quiz_tag" ADD FOREIGN KEY ("tag_id") REFERENCES "tag" ("id");
ALTER TABLE "problem_tag" ADD FOREIGN KEY ("problem_id") REFERENCES "problem" ("id");
ALTER TABLE "problem_tag" ADD FOREIGN KEY ("tag_id") REFERENCES "tag" ("id");
ALTER TABLE "config" ADD FOREIGN KEY ("quiz_id") REFERENCES "quiz" ("id");