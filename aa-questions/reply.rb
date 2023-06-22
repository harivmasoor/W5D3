require_relative 'questions_database.rb'
require_relative 'question'
require_relative 'user.rb'

class Reply 
    attr_accessor :id, :parent_reply_id, :question_id, :user_id, :body
@@database = QuestionsDatabase.instance
def self.all
    res = @@database.execute(<<-SQL)
    SELECT * FROM replies;
    SQL
    res.map {|hash| Reply.new(hash)}
end

def self.find_by_id(id)
    res = @@database.execute(<<-SQL, id)
        SELECT * FROM replies
        WHERE id=?;
        SQL
        res.first && Reply.new(res.first)
end

def self.find_by_user_id(user_id)
    res = @@database.execute(<<-SQL, user_id)
    SELECT * FROM replies
    WHERE user_id=?;
    SQL
    res.first && Reply.new(res.first)
end

def self.find_by_question_id(question_id)
    res = @@database.execute(<<-SQL, question_id)
    SELECT * FROM replies
    WHERE question_id=?;
    SQL
    res.first && Reply.new(res.first)
end

def initialize(options_hash)
    @id = options_hash['id']
    @parent_reply_id = options_hash['parent_reply_id']
    @question_id = options_hash['question_id']
    @user_id = options_hash['user_id']
    @body = options_hash['body']
end

def author
    User.find_by_id(user_id)
end

def question
    Question.find_by_id(question_id)
end

def parent_reply
    res = @@database.execute(<<-SQL, parent_reply_id)
    SELECT * FROM replies
    WHERE id=?;
    SQL
    res.first && Reply.new(res.first)
end

def child_replies
end

end




# p Reply.all
# p Reply.find_by_question_id(2)
# p Reply.author
# test = Reply.new({'question_id' => 1, 'parent_reply_id' => 1, 'user_id' => 1, 'body'=> 'this is a test'})

# p test.question