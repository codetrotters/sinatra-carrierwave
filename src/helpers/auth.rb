require 'sinatra/base'
require 'digest'

module Sinatra
  module Auth

    #Define Helper methods
    module Helpers

      #Check if an user is logged in
      def authenticated?
        session[:authorized] || false
      end

      #Return the current authenticated user
      def authenticated_user
        user = nil
        if authenticated?
          user = User.find( session[:authorized] )
        end
        user
      end

      #Checks if a specific user is the one authenticated
      def authenticated_user?( user )
          logged_in_user = authenticated_user
          if user == nil || logged_in_user == nil
            return false
          end
          logged_in_user.id == user.id
      end

      #Authenticate an user
      def authenticate( username , password )

        #Find the user
        password_hashed = Digest::SHA256.hexdigest( password )
        user = User.find_by( username: username , password: password_hashed )

        #Save the user id to the session
        session[:authorized] = user ? user.id : nil

      end

      #Make sure the user is authenticated, before proceeding
      #You can also past a list of roles, one of them
      #must match the current authenticated roles
      def protected!( *roles )

        #Check if the user is logged in
        redirect  options.login_url unless authenticated?

        #Check roles
        unless roles.empty?
          user            = authenticated_user()
          user_roles      = user.roles.to_s.split( "," )
          required_roles  = roles.flatten
          roles_in_common = user_roles & required_roles
          if roles_in_common.empty?
            halt 403 , "Forbidden"
          end
        end

      end

      #Make sure that the user that is authenticated
      #is the passed in user
      def protected_for_user!( user )
          if not authenticated_user? user
            halt 403 , "Forbidden"
          end
      end

      def logout!( redirect = true )
        session[:authorized] = nil
        redirect options.login_url if options.login_url
      end

    end

    #Configure Application
    def self.registered(app)

      #Define Helpers on application
      app.helpers Auth::Helpers

      #Set default configuration
      app.set    :login_url, '/login'

      #Make sure sessions are enabled
      app.enable :sessions

    end

  end

  #Register Module with Sinatra
  register Auth

end
