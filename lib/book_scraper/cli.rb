#!/usr/bin/env ruby

class BookScraper::Cli

  def main_menu
    subject = BookScraper::Subjects.new
    book = BookScraper::Books.new
    puts "#{book.page_info}"
    puts "#{book.titles}"
    puts ""
    input = gets.strip
    if input == "next" || input == "previous"
      book.change_page(input)
      binding.pry
      main_menu
    else
      puts "Wrong input"
    end
  end



end
