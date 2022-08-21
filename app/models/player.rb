class Player < ApplicationRecord
  has_many :players_tournaments, dependent: :delete_all

  validates :full_name, presence: true
end
