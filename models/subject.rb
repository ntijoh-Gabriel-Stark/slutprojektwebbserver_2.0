class Subject < DatabaseObject
    attr_reader :id, :subject_name

    table_name :subject
    column :id
    column :subject_name
    db_name 'school_network.db'

    def initialize(db_array)
        if db_array
            @id = db_array[0]
            @subject_name = db_array[1]
        end
    end
end