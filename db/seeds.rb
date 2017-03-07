User.create!(name:  "Admin",
  email: "hung1972005@gmail.com",
  password: "538292",
  password_confirmation: "538292",
  is_admin: true)

20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end
