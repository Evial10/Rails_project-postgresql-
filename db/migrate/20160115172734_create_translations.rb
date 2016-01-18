class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :language
      t.text :text
      t.text :translated_text
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
