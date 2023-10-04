class Message < ApplicationRecord
  belongs_to :user, optional: true
  validates :body, presence: true
  scope :custom_display, -> { order(:created_at).last(20) }
end