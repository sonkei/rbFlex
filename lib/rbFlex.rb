# external gem deps
%w[
    net/ssh
    action_view
    active_support/all
    slop
    date
  ].each { |m| require m }
include ActionView::Helpers::DateHelper

# load the app
%w[
    version
    core
  ].each { |m| require "rbFlex/#{m}" }

Opts = Slop.parse do
  banner "ruby ruflex.rb [options]"
  on :y, :yesterday,  'Shows downloaded yesterday'
  on :t, :today,      'Shows downloaded today'
  on :d, :delete,     'Delete flexget log file'
  on :h, :help,       'Print help message'
end

options = Opts.to_hash
puts Opts.help and exit if options[:help] == true

flex = Rbflex.new('192.168.1.145', 'chris')

# clean out options hash
options.each { |k, v|  options.delete(k) if v.nil? }

# launch commands
flex.printAll                                 if options.size == 0
flex.printToday                               if options[:today] == true
flex.printYesterday                           if options[:yesterday] == true
flex.deleteFlexlog('192.168.1.145', 'chris')  if options[:delete] == true