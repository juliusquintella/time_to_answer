class AddNumeroToUserProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :user_profiles, :numero, :integer
  end
end
