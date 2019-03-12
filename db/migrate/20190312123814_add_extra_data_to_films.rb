class AddExtraDataToFilms < ActiveRecord::Migration[5.2]
  def change
    add_column :films, :official_title, :string
    add_column :films, :official_overview, :text
    add_column :films, :poster, :string
  end
end
