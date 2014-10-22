#!/usr/bin/env ruby
require 'rubygems'

require 'pdf-reader'

class CustomReceiver

  attr_reader :callbacks, :text
  def initialize
    @callbacks = []
    @text = ''
  end

  def begin_text_object(*args)
#    puts "args.size:#{args.size}"
    puts "begin_text_object: #{args.first}"
  end

  def end_text_object(*args)
    #puts "args.size:#{args.size}"
    puts "end_text_object: #{args.first}"
    #@text += "\n"
  end

  def set_text_matrix_and_text_line_matrix(*args)
    puts "set_text_matrix_and_text_line_matrix: #{args.first}"
  end

  def set_spacing_next_line_show_text(*args)
    puts "set_spacing_next_line_show_text: #{args.first}"
  end

  def show_text_with_positioning(*args)
    #puts "show_text_with_positioning:"
    #puts "args.size:#{args.size}"
    puts "show_text_with_positioning: #{args.first}"

    args.first.each do |i|
      if i.is_a?(String)
        @text += i
      end
    end
    #@text += "\n"

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

  #puts "text: #{receiver.text}"

end

