class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
      t.string :name
      t.integer :level
      t.text :description
      t.string :gender
      t.string :training_ground

      t.timestamps null: false
    end
  end
end
