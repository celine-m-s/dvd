class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
  end

end

# Pour la page 404

# class ApplicationController < ActionController::Base
#   rescue_from CanCan::AccessDenied do |exception|
#     render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
#     ## to avoid deprecation warnings with Rails 3.2.x (and incidentally using Ruby 1.9.3 hash syntax)
#     ## this render call should be:
#     # render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
#   end
# end 