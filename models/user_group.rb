class User_group < DatabaseObject

    attr_reader :user_id, :group_id

    table_name :user_group
    column :user_id
    column :group_id
    db_name 'school_network.db'

    def initialize(db_array)
        @user_id = db_array[0]
        @group_id = db_array[1]
    end

end