
class Ask
  include DataMapper::Resource

  property :id, Serial
  property :question, String, :index => :full
  property :ref, String, :index => :full

  has n, :replies

end
