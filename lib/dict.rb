#!/usr/bin/env ruby
# a simple ruby script for translating in cli
# by delta

require 'open-uri'
require 'rexml/document'

# URL prefix, URL suffix, doc elements defination
PREFIX  = 'http://dict.youdao.com/search?q='
SUFFIX  = '&xmlDetail=true&doctype=xml'
ELE = 'yodaodict/custom-translation/translation/content/'

def translate(word)
	url = PREFIX + word + SUFFIX
	xml = URI.parse(URI::encode(url)).read
	doc = REXML::Document.new(xml)
	doc.elements.each(ELE) do |e|
		text = e.text.to_s.split
		yield text
	end
end
