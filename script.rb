#!/usr/bin/env ruby
require 'optparse'
require 'rubygems'
require 'resolv'
require 'socket'
require 'timeout'
#require 'rex'
require 'thread'
require 'net/http'
require 'uri'
#require 'pry'
# https://raw.githubusercontent.com/zer0h/top-1000000-domains/master/top-10000-domains

@write_mutex = Mutex.new
STDOUT.sync = true

def http(address)
	uri = URI.parse("http://#{address.chomp}/")
	http = Net::HTTP.new(uri.host, 80)
	http.use_ssl = false
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Get.new(uri.request_uri)
	begin
		Timeout::timeout(8) do
			response = http.request(request)
			if response.code.to_i == 200 && response.body =~/Western Drought Linked /
				@write_mutex.synchronize{puts "http://#{address}"}
			end
		end
		rescue Zlib::DataError
		rescue Net::HTTPFatalError
		rescue OpenSSL::SSL::SSLError
		rescue NoMethodError
		rescue Errno::ECONNRESET 
		rescue Errno::ECONNREFUSED
		rescue URI::InvalidURIError
		rescue URI::InvalidURIError 
		rescue URI::InvalidURIError
		rescue Net::HTTPBadResponse
		rescue Timeout::Error
		rescue EOFError
		rescue Errno::ETIMEDOUT
		rescue Exception => ex
			$stderr.puts File.expand_path $0
			$stderr.puts ex.class
			$stderr.puts ex
		rescue ::IOError
			puts "ioerror"
	end
end

def https(address)
	uri = URI.parse("https://#{address.chomp}/")
	http = Net::HTTP.new(uri.host, 443)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	request = Net::HTTP::Get.new(uri.request_uri)
	begin
		Timeout::timeout(8) do
			response = http.request(request)
			if response.code.to_i == 200 && response.body =~/l/
				@write_mutex.synchronize{puts "https://#{address}"}
			end
		end
		rescue Zlib::DataError
		rescue Net::HTTPFatalError
		rescue OpenSSL::SSL::SSLError
		rescue NoMethodError
		rescue Errno::ECONNRESET 
		rescue Errno::ECONNREFUSED
		rescue URI::InvalidURIError
		rescue URI::InvalidURIError 
		rescue URI::InvalidURIError
		rescue Net::HTTPBadResponse
		rescue Timeout::Error
		rescue EOFError
		rescue Errno::ETIMEDOUT
		rescue Exception => ex
			$stderr.puts File.expand_path $0
			$stderr.puts ex.class
			$stderr.puts ex
		rescue ::IOError
			puts "ioerror"
	end
end

options={}
optparse = OptionParser.new do |opts|
	opts.banner = "Usage: script.rb [options] ip/file"
	options[:list] = false
	opts.on( '-l', '--list', 'Take input from a text file list, one IP per line') do
		$stderr.print "Reading input file..."
		list = File.readlines(ARGV[0])
		$stderr.print "...file read.\nCreating Mutex and threads..."
		THREAD_COUNT = 500 
		mutex = Mutex.new
		$stderr.print "...mutex created. Start! #{File.expand_path $0}\n"
		THREAD_COUNT.times.map{
			Thread.new(list) do |ips|
				while ip = mutex.synchronize {ips.pop}
					http(ip.gsub(/\n/, ""))
					https(ip.gsub(/\n/, ""))
				end
			end
		}.each(&:join)
	end
	options[:single] = false
	opts.on( '-s', '--single', 'Take input of a single IP passed through the command line') do
		$stderr.flush
		http(ARGV[0])
		https(ARGV[0])
		exit
	end 
end.parse!

