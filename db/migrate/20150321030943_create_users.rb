class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :uid
      t.string :provider
      t.integer :zip
      
      t.timestamps null: false
    end
  end
end
