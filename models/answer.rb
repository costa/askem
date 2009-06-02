
class Answer
  include DataMapper::Resource

  class << self
    def create_default_for(q)
      create(:statement => 'Yes', :question => q)
      create(:statement => 'No', :question => q)
      create(:statement => 'Maybe', :question => q)
    end
  end

  property :id, Serial
  property :statement, String

  belongs_to :question


  def ratio
    0.25  # TODO work!
  end

end
