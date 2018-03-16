#!/usr/bin/env ruby

class BookScraper::Cli

  def main_menu
    subject = BookScraper::Subjects.new
    book = BookScraper::Books.new
    binding.pry
    puts "#{book.book_titles}"
    puts "At the bottom type in the number next to the subject you want to see books on"

  end


end
