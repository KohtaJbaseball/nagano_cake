# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  def new
    @admin = Admin.new
  end

  # POST /resource/sign_in
  def create
    @admin = Admin.new
    @admin.save
    if @admin
      redirect_to admin_path
    else
      render :new
    end
  end

  # DELETE /resource/sign_out
  def destroy
    redirect_to new_admin_session_path
  end


  def after_sign_in_path_for(resource)
    admin_path
  end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
