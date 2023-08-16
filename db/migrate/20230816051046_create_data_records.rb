class CreateDataRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :data_records do |t|
      t.string :name
      t.string :data

      t.timestamps
    end
  end
end
