# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  birthday        :datetime
#  password_digest :string
#  remember_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base

  has_one :buyer
  has_one :seller
  has_many :locations
  has_many :phones
  has_many :reviews 
  has_many :recently_viewed_listings
  has_many :conversations
  has_many :messages
  validates :first_name, presence: true, length: 2..50
  validates :last_name, presence: true, length: 2..50
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  # validates :birthday, presence: true
  # validates :password, presence: true, length: 6..15


  accepts_nested_attributes_for :locations
  accepts_nested_attributes_for :phones


  has_secure_password
  attr_accessor :remember_token

    def name
      "#{first_name} #{last_name}"
    end

    def age?
      age = ((Time.current - self.birthday)/(60*60*24*365)).to_i
      age > 18 ? true : false
    end

    def self.digest(string)
       cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
       BCrypt::Password.create(string, cost: cost)
    end

    def self.new_token
     SecureRandom.urlsafe_base64
    end

    def remember
     self.remember_token = User.new_token
     update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
     return false if remember_digest.nil?
     BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
     update_attribute(:remember_digest, nil)
    end

    def sent_messages
      Message.where(sender_id: self.id, sender_deleted: nil).sort_by(&:created_at).reverse
    end

    def received_messages
      Message.where(recipient_id: self.id, recipient_deleted: nil).sort_by(&:created_at).reverse
    end

    def total_possible_rating
     (seller.feedback_received.size + buyer.feedback_received.size) * 5
    end

    def total_rating
      seller_rating = seller.feedback_received.inject(0){|total, fdbk| total += fdbk.rating}
      buyer_rating = buyer.feedback_received.inject(0){|total, fdbk| total += fdbk.rating}
      buyer_rating + seller_rating
    end

    def average_rating
      total_possible_rating != 0 ? ((1.0 * total_rating / total_possible_rating) * 5) : 0
    end

end
