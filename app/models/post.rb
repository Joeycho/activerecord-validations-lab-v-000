require 'pry'
class MyValidator < ActiveModel::Validator

  #{ in: %w(Won't Believe Secret Top[number] Guess) }
  def validate(record)
    binding.pry
    unless record.title.include? "Won't Believe" || "Secret" || "Top[number]" || "Guess"
      record.errors[:title] << 'title error'
    end
  end
end

class Post < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with MyValidator

  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
end
