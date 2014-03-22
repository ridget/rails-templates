gem_group :assets do
  gem 'bootstrap-sass'
end

gem_group :development, :test do
  gem 'shoulda-matchers', '~> 2.4.0'
end

inside app_name do
  run 'bundle install'
end
