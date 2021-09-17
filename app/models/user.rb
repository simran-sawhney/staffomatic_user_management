class User < ApplicationRecord
  has_paper_trail
  has_secure_password
  include UserStateTransitionConcern

  validates :email,
            presence: true,
            uniqueness: true

  scope :archived, -> { where(archived: true) }
  scope :unarchived, -> { where(archived: false) }
  scope :deleted, -> { where(deleted: true) }
  scope :non_deleted, -> { where(deleted: false) }

  after_commit :notify_user

  def changes
    versions.reverse.collect { |x| { updated_by: x.whodunnit || "System", changes: x.changeset } }
  end

  private

  def notify_user
    return unless saved_change_to_archived? || saved_change_to_deleted?

    send_email
    send_push_notification
  end

  def send_email
    # send email
    # didnt write this code because it will too specific but here we can send email using UserMailer.send_updates
    # UserMailer.send_updates(id)
  end

  def send_push_notification
    # send push notification
    # SERVICE AND ADAPTER PATTERN can be implemented here
    # PushNotification.send_user_updates(id)
    # we can create a adapter for push notification either through GCM or what but we need user mobile token id, which I have not been asked to implement
    # hence we can call a SERVICE here which will indeed call the ADAPTER (GCM or whichever push notification third party we wanna use)
  end
end
