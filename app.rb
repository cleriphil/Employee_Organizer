require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require('./lib/department')
require('./lib/employee')
require('./lib/project')
require('pg')
require('pry')
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

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

post('/projects') do
  name = params.fetch('name')
  Project.create({:name => name})
  redirect to('/projects')
end

get('/projects/:id') do
  @project = Project.find(params.fetch('id').to_i)
  @all_employees = Employee.all.sort
  erb(:project)
end

patch('/projects/:id/employees') do
  project_id    = params.fetch('id').to_i
  employee_ids  = params.fetch('employees')
  project       = Project.find(project_id)

  Employee.all.each do |employee|
    if employee_ids.include?(employee.id.to_s)
      employee.update({:project_id => project.id.to_i})
    else
      employee.update({:project_id => NIL}) #to get deselecting to work
    end
  end
  redirect back
end
