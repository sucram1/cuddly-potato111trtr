# == Schema Information
#
# Table name: blackmail
#
#  id         	:integer    	not null, primary key
#  title       	:string(255)	not null
#  description  :string(255)	not null
#  victim_name  :string(255)	not null
#  victim_email :string(255)	not null
#  expired_at 	:datetime
#  created_at 	:datetime		not null
#  updated_at 	:datetime		not null
#  user_id references user		not null
#

class Blackmail < ActiveRecord::Base
  # Relations  
  belongs_to :user
  has_many :demands, dependent: :delete_all
  #new katie:
  accepts_nested_attributes_for :demands, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  
  # Validations
  validates :victim_email, email: true

  # http://guides.rubyonrails.org/getting_started.html#building-a-multi-model-form
  accepts_nested_attributes_for :user,  
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
end
