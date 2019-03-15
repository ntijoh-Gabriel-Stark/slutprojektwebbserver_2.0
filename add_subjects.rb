require 'bcrypt'
require 'sqlite3'
require_relative 'models/database_object'
require_relative 'models/subject'

def add_subjects
    db = SQLite3::Database.new 'school_network.db'
    Subject.input({subject: 'so'})
    Subject.input({subject: 'no'})
    Subject.input({subject: 'matte'})
    Subject.input({subject: 'svenska'})
    Subject.input({subject: 'engelska'})
    Subject.input({subject: 'musik'})
    Subject.input({subject: 'modernaspråk'})
end

add_subjects()