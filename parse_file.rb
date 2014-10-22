#!/usr/bin/env ruby
require 'rubygems'

require 'pdf-reader'

if ARGV.length >= 1
  filename = ARGV[0]
  puts "opening file: #{filename}"

  reader = PDF::Reader.new(filename)

  puts reader.pdf_version
  puts reader.info
  puts reader.metadata
  puts reader.page_count

end

