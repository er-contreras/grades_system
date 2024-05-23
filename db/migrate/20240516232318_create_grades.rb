class CreateGrades < ActiveRecord::Migration[7.1]
  def change
    create_table :grades do |t|
      t.integer :grade
      t.integer :quarter
      t.references :user
      t.references :course

      t.timestamps
    end
  end
end
