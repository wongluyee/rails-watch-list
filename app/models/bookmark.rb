class Bookmark < ApplicationRecord
  self.table_name = 'wl_bookmarks'
  belongs_to :movie, foreign_key: 'wl_movie_id'
  belongs_to :list, foreign_key: 'wl_list_id'

  validates :comment, length: { minimum: 6 }
  validates :wl_movie_id, uniqueness: { scope: :wl_list_id }
end
