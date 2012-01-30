require File.dirname(__FILE__) + '/../pushstate_app'
require 'rack/test'

describe 'PushState Presentation App' do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it 'should respond to /' do
    get '/'
    last_response.should be_ok
  end

  it 'should return the correct content-type when viewing root' do
    get '/'
    last_response.headers['Content-Type'].should == 'text/html;charset=utf-8'
  end

  it 'should return 404 when page cannot be found' do
    get '/404'
    last_response.status.should == 404
  end

  it 'should have a content div when viewing root' do
    get '/'
    last_response.body.should =~ /<div[^>]+id=['"]content['"]/
  end

  it 'should tell people what they will learn when viewing root' do
    get '/'
    last_response.body.should =~ /you will learn/i
  end

  it 'should respond to /what-is-new' do
    get '/what-is-new'
    last_response.should be_ok
  end

  it 'should respond to /motivation' do
    get '/motivation'
    last_response.should be_ok
  end

  it 'should respond to /compatibility' do
    get '/compatibility'
    last_response.should be_ok
  end

  it 'should respond to /pushstate' do
    get '/pushstate'
    last_response.should be_ok
  end

end