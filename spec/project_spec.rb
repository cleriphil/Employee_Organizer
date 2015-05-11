require('spec_helper')

describe('Project') do
  it('tells what employees have it') do
  project = Project.create({:name => "project"})
  department = Department.create({:name => "department"})
  employee = Employee.create({:first_name => "Jen", :last_name => "Smith", :department_id => department.id, :project_id => project.id})
  employee2 = Employee.create({:first_name => "John", :last_name => "Smith", :department_id => department.id, :project_id => project.id})
  expect(project.employees()).to(eq([employee, employee2]))
  end
end
