#!/usr/bin/env ruby
require 'rubygems'

require 'pdf-reader'

class CustomReceiver

  attr_reader :callbacks, :text
  def initialize
    @callbacks = []
    @text = ''
  end

#  def begin_text_object(*args)
#    puts "args.size:#{args.size}"
#  end

  def show_text_with_positioning(*args)
    #puts "show_text_with_positioning:"
    #puts "args.size:#{args.size}"
    #puts "#{args.first}"

    args.first.each do |i|
      if i.is_a?(String)
        @text += i
      end
    end
    @text += "\n"

  end

end

if ARGV.length >= 1
  filename = ARGV[0]
  puts "opening file: #{filename}"

  reader = PDF::Reader.new(filename)

  puts "page_count:#{reader.page_count}"

  page = reader.pages[0]
  receiver = PDF::Reader::RegisterReceiver.new
  #receiver = CustomReceiver.new

  page.walk(receiver)

  receiver.callbacks.each do |cb|
    puts cb
#    if cb[:name] == :show_text_with_positioning
#      #puts cb[:args]
#    end
  end

#  puts "text: #{receiver.text}"

end

