#!/usr/bin/env ruby --disable-gems

require_relative 'bundle/bundler/setup'
require 'repla'
# One of the dependencies of `listen` assumes gems is available, so we re-add
# it here
require 'rubygems'
require 'listen'

require_relative 'lib/controller'

file = ARGF.file unless ARGV.empty?

file_path = File.expand_path(file)

path = File.expand_path(File.dirname(file))

window = Repla::Window.new
window.root_access_directory_path = path
controller = Repla::HTML::Controller.new(file_path, window)

real_pwd = File.realpath(pwd)
real_home = File.realpath(home)
real_library = File.realpath(File.join(home, 'Library'))
disable_listen = [real_home, real_library].include?(real_pwd)
exit if disable_listen

# globs = /(\.html$)|(\.css$)|(\.js$)/
# listener = Listen.to(path, only: globs) do |_modified, _added, _removed|
listener = Listen.to(path) do |_modified, _added, _removed|
  File.open(file) do |_f|
    controller.reload
  end
end

listener.start

trap('SIGINT') do
  exit
end

sleep
