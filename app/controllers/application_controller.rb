class ApplicationController < ActionController::API
  def current_user
    # If test situation when user is logged in
    User.first

    # If test situation when user is not logged in
    # nil
  end
end
