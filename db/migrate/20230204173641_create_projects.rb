class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :type
      t.string :location
      t.string :thumbnail

      t.timestamps
    end
  end
end
