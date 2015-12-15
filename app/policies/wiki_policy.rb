class WikiPolicy < ApplicationPolicy

  def show?
    if record.private?
      user.present? && record.user_id == user.id
    else
      user.present?
    end
  end

  def edit?
    show?
  end

end
