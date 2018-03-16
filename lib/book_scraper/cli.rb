#!/usr/bin/env ruby

class BookScraping::Cli

  def main_menu
    subject = BookScraping::Subjects.new
    book = BookScraping::Books.new
    puts "#{book.book_title}"
    puts "At the bottom type in the number next to the subject you want to see books on"

  end


end
