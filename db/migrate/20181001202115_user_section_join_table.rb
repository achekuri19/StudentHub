class UserSectionJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :sections do |t|
    end
  end
end
