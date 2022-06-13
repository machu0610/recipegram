class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  #userのページにアクセスする前にここの記述が動き、private以下に書いている記述が動く


  private
  #この中で定義したメソッドはコントローラーの中でしか使えない

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    #sign_upの時にusernameを許可するという意味
  end
end
