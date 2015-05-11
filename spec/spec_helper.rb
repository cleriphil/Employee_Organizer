ENV['RACK_ENV'] = 'test'

require('rspec')
require('pg')
require('pry')
require('sinatra/activerecord')
require('department')
require('employee')
require('project')

RSpec.configure do |config|
  config.after(:each) do
    Employee.all().each() do |employee|
      employee.destroy()
    end
    Department.all().each() do |department|
      department.destroy()
    end
    Project.all().each() do |project|
      project.destroy()
    end
  end
end
