require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require('./lib/department')
require('./lib/employee')
require('pg')
also_reload('lib/**/*.rb')

get('/') do
  @departments = Department.all()
  erb(:index)
end

get('/departments/:id') do
  @department = Department.find(params.fetch('id').to_i())
  @employees = @department.employees()
  erb(:department)
end

post('/departments') do
  name = params.fetch('name')
  Department.create({:name => name})
  # @departments = Department.all()
  # erb(:index)
  redirect to('/')
end

delete('/departments/:id') do
  @department = Department.find(params.fetch('id').to_i())
  @department.delete()
  # @departments = Department.all()
  # erb(:index)
  redirect to('/')
end

get('/departments/:id/edit') do
  @department = Department.find(params.fetch('id').to_i())
  erb(:department_edit)
end

patch('/departments/:id') do
  @department = Department.find(params.fetch('id').to_i())
  name = params.fetch('name')
  @department.update({:name => name})
  # @departments = Department.all()
  redirect to('/')
end

post('/departments/:id/employees') do
  @department = Department.find(params.fetch('id').to_i())
  first_name = params.fetch('first_name')
  last_name = params.fetch('last_name')
  Employee.create({:first_name => first_name, :last_name => last_name, :department_id => @department.id})
  redirect to("/departments/#{@department.id}")
end

get('/departments/:id/employees/:employee_id/edit') do
  @department = Department.find(params.fetch('id').to_i())
  @employee = Employee.find(params.fetch('employee_id').to_i())

  erb(:employee_edit)
end

delete('/departments/:id/employees/:employee_id') do
  department_id = params.fetch("id").to_i
  @employee = Employee.find(params.fetch('employee_id').to_i())
  @employee.delete()
  redirect to("/departments/#{department_id}")
end

patch('/departments/:id/employees/:employee_id') do
  department_id = params.fetch("id").to_i
  employee_id   = params.fetch("employee_id").to_i
  first_name    = params.fetch("first_name")
  last_name     = params.fetch("last_name")

  employee = Employee.find(employee_id)
  employee.update({:first_name => first_name, :last_name => last_name})
  redirect to("/departments/#{department_id}")
end
