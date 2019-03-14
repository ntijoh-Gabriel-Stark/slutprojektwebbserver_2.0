class DatabaseObject

    def self.table_name(name)
        @table_name = name
    end

    def self.column(name)
        if @columns
            @columns << name
        else
            @columns = [name]
        end
    end

    def self.join(other_table)   
        @join = "JOIN #{other_table[other_table.keys[0]]} ON #{@table_name}.#{@columns[-1]} = #{other_table[other_table.keys[0]]}.id"
    end

    def self.db_name(name)
        @db = name
    end

    def self.all(&block)
        if block_given?
            if block[:join]
                self.join(block[:join])
            else
                @join = ""
            end
        end
        db = SQLite3::Database.new @db
        results = db.execute("SELECT * FROM #{@table_name} #{@join}")
        return results.map { |row| self.new(row) }
    end

    def self.get(hash, &block)
        if block_given?
            if block[:join]
                self.join(block[:join])
            else
                @join = ""
            end
        end
        db = SQLite3::Database.new @db
        result = db.execute("SELECT * FROM #{@table_name} #{@join} WHERE #{@table_name}.#{hash.keys[0]} = ?", hash[hash.keys[0]]).first        
        self.new(result)
    end

    def self.filter(hash)
        db = SQLite3::Database.new @db
        results = db.execute("SELECT * FROM #{@table_name} #{@join} WHERE #{@table_name}.#{hash.keys[0]} = ?", hash[hash.keys[0]])        
        return results.map { |row| self.new(row) }
    end

    def self.merge(hash)
        db = SQLite3::Database.new @db
        results = db.execute("SELECT #{hash[hash.keys[0]]} FROM #{hash[hash.keys[1]]} WHERE #{hash.keys[2]} = ?", hash[hash.keys[2]])
        out = []
        for result in results
            out << self.get({id: result})
        end
        return out
    end

    def self.get_columns
        out = []
        for column in @columns
            out << column.to_s
        end
        if out[0] == 'id'
            return out.drop(1).join(",")
        else
            return out.join(",")
        end
    end

    def self.q_mark
        input = self.get_columns.split(",")
        out = []
        i = 0
        while i < input.size
            out << "?"
            i += 1
        end
        return out.join(",")
    end

    def self.values(hash)
        n = hash.keys.size
        out = []
        i = 0
        while i < n
            out << hash[hash.keys[i]]
            i += 1
        end
        return out
    end

    def self.input(hash)
        db = SQLite3::Database.new @db
        db.execute("INSERT INTO #{@table_name} (#{self.get_columns}) VALUES(#{self.q_mark})", self.values(hash))
    end

    def self.change(hash)
        out = []
        i = 0
        while i < hash.keys.size - 1
            out << hash.keys[i].to_s + " = ?"
            i += 1
        end
        return out.join(",")
    end

    def self.update(hash)
        db = SQLite3::Database.new @db
        db.execute("UPDATE #{@table_name} SET #{self.change(hash)} WHERE #{hash.keys[-1]} = ?", self.values(hash))
    end
end