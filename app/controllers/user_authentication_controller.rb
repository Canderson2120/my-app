class UserAuthenticationController < ApplicationController
  # Uncomment this if you want to force users to sign in before any other actions
  skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })

  def sign_in_form
    render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def sign_up_form
    render({ :template => "user_authentication/sign_up.html.erb" })
  end

  def member_homepage



    render({ :template => "user_authentication/member_homepage.html.erb" })
  end


  def venture_capital_members

    @q = User.ransack(params[:q])
    @users = @q.result

    render({ :template => "user_authentication/venture_capital_members.html.erb" })
  end

  def startups

    @q = User.ransack(params[:q])
    @users = @q.result

   # users = User.all

    render({ :template => "user_authentication/startups_members.html.erb" })
  end


  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)

    p are_they_legit

      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
      
        redirect_to("/member_homepage", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end

  def create
    @user = User.new
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")
    @user.city = params.fetch("query_city")
    @user.bb_interest = params.fetch("focus")
    @user.current_employer = params.fetch("query_current_employer")
    @user.bio = params.fetch("query_bio")
    @user.image = params.fetch("query_image")

    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id
   
      redirect_to("/member_homepage", { :notice => "User account created successfully."})
    else
      redirect_to("/user_sign_up", { :alert => "User account failed to create successfully."})
    end
  end
    
  def edit_profile_form

    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def update
    @user = @current_user
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")
    @user.city = params.fetch("query_city")
    @user.bb_interest = params.fetch("focus")
    @user.current_employer = params.fetch("query_current_employer")
    @user.bio = params.fetch("query_bio")
    @user.image = params.fetch("query_image")
    
    if @user.valid?
      @user.save

      redirect_to("/member_homepage", { :notice => "User account updated successfully."})
    else
      render({ :template => "user_authentication/edit_profile_with_errors.html.erb" })
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/", { :notice => "User account cancelled" })
  end
 
end
