require 'faker'

# Create a user
user_1 = User.new(
  name:     'Alejandro',
  email:    'escamilla.a@gmail.com',
  password: 'helloworld',
)
user_1.skip_confirmation!
user_1.save!

user_2 = User.new(
  name:     'User 2',
  email:    'user_2@example.com',
  password: 'helloworld',
)
user_2.skip_confirmation!
user_2.save!

user_3 = User.new(
  name:     'User 3',
  email:    'user_3@example.com',
  password: 'helloworld',
)
user_3.skip_confirmation!
user_3.save!

users = User.all

100.times do
  wiki = Wiki.create!(
    owner:   users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph,
  )
end

wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} items created"
