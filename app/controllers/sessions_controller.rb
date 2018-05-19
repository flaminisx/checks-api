class SessionsController < Devise::SessionsController

  prepend_before_action :require_no_authentication, :only => [:create]
  before_action :ensure_params_exist, only: :create

  respond_to :json

  def create
    user = User.find_by(email: user_params[:email])
    unless user.nil?
    	if user.valid_password? user_params[:password]
        render json: user.as_json(only: [:id, :name, :email, :authentication_token])
        return
      end
    end
    render json: { error: "invalid email and password combination" }
  end

  def destroy
    sign_out(resource_name)
  end

  protected
  def ensure_params_exist
    return unless user_params[:email].blank?
  	render json: { success: false, message: "missing email parameter"}, status: 422
  end

  def invalid_login_attempt
    warden.custom_failure!
  	render json: {success: false, message: "Error with your email or password"}, status: 401
  end

  private

  def user_params
    params.require(:user).permit :email, :password
  end
end
