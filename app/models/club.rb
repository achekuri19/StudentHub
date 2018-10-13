class Club < ApplicationRecord
  include Friendlyable

  has_many :events
  has_many :club_members
  has_many :users, through: :club_members

  belongs_to :president, class_name: "User", foreign_key: "president_id"

  validates :name,  presence: true,
                    length: {maximum: 140}
  validates :description, presence: true,
                          length: {maximum: 1500}

end