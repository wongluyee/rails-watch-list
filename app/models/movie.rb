class Movie < ApplicationRecord
  self.table_name = 'wl_movies'
  has_many :bookmarks, foreign_key: 'wl_movie_id'

  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
end
