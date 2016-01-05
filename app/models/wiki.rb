class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :collaborators
  has_many :collaborators
  after_initialize :init

  def init
    self.private  ||= false
  end

  scope :visible_to, -> (user) {
    if user.present?
      where('user_id=? OR private=?', user.id, false)
      # where('user_id=? OR private=? OR', user.id, false)
    else
      where(private: false)
    end
  }

  scope :private_only, -> (user) {
    where(private: true, user_id: user.id)
  }

end
