class Items < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :quantity
    end
  end
end
