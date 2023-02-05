class User < ApplicationRecord
  has_many :projects
  has_many :contents, through: :projects
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true
  validates :password_confirmation, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
  end
