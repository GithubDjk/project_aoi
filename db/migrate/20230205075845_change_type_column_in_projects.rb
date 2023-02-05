class ChangeTypeColumnInProjects < ActiveRecord::Migration[7.0]
  def change
    change_column :projects, :type, :integer, using: 'type::integer'
  end
end

