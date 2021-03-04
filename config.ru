require './config/environment'

# https://stackoverflow.com/questions/50790649/nomethoderror-undefined-method-needs-migration-for-activerecordmigratorcl
if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

use UsersController
use EventsController
run ApplicationController
