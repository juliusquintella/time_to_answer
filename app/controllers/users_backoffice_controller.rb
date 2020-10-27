class UsersBackofficeController < ApplicationController
  before_action :authenticate_user!
  before_action :build_profile
  before_action :check_pagination
  layout 'users_backoffice'

  private

  def check_pagination
    unless user_signed_in?
      params.extract!(:page)
    end
  end

  def build_profile
    current_user.build_user_profile if current_user.user_profile.blank?
  end
end
