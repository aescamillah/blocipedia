class WikiPolicy < ApplicationPolicy

  def show?
    if record.private?
      user.present? && (record.owner_id == user.id || record.users.include?(user))
    else
      user.present?
    end
  end

  def edit?
    show?
  end

  def destroy?
    user.present? && (record.owner == user || user.admin?)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.present?
        if user.role == 'admin'
          wikis = scope.all
        else
          all_wikis = scope.all
          all_wikis.each do |wiki|
            # if wiki.private == false || wiki.user == user || wiki.users.include?(user)
            if wiki.private == false || wiki.owner_id == user.id || wiki.users.include?(user)
              wikis << wiki
            end
          end
        end
      else
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private == false
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
