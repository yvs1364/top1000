class Pin < ApplicationRecord
  belongs_to :user
  has_many :visits, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_one_attached :photo
  validates :description, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :title, presence: true
  validates :address, presence: true, if: :distance?
  reverse_geocoded_by :latitude, :longitude

  def distance?
    t = distance_from([user.position_latitude, user.position_longitude])
    errors.add(:address, "WASTED ! Your too far!") if t >= 25
  end
end
