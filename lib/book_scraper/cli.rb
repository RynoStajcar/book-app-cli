#!/usr/bin/env ruby

class BookScraper::Cli

  def main_menu
    # subject = BookScraper::Subjects.new
    book = BookScraper::Books.new
    puts "#{book.book_title}"
    puts "At the bottom type in the number next to the subject you want to see books on"

  end


end
