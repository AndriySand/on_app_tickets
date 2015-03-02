class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :user_name
      t.string :user_email
      t.string :reference_number
      t.string :subject
      t.text :body
      t.string :status, :default => 'Waiting for Staff Response'
      t.string :department
      t.integer :manager_id

      t.timestamps
    end
  end
end
