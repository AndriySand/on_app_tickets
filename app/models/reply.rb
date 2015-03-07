class Reply < ActiveRecord::Base
  validates :author_id, :body, :ticket_id, :presence => true
  belongs_to :author, :class_name => "User"
  belongs_to :ticket
end
