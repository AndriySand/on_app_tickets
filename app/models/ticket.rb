class Ticket < ActiveRecord::Base
  validates :user_name, :user_email, :subject, :department, :presence => true
  after_create :ensure_reference_number
  has_paper_trail
  belongs_to :manager, :class_name => "User"
  has_many :replies
  STATUSES = ['Waiting for Staff Response', 'Waiting for Customer', 'On Hold', 'Cancelled', 'Completed']

  def ensure_reference_number
    arr = (0...3).map{[get_string_part, get_hex_number]}.flatten
  	arr.pop
    self.reference_number = arr.join('-')
    self.save
  end

  def get_string_part
  	(0...3).map{ ('A'..'Z').to_a[rand(26)] }.join
  end

  def get_hex_number
  	SecureRandom.hex(1).upcase
  end

end
