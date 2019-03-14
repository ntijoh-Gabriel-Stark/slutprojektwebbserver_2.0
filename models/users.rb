class Users < DatabaseObject

    attr_reader :id, :email, :name, :role, :role_id

    table_name :users
    column :id
    column :email
    column :name
    column :hashed_password
    column :role_id
    db_name 'school_network.db'

    def initialize(db_array)
        @id = db_array[0]
        @email = db_array[1]
        @name = db_array[2]
        @role_id = db_array[4]
        @role = db_array[-1]
    end

    def self.login(params, app, &block)
        db = SQLite3::Database.new 'school_network.db'
        user = db.execute("SELECT id, hashed_password FROM users WHERE name = ?", params['name']).first
        hashed_password = BCrypt::Password.new(user[1])
        user = self.get({id: user[0]}) {block[:join]}

		if hashed_password == params['pwd']
			app.session[:user_id] = user.id
            app.session[:type] = user.role
        end
    end
end