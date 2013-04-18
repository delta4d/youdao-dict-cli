#!/usr/bin/env ruby
# a simple ruby script for translating in cli
# by delta

require 'open-uri'
require 'rexml/document'

# URL prefix and suffix defination
PREFIX  = 'http://dict.youdao.com/search?q='
SUFFIX  = '&xmlDetail=true&doctype=xml'
# Linux terminal color codes
RESET   = "\e[0m"
BLACK   = "\e[30m"
RED     = "\e[31m"
GREEN   = "\e[32m"
YELLOW  = "\e[33m"
BLUE    = "\e[34m"
MAGENTA = "\e[35m"
CYAN    = "\e[36m"
# Exit codes defination
EXIT    = "bye"

def usage
	puts <<-END.gsub(/^\s*\|/, '')
		|Usage:
		|#{File.basename($0).to_s} [arg]
		|  no arguments: starting translating! enter bye to exit the program
		|  any arguments: display this help
	END
end

def translate
	while true
		word = gets.chomp.force_encoding('ASCII-8BIT')
		url = PREFIX + word + SUFFIX
		xml = URI.parse(URI::encode(url)).read
		doc = REXML::Document.new(xml)
		doc.elements.each('yodaodict/custom-translation/translation/content/') do |e|
			text = e.text.to_s.split
			puts "#{RED}#{text[0]} #{GREEN}#{text[1..-1].join}#{RESET}"
		end
		puts ""
		break if EXIT == word # after translate bye, then exit
	end
	puts "#{CYAN}bye ^_^#{RESET}"
end

ARGV.length == 0 ? translate : usage
