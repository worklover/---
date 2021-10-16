CREATE TABLE teachers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  surname TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE
);

CREATE TABLE courses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE streams (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  course_id INTEGER NOT NULL,
  number INTEGER NOT NULL UNIQUE,
  start_date TEXT NOT NULL,
  students_amount INTEGER NOT NULL,
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE grades (
  teacher_id INTEGER NOT NULL,
  stream_id INTEGER PRIMARY KEY AUTOINCREMENT,
  performance REAL NOT NULL,
  FOREIGN KEY (teacher_id) REFERENCES teachers(id),
  FOREIGN KEY (stream_id) REFERENCES streams(id)
);

ALTER TABLE streams RENAME COLUMN start_date TO started_at;
ALTER TABLE streams ADD COLUMN finished_at TEXT ;
INSERT INTO teachers (name, surname, email) VALUES ('Николай', 'Савельев', 'saveliev.n@mai.ru' ), 
('Наталья', 'Петрова', 'petrova.n@yandex.ru' ),
('Елена', 'Малышева', 'malisheva.e@google.com' );

INSERT INTO courses (name) VALUES ('Базы данных'), ('Основы Python'), ('Linux. Рабочая станция'); 
INSERT INTO streams (course_id, number, started_at, students_amount  ) 
VALUES (3,165,'18.08.2020',34),
(2,178,'02.10.2020',37),
(1,203,'12.11.2020',35),
(1,210,'03.12.2020',41);

INSERT INTO grades (teacher_id, stream_id, performance ) 
VALUES (3,1,4.7),(2,2,4.9),(1,3,4.8),(1,4,4.9);

ALTER TABLE grades RENAME TO grades_old ; 
CREATE TABLE grades (
  teacher_id INTEGER NOT NULL,
  stream_id REAL NOT NULL,
  performance REAL NOT NULL,
  FOREIGN KEY (teacher_id) REFERENCES teachers(id),
  FOREIGN KEY (stream_id) REFERENCES streams(id)
);

INSERT INTO grades (teacher_id,stream_id,performance) SELECT teacher_id,stream_id,performance FROM grades_old ;
DROP TABLE grades_old ; 


ALTER TABLE teachers RENAME TO teachers_old ; 

CREATE TABLE teachers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  surname TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE
);

INSERT INTO teachers (name,surname,email) SELECT name,surname,email FROM teachers_old ;

DROP TABLE teachers_old;

ALTER TABLE grades ADD COLUMN id INTEGER PRIMARY KEY AUTOINCREMENT;

