# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:new, :create]


  # GET /resource/sign_up
  #def new
    #@customer = Customer.new
  #end

  # POST /resource
  #def create
    #customer = Customer.new(configure_sign_up_params)
    #customer.save
   # redirect_to customers_my_page_path
  #end

  # GET /resource/edit


  # PUT /resource

  # DELETE /resource


  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  #def update_resouce(resource,params)
    #resource.update_without_current_password(params)
  #end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,
                                                        :last_name,
                                                        :first_name_kana,
                                                        :last_name_kana,
                                                        :postal_code,
                                                        :address,
                                                        :telephone_number,
                                                        :email])
  end

  # If you have extra params to permit, append them to the sanitizer.

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    customers_my_page_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
