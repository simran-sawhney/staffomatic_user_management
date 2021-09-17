module ApiResponse

  # @param obj - active record single object
  #
  # @description: This method should be used when:
  # 1. having active record object of data
  # 2. DO NOT REQUIRE SERIALIZER for object, other refer serialize_response
  def success_response(obj = nil, message = nil, status = :ok)
    render json: {
      success: true,
      data: obj || nil,
      message: message || nil
    }, status: status
  end

  def error_response(message = "Something went wrong", status = :internal_server_error, obj = nil)
    render json: {
      success: false,
      data: obj || nil,
      error_message: message
    }, status: status
  end


end
