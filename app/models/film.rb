class Film < ApplicationRecord

  validates_presence_of :title
  validates_presence_of :seen

  belongs_to :user

  def poster_preview
    "https://image.tmdb.org/t/p/w300_and_h450_bestv2#{self.poster}"
  end

  def poster_alt_text
    "#{self.official_title} poster"
  end

end