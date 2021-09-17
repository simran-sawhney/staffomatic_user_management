# custom exception handler for apis
module ApiExceptionHandler
  extend ActiveSupport::Concern

  class InvalidParams < StandardError; end

  included do
    rescue_from ::ActionController::RoutingError do |e|
      error_response(e.message, :not_found)
    end
    rescue_from StandardError, with: :unhandled_exception
  end

  private

  def unhandled_exception(e)
    message = "Exception Error, error = #{e.message}, params = #{params}, current_user_email = #{current_user.try(:email)}, current_admin_email = #{current_admin_user&.email}"
    logger.error message
    error_response(e.message)
  end
end
