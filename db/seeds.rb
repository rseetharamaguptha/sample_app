User.create!(name:  "Guptha",
             email: "rsrguptha@yahoo.co.in",
             password:              "Guptha@123",
             password_confirmation: "Guptha@123",
             admin: true,
             activated: true,
             activated_at: Time.zone.now )

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now
  )
end

# Microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Relationships

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# Likes

users = User.all[1..10]
posts = Micropost.all
users.each do |user|
  posts.each do |post|
    post.likes.create(user_id: user.id)
  end
end