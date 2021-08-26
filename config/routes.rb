Rails.application.routes.draw do



  # Routes for the User account:
  get("/", { :controller => "user_authentication", :action => "sign_in_form" })

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })

 # Member Homepage
  get("/member_homepage", { :controller => "user_authentication", :action => "member_homepage" }) 

  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })

  # VC Member Directory
  get("/venture_capital_members", { :controller => "user_authentication", :action => "venture_capital_members" }) 

  # Startups Member Directory
  get("/startups_members", { :controller => "user_authentication", :action => "startups" }) 
  
  
  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
   post("/insert_user", { :controller => "user_authentication", :action => "create"  })
        
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
