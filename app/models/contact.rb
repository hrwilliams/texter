class Contact < ActiveRecord::Base
  validates :phone_number, :presence => true
  has_and_belongs_to_many :messages
end
