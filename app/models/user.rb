class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable
  validates :name, :uniqueness => true, :presence => true
  validates :password, :presence => true
end
