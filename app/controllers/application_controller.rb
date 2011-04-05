class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_uri
  before_filter :ensure_domain

  APP_DOMAIN = 'countryclubsandwiches.com'

  def check_uri
    if /^www/.match(request.host)
      redirect_to request.protocol + request.host_with_port[4..-1] + request.request_uri 
    end
  end
  
  def ensure_domain
    if request.env['HTTP_HOST'] != APP_DOMAIN
      # HTTP 301 is a "permanent" redirect
      redirect_to "http://#{APP_DOMAIN}", :status => 301
    end
  end
  
  private
    
end
