require 'sinatra'
require 'haml'
set :haml, :format => :html5

get '/' do
  haml :index, layout: !request.xhr?
end

get '/what-is-new' do
  haml :what_is_new, layout: !request.xhr?
end

get '/motivation' do
  haml :motivation, layout: !request.xhr?
end

get '/compatibility' do
  haml :compatibility, layout: !request.xhr?
end

get '/pushstate' do
  haml :pushstate, layout: !request.xhr?
end
