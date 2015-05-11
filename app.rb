require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require('./lib/department')
require('./lib/employee')
require('pg')
also_reload('lib/**/*.rb')

get('/') do
  erb(:index)
end
