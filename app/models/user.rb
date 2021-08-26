# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  bb_interest      :string
#  bio              :string
#  city             :string
#  current_employer :string
#  email            :string
#  first_name       :string
#  image            :string
#  last_name        :string
#  password_digest  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  def name
    return self.first_name + " " + self.last_name
  end
end


