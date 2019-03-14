class Role < DatabaseObject

    attr_reader :id, :name

    table_name :role_name
    column :id
    column :name
    db_name 'school_network.db'

    def initialize(db_array)
        @id = db_array[0]
        @name = db_array[1]
    end

end