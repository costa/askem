
class Ask
  include DataMapper::Resource

  property :id, Serial
  property :question, String, :index => :full
  property :ref, String, :index => :full

  has n, :replies

  class Dummy

    attr_reader :question, :ref

    def initialize(q, r)
      @question = q
      @ref = r
    end

  end

  # The idea is to not store unanswered questions, go figure
  def Ask.find_or_dummy(quest, ref)
    Ask.first(:question => quest,
              :ref => ref) ||
      Dummy.new(quest, ref)
  end
end
