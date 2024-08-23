class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :short_code
      t.string :title
      t.string :url
      t.integer :access_count

      t.timestamps
    end
  end
end
