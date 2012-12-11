# encoding: utf-8
require 'sinatra/base'
require 'pony'

require File.expand_path('../../config/application', __FILE__)

#
# APPLICATION
#
module Application
  class Website < Sinatra::Base
    set :static, true
    set :public_folder, File.expand_path('../../public', __FILE__)

    # Contact form
    post '/contact' do
      Pony.mail(
        :from     => params[:email],
        :to       => 'ganesh-eli@hotmail.com',
        :charset  => 'utf-8',
        :subject  => "Message depuis le site de #{params[:firstname]} #{params[:lastname]}",
        :body     => params[:message]
      )

      redirect '/contact_merci.html'
    end

  end
end
