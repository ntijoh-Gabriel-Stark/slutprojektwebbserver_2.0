class Grading < DatabaseObject
    attr_reader :id, :teacher_id, :student_id, :subject_id, :grade, :comment

    table_name :grading
    column :id
    column :teacher_id
    column :student_id
    column :subject_id
    column :grade
    column :comment
    db_name 'school_network.db'

    def initialize(db_array)
        if db_array
            @id = db_array[0]
            @teacher_id = db_array[1]
            @student_id = db_array[2]
            @subject_id = db_array[3]
            @grade = db_array[4]
            @comment = db_array[5]
        end
    end
end