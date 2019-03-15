class Groups < DatabaseObject

    attr_reader :id, :group_name

    table_name :groups
    column :id
    column :group_name
    db_name 'school_network.db'

    def initialize(db_array)
        if db_array
            @id = db_array[0]
            @group_name = db_array[1]
        end
    end

end