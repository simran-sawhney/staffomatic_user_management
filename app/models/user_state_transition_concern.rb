module UserStateTransitionConcern
  include ActiveSupport::Concern

  def archived!
    update_attributes(archived: true)
  end

  def unarchived!
    update_attributes(archived: false)
  end

  def delete!
    update_attributes(deleted: true)
  end
end
