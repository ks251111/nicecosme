class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments
  has_many :likes

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :title
    validates :text
    validates :image
  end

  validates :category_id, numericality: { other_than: 1 }

  def self.search(search)
    if search != ""
      Article.where('title LIKE(?) OR text LIKE(?)', "%#{search}%", "%#{search}%")
    else
      Article.all
    end
  end
end