class Bookmark < ApplicationRecord
  self.table_name = 'wl_bookmarks'
  belongs_to :movie, foreign_key: 'wl_movie_id'
  belongs_to :list, foreign_key: 'wl_list_id'

  validates :comment, length: { minimum: 6 }
  validates :movie_id, uniqueness: { scope: :list_id }, foreign_key: 'wl_movie_id'
end
