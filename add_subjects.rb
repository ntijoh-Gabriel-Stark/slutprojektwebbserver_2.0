require 'bcrypt'
require 'sqlite3'

def add_subjects
    db = SQLite3::Database.new 'school_network.db'
    db.execute('INSERT INTO subject (subject_name) VALUES(?)', 'so')
    db.execute('INSERT INTO subject (subject_name) VALUES(?)', 'no')
    db.execute('INSERT INTO subject (subject_name) VALUES(?)', 'matte')
    db.execute('INSERT INTO subject (subject_name) VALUES(?)', 'svenska')
    db.execute('INSERT INTO subject (subject_name) VALUES(?)', 'engelska')
    db.execute('INSERT INTO subject (subject_name) VALUES(?)', 'musik')
    db.execute('INSERT INTO subject (subject_name) VALUES(?)', 'modernaspråk')
end

add_subjects()