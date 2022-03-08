class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when Customer
      customer_my_page
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,
                                                           :last_name,
                                                           :kana_first_name,
                                                           :kana_last_name,
                                                           :email,
                                                           :postal_code,
                                                           :address,
                                                           :telephone_number])
  end
end
