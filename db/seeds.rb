# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# You can remove the 'faker' gem if you don't want Decidim seeds.
if ENV["HEROKU_APP_NAME"].present?
  ENV["DECIDIM_HOST"] = ENV["HEROKU_APP_NAME"] + ".herokuapp.com"
  ENV["SEED"] = "true"
end

# require "decidim/faker/localized"

puts "...create user..."
user = Decidim::System::Admin.new(email: "nicolas@gmail.com", password: "nounours", password_confirmation: "nounours")
user.save!

Decidim::Organization.first || Decidim::Organization.create!(
  name: "Agora en ligne",
  host: "decidimsignes.herokuapp.com",
  default_locale: Decidim.default_locale,
  available_locales: Decidim.available_locales,
  reference_prefix: "MM",
  available_authorizations: Decidim.authorization_workflows.map(&:name),
  users_registration_mode: :enabled,
  tos_version: Time.current,
  badges_enabled: true,
  user_groups_enabled: true,
  send_welcome_notification: true
)

puts "...create organization user..."
user1 = Decidim::User.new(email: "patschmi78@gmail.com", password: "Tchadtcha4", password_confirmation: "Tchadtcha4")
user1.save!

Decidim.seed!
