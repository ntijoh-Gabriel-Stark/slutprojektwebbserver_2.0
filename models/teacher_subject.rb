class Teacher_subject < DatabaseObject

    attr_reader :teacher_id, :subject_id

    table_name :teacher_subject
    column :teacher_id
    column :subject_id
    db_name 'school_network.db'

    def initialize(db_array)
        @teacher_id = db_array[0]
        @subject_id = db_array[1]
    end

end