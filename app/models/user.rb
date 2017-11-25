class User < ActiveRecord::Base

  before_save { self.email = email.downcase }
  has_secure_password
  validates :password, presence: true

  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many :records, dependent: :destroy
  has_many :notes, dependent: :destroy

  def update_amount(option, record_amount, record_type, user_id)
    cur_user = self.class.where(id: user_id).first
    case option
      when 'create', 'update'
        if record_type == 'income'
          cur_user.amount += record_amount
        else
          cur_user.amount -= record_amount
        end
      when 'delete'
        if record_type == 'income'
          cur_user.amount -= record_amount
        else
          cur_user.amount += record_amount
        end
    end
    cur_user.update_attribute(:amount, cur_user.amount)
  end

  def total_amount(user_id)
    cur_user = self.class.where(id: user_id).first
    cur_user.records.each do |record|
      if record.record_type == 'income'
        cur_user.amount += record.amount
      else
        cur_user.amount -= record.amount
      end
    end
  end

  def assess_date_count_in_days
    start_date = "2017-10-06"
    end_date = "2018-10-06"
    left_days = Date.parse(end_date) - Date.today
    left_days.to_i
  end

  def assess_date_count_in_weeks
    start_date = "2017-10-06"
    end_date = "2018-10-06"
    left_weeks = (Date.parse(end_date) - Date.today) / 7.0
    left_weeks.ceil
  end

  private

  def self.find_users
    self.class.all.order(:id)
  end

end