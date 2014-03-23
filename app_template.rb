gem 'devise'
gem 'cancan'
gem 'haml-rails'
gem 'mysql2'
gem 'capistrano', '~> 2.0'


gem_group :assets do
  gem 'bootstrap-sass'
end

gem_group :development, :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', '~> 2.4.0'
  gem 'rspec-rails'
  gem 'timecop'
  gem 'zeus', '~> 0.13.4.pre', :require => false
end

inside app_name do
  run 'bundle install'
end
