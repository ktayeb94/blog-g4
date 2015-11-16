class RenameBlogNameToUsernameInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :blog_name, :username
  end
end
