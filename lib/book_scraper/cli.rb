#!/usr/bin/env ruby

class BookScraper::Cli

  attr_accessor :sub, :book_info

  def main_menu
    subject = BookScraper::Subjects.new
    puts "Select a subject below!"
    puts ""
    sleep 1
    subject.subjects.detect.with_index {|subject, index| puts "#{index+1}. #{subject}"}
    puts ""
    puts "Scroll up and down to view all subjects and select one by typing in the number"
    num = gets.strip.to_i - 1
    puts ""
    @sub = subject.subject_page[num]
    book_menu(sub)
  end

  def book_menu(sub = @sub)
    books = BookScraper::Books.new(sub)
    books.titles
    puts ""
    puts "Select a book or type 'menu' to go back"
    input = gets.strip
    if input == "menu"
      main_menu
    elsif input.to_i > 0 && input.to_i <= books.books.count
      @book_info = books.book_page[input.to_i-1]
      book_details(book_info)
    else
      "Input Error"
      book_menu
    end
  end

  def book_details(book_info = @book_info)
    book = BookScraper::Summary.new(book_info)
    puts ""
    puts ""
    puts "Title: #{book.title}"
    puts ""
    puts "Summary"
    puts "-----------------"
    puts "#{book.summary}"
    puts ""
    puts "Price: #{book.price}"
    puts ""
    puts " 'back' for previous menu"
    puts " 'menu' for main menu"
    input = gets.strip
    if input == 'menu'
      main_menu
    elsif input == 'back'
      book_menu(sub)
    else
      puts "Input Error"
      sleep 2
      book_details
    end
  end

end
