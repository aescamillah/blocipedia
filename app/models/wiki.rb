class Wiki < ActiveRecord::Base
  belongs_to :user
  after_initialize :init

  def init
    self.private  ||= false
  end

end
