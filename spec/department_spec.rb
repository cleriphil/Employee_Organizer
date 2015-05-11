require('spec_helper')

describe('Department') do
  it('tells what employees are in it') do
    department = Department.create({:name => "department"})
    employee1 = Employee.create({:first_name => "Jen", :last_name => "Smith", :department_id => department.id})
    employee2 = Employee.create({:first_name => "Joe", :last_name => "Smith", :department_id => department.id})
    expect(department.employees()).to(eq([employee1, employee2]))
  end
end
