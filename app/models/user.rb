class User < ActiveRecord::Base

  before_save { self.email = email.downcase }
  has_secure_password
  validates :password, presence: true

  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many :records, dependent: :destroy

  private

  def self.find_users
    self.class.all.order(:id)
  end

end
