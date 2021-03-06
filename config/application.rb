require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"
# to use in trailblazer
require "reform"
require "reform/form/dry"

Bundler.require(*Rails.groups)

module TilfyApiV2
  class Application < Rails::Application
    config.load_defaults 5.2
    config.api_only = true

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
      g.test_framework :rspec, fixtures: false, view_specs: false, helper_specs: false, outing_specs: false
    end

    # configure middleware
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
          headers: :any,
          expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
          methods: [:get, :post, :options, :delete, :put]
      end
    end

    # add folder concepts
    config.autoload_paths += %W(#{config.root}/app/concepts)
  end
end
