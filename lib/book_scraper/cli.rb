#!/usr/bin/env ruby

class BookScraper::Cli

  def main_menu
    subject = BookScraper::Subjects.new
    puts "Select a subject below!"
    puts ""
    sleep 2
    subject.subjects.detect.with_index {|subject, index| puts "#{index+1}. #{subject}"}
    puts ""
    puts "Scroll up and down to view all subjects and select one by typing in the number"
    num = gets.strip.to_i - 1
    puts ""
    sub = subject.subject_page[num]
    detailed_menu(sub)
  end

  def detailed_menu(sub)
    books = BookScraper::Books.new(sub)
    books.titles
    puts ""
    puts "Select a book or type 'menu' to go back"
    input = gets.strip
    if input == "menu"
      main_menu
    else
      info = books.book_page[input.to_i-1]
      BookScraper::Summary.new(info)
    end
  end

end
