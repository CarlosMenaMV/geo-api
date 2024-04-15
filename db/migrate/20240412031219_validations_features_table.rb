class ValidationsFeaturesTable < ActiveRecord::Migration[7.1]
  def change
    change_column :features, :magnitude, :decimal, precision: 5, scale: 4
    change_column :features, :longitude, :decimal, precision: 12, scale: 8
    change_column :features, :latitude, :decimal, precision: 12, scale: 8

    add_index :features, :external_id, unique: true

    change_column_null :features, :place, false
    change_column_null :features, :mag_type, false
    change_column_null :features, :title, false
    change_column_null :features, :longitude, false
    change_column_null :features, :latitude, false
    change_column_null :features, :external_url, false
  end
end
