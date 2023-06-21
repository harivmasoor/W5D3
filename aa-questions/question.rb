require_relative 'questions_database.rb'

class Question
@@database = QuestionsDatabase.new
def initialize(options_hash)
    @id = options_hash[id].to_i
    @title = options_hash[:title]
    @body = options_hash[:body]
    @author_id = options_hash[:author_id]
end
def self.all
    res = @@database.execut(<<-SQL)
    SELECT * FROM questions;
    SQL
end

def self.find_byu_id(id)
    res = @@database.execute(<<-SQL)
        SELECT * FROM questions
        WHERE id = #{id};
end
end


p Questions.all