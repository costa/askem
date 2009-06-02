
class Question
  include DataMapper::Resource

  MAX_ANSWERS = 121  # TODO huh?

  property :id, Serial
  property :statement, String, :key => true

  has 1..MAX_ANSWERS, :answers

  def initialize(statement, answers = nil)
    self.statement = statement

    if answers.nil? or answers.empty?
      Answer.create_default_for self
    else
      answers.each do |ans|
        Answer.create(:statement => ans, :question => self)
      end
    end
  end

end
