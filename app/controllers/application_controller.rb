class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :ensure_domain
  before_filter :add_www_subdomain

  APP_DOMAIN = 'countryclubsandwiches.com'

  def ensure_domain
    if request.env['HTTP_HOST'] != APP_DOMAIN
      # HTTP 301 is a "permanent" redirect
      redirect_to "http://#{APP_DOMAIN}", :status => 301
    end
  end
  
  private
    def add_www_subdomain
      unless /^www/.match(request.host)
        redirect_to("#{request.protocol}x.com#{request.request_uri}",
                    :status => 301)
      end
    end
end
