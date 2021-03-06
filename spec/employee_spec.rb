require('spec_helper')

describe('Employee') do
  it('tells which department it belongs to') do
    department = Department.create({:name => "department"})
    employee = Employee.create({:first_name => "Jen", :last_name => "Smith", :department_id => department.id})
    expect(employee.department()).to(eq(department))
  end
  it('tells which project it belongs to') do
    project = Project.create({:name => "project"})
    department = Department.create({:name => "department"})
    employee = Employee.create({:first_name => "Jen", :last_name => "Smith", :department_id => department.id, :project_id => project.id()})
    expect(employee.project()).to(eq(project))
  end
end
