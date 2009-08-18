class Reply
  include DataMapper::Resource

  belongs_to :ask
# TODO!!!  belongs_to :user

  property :id, Serial
  property :answer, String, :index => :full
  property :ref, String, :index => :full

  property :at, DateTime
end
