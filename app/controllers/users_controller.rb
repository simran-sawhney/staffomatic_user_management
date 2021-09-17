class UsersController < ApplicationController
  before_action :restrict_user_access, only: [:archive, :unarchive, :delete]

  def index
    users = UsersSearch.call(user_search_params)

    render jsonapi: users
  end

  def archive
    user = User.unarchived.non_deleted.find_by(id: user_update_params[:user_id])
    raise 'Invalid user id' unless user.present?

    user.archived!
    success_response({}, "User is successfully archived")
  end

  def unarchive
    user = User.archived.non_deleted.find_by(id: user_update_params[:user_id])
    raise 'Invalid user id' unless user.present?

    user.archived!
    success_response({}, "User is successfully unarchived")
  end

  def delete
    user = User.unarchived.non_deleted.find_by(id: user_update_params[:user_id])
    raise 'Invalid user id' unless user.present?

    user.delete!
    success_response({}, "User is successfully deleted")
  end

  def changes
    user = User.find_by(user_update_params[:user_id])
    success_response(user.changes)
  end

  private

  def restrict_user_access
    raise "You cannot #{params[:action]} yourself" if current_user.present? && current_user.id == params[:id]
  end

  def user_search_params
    params.permit(:email, :archived)
  end

  def user_update_params
    params.permit(:user_id)
  end


end
