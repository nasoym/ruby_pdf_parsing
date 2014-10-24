#!/usr/bin/env ruby
require 'rubygems'

require 'pdf-reader'

class CustomReceiver

  attr_reader :callbacks, :text
  def initialize
    @callbacks = []
    #@text = ''
    @text = []
    @current_row = 0
    @current_column = 0
    @current_font = []
    @encoding = PDF::Reader::Encoding.new(:StandardEncoding)
  end

  def sort_text()
    @text.sort!{|a,b| b[:row] <=> a[:row] }
    @text.each do |i|
      i[:text].sort!{|a,b| a[:column] <=> b[:column]}
    end
  end

  def extract_text()
    final_text = ''
    @text.each do |row|
      row[:text].each do |col|
        #puts col[:text]
        final_text += col[:text]
        #final_text += @encoding.to_utf8(col[:text]).to_s
      end
      final_text += "\n"
    end
    final_text
  end

  def begin_text_object(*args)
    #puts "begin_text_object: #{args}"
  end

  def end_text_object(*args)
    #puts "end_text_object: #{args}"
  end

  def set_text_font_and_size(*args)
    #puts "set_text_font_and_size: #{args}"
    @current_font = args
  end

  def set_text_matrix_and_text_line_matrix(*args)
    #puts "set_text_matrix_and_text_line_matrix: #{args}"
    @current_column = args[4]
    @current_row = args[5]
  end

  def set_spacing_next_line_show_text(*args)
    #puts "set_spacing_next_line_show_text: #{args}"
  end

  def show_text_with_positioning(*args)
    #puts "show_text_with_positioning:"
    #puts "args.size:#{args.size}"
    #puts "show_text_with_positioning: #{args}"
    text = ''
    args.first.each do |i|
      if i.is_a?(String)
        text += i
      end
    end
    index = @text.index{|i| i[:row]==@current_row}
    if index.nil?
      index = @text.index{|i| i[:row]==@current_row}
      @text.push(
        {
          row: @current_row,
          text: []
        }
      )
    end
    index = @text.index{|i| i[:row]==@current_row}

    #if @text[@current_row.to_s].nil?
      #@text[@current_row.to_s] = []
    #end
    #@text[@current_row.to_s].push(
    @text[index][:text].push(
      {
        text: text,
        font: @current_font,
        column: @current_column
      }
    )
    #@text += "\n"

  end

end

if ARGV.length >= 1
  filename = ARGV[0]
  puts "opening file: #{filename}"

  reader = PDF::Reader.new(filename)

  puts "page_count:#{reader.page_count}"

  page = reader.pages[2]
  receiver = PDF::Reader::RegisterReceiver.new
  #receiver = CustomReceiver.new

  page.walk(receiver)

  receiver.callbacks.each do |cb|
    puts cb
#    if cb[:name] == :show_text_with_positioning
#      #puts cb[:args]
#    end
  end

  #puts receiver.raw_content
  #puts page.text

  #receiver.sort_text()
  #text = receiver.extract_text()
  #puts text
  #puts "text: #{receiver.text}"


end

