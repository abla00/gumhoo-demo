# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "abla",
             email: "abla00@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

5.times do |n|
  name     = Faker::Name.name
  email    = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
  puts "User ##{n+1} created."
end
puts "Creating Users completed."

user = User.first
14.times do |n|
  title   = Faker::Book.title
  content = Faker::Lorem.sentence(5)
  price   = Faker::Commerce.price
  link    = Faker::Internet.url('24h.pchome.com.tw')
  random  = rand(1..3)
  picture = Faker::Avatar.image(title.parameterize, "300x300", "jpg", "set#{random}", "bg#{random}")
  
  user.posts.create!(
    title:   title, 
    content: content, 
    price:   price, 
    link:    link,
    picture: picture
  )
  puts "Post ##{n+1} created."
end
puts "Creating Posts completed."

# Following relationships
users     = User.all
user      = users.first
following = users[2..4]
followers = users[3..5]
following.each { |followed| user.follow(followed) }
puts "Following relationships completed."
followers.each { |follower| follower.follow(user) }
puts "Followed relationships completed."
