class CreateFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
      t.string :title
      t.date :seen
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
