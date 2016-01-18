class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  scope :belonging_to, -> (wiki) {
    where(wiki_id: wiki.id)
  }


end
