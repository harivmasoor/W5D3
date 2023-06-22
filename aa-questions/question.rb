require_relative 'questions_database.rb'
require_relative 'user.rb'
require_relative 'reply.rb'

class Question
    attr_accessor :id, :title, :body, :user_id
@@database = QuestionsDatabase.instance
def self.all
    res = @@database.execute(<<-SQL)
    SELECT * FROM questions;
    SQL
    res.map {|hash| Question.new(hash)}
end

def self.find_by_id(id)
    res = @@database.execute(<<-SQL, id)
        SELECT * FROM questions
        WHERE id=?;
        SQL
        res.first && Question.new(res.first)
end

def self.find_by_author_id(user_id)
    res = @@database.execute(<<-SQL, user_id)
        SELECT * FROM questions
        WHERE user_id=?;
        SQL
        res.first && Question.new(res.first)
end

def initialize(options_hash)
    @id = options_hash['id']
    @title = options_hash['title']
    @body = options_hash['body']
    @user_id = options_hash['user_id']
end

def author
    User.find_by_id(user_id)
end

def replies
    Reply.find_by_question_id(id)
end
end




# p Question.all
# p Question.find_by_author_id(1)
# p Question.replies