class Tournament < ApplicationRecord
  has_many :players_tournaments, dependent: :delete_all
  has_many :players, through: :players_tournaments

  validates :points_qualification, :prize_pool, :buy_in, :entrants, :final_date, :title, :number, presence: true
end
