require "pry"

class Pokemon
    attr_accessor :name, :type, :db

    attr_reader :id

    def initialize(data)
        @id = data[:id]
        @name = data[:name]
        @type = data[:type]
        @db = data[:db]
        puts data[:id]
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon(name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id_given, db)
        puts id_given
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE pokemon.id = ?
            LIMIT 1
        SQL
        db.execute(sql, id_given).map do |data|
            passable_data = {:name => data[1], 
                            :type => data[2], 
                            :id => data[0]}
            new_pokemon = self.new(passable_data)
        end.first
    end
end
