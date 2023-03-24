class List < ApplicationRecord
  self.table_name = 'wl_lists'
  has_many :bookmarks, foreign_key: 'wl_list_id'
  has_many :movies, through: :bookmarks, dependent: :destroy, foreign_key: 'wl_list_id'
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true
end
