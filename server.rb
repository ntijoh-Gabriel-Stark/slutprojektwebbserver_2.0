require 'sinatra'
require 'sqlite3'
require 'slim'

get '/employees' do
	db = SQLite3::Database.new 'contacts.db'
	result = db.execute('SELECT * FROM users')
	slim(:employees, locals: {name: 'Evil Corp', employees: result})
end
  
