class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy
  after_initialize :init

  def init
    self.role  ||= 'standard'
  end

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

end
