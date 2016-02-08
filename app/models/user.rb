class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, through: :collaborators
  has_many :collaborators
  has_many :owned_wikis, :class_name => "Wiki", :foreign_key => :owner_id
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

  def standard?
    role == 'standard'
  end

  def upgrade
    self.role = 'premium'
  end

  scope :not_owner, -> (wiki) {
    where.not(id: wiki.owner_id)
  }

  scope :not_collaborators_or_owner, -> (wiki) {
    array = wiki.users.map(&:id)
    array << wiki.owner_id
    where("id not in (?)", array)
  }

end
