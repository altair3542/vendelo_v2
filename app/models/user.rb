class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: :invalid }
  validates :username, presence: true, uniqueness: true, length: { in: 3..15}, format: { with: /\A[a-zA-Z0-9]+\z/, message: :invalid }
  validates :password, presence: true, length: { minimum: 6 }

  before_save :downcase_attributes

  private

  def downcase_attributes
    self.email = email.downcase
    self.username = username.downcase
  end


end
