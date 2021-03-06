class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable
  validates :name, :uniqueness => true, :presence => true
  validates :password, :presence => true
  has_many :tickets, :foreign_key => "manager_id"
  has_many :replies, :foreign_key => "author_id"
end
