#\ -w
$: << File.expand_path('..', __FILE__)

require 'rubygems' if RUBY_VERSION < '1.9'
require 'bundler/setup'

require 'rack/file'
require 'rack/directory'
run Rack::Directory.new(File.expand_path('../public', __FILE__))
