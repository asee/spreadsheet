#!/usr/bin/env ruby
# suite.rb -- oddb -- 08.01.2009 -- hwyss@ywesee.com

require 'find'
require 'rubygems'

here = File.dirname(__FILE__)

$: << here

Find.find(here) do |file|
	if File.extname(file) == '.rb' && file != __FILE__
    require file
  end
end
