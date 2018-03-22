#!/usr/bin/env ruby

class BookScraper::Cli

  attr_accessor :subject, :book_info

  def main_menu
    library = BookScraper::Subjects.new
    puts "Select a subject below!"
    puts ""
    sleep 1
    library.list_subjects
    puts ""
    puts "Scroll up and down to view all subjects and select one by typing in the number"
    num = gets.strip.to_i - 1
    puts ""
    sub_page = library.subject_page[num]
    sub = library.subjects[num]
    @subject = BookScraper::Books.new(sub_page, sub)
    subject_menu(subject)
  end

  def subject_menu(subject = @subject)
    subject.books.each_slice(10).with_index do |books, i|
      puts ""
      puts ""
      puts ""
      puts "Books in '#{subject.sub_name}': page #{i+1}/#{subject.books.each_slice(10).count}"
      puts "-----------------"
      books.map.with_index {|book, index| puts "#{i*10+index+1}. #{book}"}
        puts ""
      if books.count == 10
        puts "Type 'menu' for main menu"
        puts "Hit enter for page #{i+2}"
        input = gets.strip
        if input == 'menu'
          main_menu
        elsif input.to_i > 0 && input.to_i <= books.count
          @book_info = subject.book_page.first[input.to_i-1]
          book_details(book_info)
        elsif input
          next
        end
      elsif books.count < 10 && i > 0
        puts "Type 'menu' for main menu"
        puts "Hit enter for page 1"
        input = gets.strip
          if input == 'menu'
            main_menu
          elsif input.to_i > 0 && input.to_i <= books.count
            @book_info = subject.book_page.first[input.to_i-1]
            book_details(book_info)
          elsif input
            subject_menu
          end
      elsif books.count < 10
        puts "Type 'menu' for main menu"
        input = gets.strip
          if input == 'menu'
            main_menu
          elsif input.to_i > 0 && input.to_i <= books.count
            @book_info = subject.book_page.first[input.to_i-1]
            book_details(book_info)
          elsif input
            subject_menu
          end
        end
      end
    end

  def book_details(book_info = @book_info)
    book = BookScraper::Summary.new(book_info)
    puts ""
    puts ""
    puts "Title:"
    puts "----------------"
    puts "#{book.title}"
    puts ""
    puts "Summary:"
    puts "-----------------"
    puts "#{book.summary}"
    puts ""
    puts "Production Information:"
    puts "------------------"
    puts "#{book.information}"
    puts ""
    puts " 'back' for previous menu"
    puts " 'menu' for main menu"
    input = gets.strip
    if input == 'menu'
      main_menu
    elsif input == 'back'
      subject_menu(subject)
    else
      puts "Input Error"
      sleep 2
      book_details
    end
  end

end
