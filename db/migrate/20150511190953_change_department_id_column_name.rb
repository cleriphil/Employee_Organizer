class ChangeDepartmentIdColumnName < ActiveRecord::Migration
  def change
    rename_column :employees, :dept_id, :department_id
  end
end
