require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Twitter
  class Application < Rails::Application
    config.load_defaults 7.0

    config.time_zone = 'Europe/Lisbon'

    config.generators do |g|
      g.helper         false
      g.jbuilder       false
      g.test_framework nil
    end
  end
end
