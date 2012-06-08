require 'rubygems'
require 'bundler'
Bundler.require

require 'sinatra'
require "active_support/all"

Rabl.register!

class LogRequest
  attr_reader :text, :time, :created_at, :execution_time
  def initialize(time, text)
    @text = text
    @time = time
    @execution_time = Time.now
  end

  @@log = []
  def self.log_request(time, text)
    @@log << LogRequest.new(time, text)
  end

  def self.log
    @@log
  end

  def self.clear_log!
    @@log = []
  end

end

LogRequest.log_request Time.now, "Just do it alreay"

get '/' do
  @logs = LogRequest.log
  render :rabl, :logs, :format => "json"
end
