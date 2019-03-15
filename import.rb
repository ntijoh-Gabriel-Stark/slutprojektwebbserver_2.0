require 'sqlite3'
require 'pp'
require 'bcrypt'

db = SQLite3::Database.new 'school_network.db'

# Table for users
db.execute('DROP TABLE IF EXISTS users')
db.execute('CREATE TABLE users
                   (id INTEGER PRIMARY KEY AUTOINCREMENT,
                    email VARCHAR(255) NOT NULL UNIQUE,
                    name VARCHAR(255) NOT NULL,
                    hashed_password VARCHAR(60) NOT NULL,
                    role_id INTEGER NOT NULL)')
hashed_password = BCrypt::Password.create('hejhej123')
db = SQLite3::Database.new 'school_network.db'
db.execute('INSERT INTO users (email, name, hashed_password, role_id)
            VALUES (?, ?, ?, ?)', ['gabriel.stark@gmail.com', 'Gabriel Stark', hashed_password, 1])

# Table for students
db.execute('DROP TABLE IF EXISTS role_name')
db.execute('CREATE TABLE role_name
                   (id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name VARCHAR(255) NOT NULL UNIQUE)')

# Table for the groups
db.execute('DROP TABLE IF EXISTS groups')
db.execute('CREATE TABLE groups
                    (id INTEGER PRIMARY KEY AUTOINCREMENT,
                    group_name NOT NULL UNIQUE)')

# Table for the subjects
db.execute('DROP TABLE IF EXISTS subject')
db.execute('CREATE TABLE subject
                    (id INTEGER PRIMARY KEY AUTOINCREMENT,
                    subject_name VARCHAR(255) NOT NULL)')

# Table for setting the grade on the student grading
db.execute('DROP TABLE IF EXISTS grading')
db.execute('CREATE TABLE grading
                    (id INTEGER PRIMARY KEY AUTOINCREMENT,
                    teacher_id INTEGER NOT NULL,
                    student_id INTEGER NOT NULL,
                    subject_id INTEGER NOT NULL,
                    grade VARCHAR(1) NOT NULL,
                    comment VARCHAR(255))')

# Table for merging user and the group
db.execute('DROP TABLE IF EXISTS user_group')
db.execute('CREATE TABLE user_group
                    (user_id INTEGER NOT NULL,
                    group_id INTEGER NOT NULL)')

# Table for merging subject and the group
db.execute('DROP TABLE IF EXISTS group_subject')
db.execute('CREATE TABLE group_subject
                   (subject_id INTEGER NOT NULL,
                    group_id INTEGER NOT NULL)')

# Table for merging teacher and the subject
db.execute('DROP TABLE IF EXISTS teacher_subject')
db.execute('CREATE TABLE teacher_subject
                   (teacher_id INTEGER NOT NULL,
                    subject_id INTEGER NOT NULL)')

# Adding the teacher and student roles
db.execute('INSERT INTO role_name (name)
            VALUES(?)', 'teacher')
db.execute('INSERT INTO role_name (name)
            VALUES(?)', 'student')