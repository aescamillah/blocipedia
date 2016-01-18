class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :collaborators
  has_many :collaborators
  belongs_to :owner, :class_name => "User", :foreign_key => :owner_id
  after_initialize :init

  def init
    self.private  ||= false
  end

  scope :visible_to, -> (user) {
    if user.present?
      where('owner_id=? OR private=?', user.id, false)
      # where('user_id=? OR private=? OR', user.id, false)
    else
      where(private: false)
    end
  }

  scope :private_only, -> (user) {
    where(private: true, owner_id: user.id)
  }

end
