class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :image
      t.string :place
      t.date :create_date
      t.text :comment

      t.timestamps
    end
  end
end
