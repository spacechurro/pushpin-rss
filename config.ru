require 'rubygems'
require 'bundler'

Bundler.require

require './pushpin.rb'

run Sinatra::Application
