class CreateTournament < ActiveRecord::Migration[6.1]
  def change
    create_table :tournaments do |t|
      t.float :points_qualification, null: false
      t.integer :prize_pool, null: false
      t.integer :buy_in, null: false
      t.integer :entrants, null: false, limit: 2
      t.date :final_date, null: false
      t.string :title, null: false
      t.integer :number, null: false # If id in database is not equal to id in Excel

      t.timestamps
    end
  end
end
