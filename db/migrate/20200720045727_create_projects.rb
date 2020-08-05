class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name, required: true, unique: true
      t.json :tags
      t.integer :type
      
      t.timestamps

      t.index :type
      t.index :name
    end
  end
end
