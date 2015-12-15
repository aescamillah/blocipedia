class Wiki < ActiveRecord::Base
  belongs_to :user
  after_initialize :init

  def init
    self.private  ||= false
  end

  scope :visible_to, -> (user) {
    if user.present?
      where('user_id=? OR private=?', user.id, false)
    else
      where(private: false)
    end
  }

  scope :private_only, -> (user) {
    where(private: true, user_id: user.id)
  }

end
