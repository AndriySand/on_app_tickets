# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

namespace :db do
departments = ['support', 'production', 'australia', 'canada']
statuses = ['Waiting for Staff Response', 'Waiting for Customer', 'On Hold', 'Cancelled', 'Completed']
  Rake::Task['db:reset'].invoke

  100.times do |a|
  	Ticket.create(:user_email => "australia-#{a + 1}@mail.ru", :user_name => Faker::Name.name,
  		:department => departments[rand(0...4)], :subject => Faker::Lorem.sentence,
  		:status => statuses[rand(0...5)], :body => Faker::Lorem.sentence(5))
  end
end
