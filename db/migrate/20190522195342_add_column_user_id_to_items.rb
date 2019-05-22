class AddColumnUserIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :user_id, :integer
  end
end

#need to allow the item to belong_to the users