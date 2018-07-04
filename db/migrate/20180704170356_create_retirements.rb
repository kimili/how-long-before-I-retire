class CreateRetirements < ActiveRecord::Migration[5.2]
  def change
    create_table :retirements do |t|
      t.string :name
      t.boolean :display_initials
      t.date :retirement_date

      t.timestamps
    end
  end
end
