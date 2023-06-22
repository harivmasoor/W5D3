DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;
PRAGMA foreign_keys = ON;



CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);



CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);




CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);



CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  parent_reply_id INTEGER,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);



CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Elilta', 'Abrham'),
  ('Hari', 'Masoor');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('App Academy', 'What are we doing?', 1),
  ('Countries', 'Where is Eritrea', 2);

INSERT INTO
  replies ( question_id, parent_reply_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = "App Academy"),
  NULL,
  (SELECT id FROM users WHERE fname = "Elilta" AND lname = "Abrham"),
  "hey what"
);

INSERT INTO
  replies ( question_id, parent_reply_id, user_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = "App Academy"),
  (SELECT id FROM replies WHERE body = "Did you say NOW NOW NOW?"),
  (SELECT id FROM users WHERE fname = "Elilta" AND lname = "Abrham"),
  "I think he said MEOW MEOW MEOW."
);