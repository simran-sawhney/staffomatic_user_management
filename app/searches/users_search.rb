class UsersSearch < BaseSearches

  FIELDS = :archived, :email
  TABLE_NAME = User.name.pluralize.downcase
  attr_accessor *FIELDS

  def initialize(options = {})
    options ||= {}
    FIELDS.each do |field|
      if options[field].is_a?(Array)
        options[field].reject!(&:blank?)
        options[field] = nil if options[field].empty?
      end
      send("#{field}=", options[field])
    end
  end

  def call
    target_model = TABLE_NAME.classify.constantize
    @scope = target_model.non_deleted.order(id: :desc)
    FIELDS.each do |field|
      send("scope_by_#{field}") if send(field).present?
    end
    @scope
  end

  private

  def scope_by_archived
    return if archived.nil?

    @scope = archived.present? ? @scope.archived : @scope.unarchived
  end

  def scope_by_email
    email_str = email.to_s.strip
    @scope = @scope.where(email: email_str)
  end
end
