class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :name, null: false
      t.boolean :recyclable, null: false
      t.string :alternative_outlet
      t.string :address
      t.string :phone
      t.string :url
      t.string :details

      t.timestamps
    end
    add_index :materials, :name, unique: true

    create_table :programs do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :programs, :name, unique: true

    create_table :program_materials do |t|
      t.timestamps
    end
    add_reference :program_materials, :program, index: true
    add_reference :program_materials, :material, index: true
  end
end
