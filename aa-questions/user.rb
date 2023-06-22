require_relative 'questions_database.rb'
require_relative 'question.rb'
require_relative 'reply.rb'

class User
    attr_accessor :id, :fname, :lname
@@database = QuestionsDatabase.instance

def self.all
    res = @@database.execute(<<-SQL)
    SELECT * FROM users;
    SQL
    res.map {|hash| User.new(hash)}
end

def self.find_by_name(fname, lname)
    res = @@database.execute(<<-SQL, fname, lname)
    SElECT * FROM users
    WHERE fname = ? AND lname = ?;
    SQL
    res.first && User.new(res.first)
end 

def self.find_by_id(id)
    res = @@database.execute(<<-SQL, id)
        SELECT * FROM users
        WHERE id=?;
        SQL
        res.first && User.new(res.first)
end


def initialize(options_hash)
    @id = options_hash['id']
    @fname = options_hash['fname']
    @lname = options_hash['lname']
end

def authored_questions(user_id)
    res = @@database.execute(<<-SQL, fname, lname)
    SElECT * FROM users
    WHERE fname = ? AND lname = ?;
    SQL
    res.first && User.new(res.first)
end

def authored_questions
    Question.find_by_author_id(id)
end

def authored_replies
    Reply.find_by_user_id(id)
end

end





#  p user = User.find_by_name('Hari', 'Masoor')
#  p user.authored_questions