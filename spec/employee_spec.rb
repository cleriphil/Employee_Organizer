require('spec_helper')

describe('Employee') do
  it('tells which despartment it belongs to') do
  department = Department.create({:name => "department"})
  employee = Employee.create({:first_name => "Jen", :last_name => "Smith", :department_id => department.id})
  expect(employee.department()).to(eq(department))
  end
end
