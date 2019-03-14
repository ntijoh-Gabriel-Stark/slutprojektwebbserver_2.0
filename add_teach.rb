require 'bcrypt'
require 'sqlite3'

def add_teacher
    hashed_password = BCrypt::Password.create('hejhej123')
    db = SQLite3::Database.new 'school_network.db'
    db.execute('INSERT INTO users (email, name, hashed_password, role_id)
                VALUES (?, ?, ?, ?)', ['gabriel.stark@gmail.com', 'Gabriel Stark', hashed_password, 1])
end

add_teacher()