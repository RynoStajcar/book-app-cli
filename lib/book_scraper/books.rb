class BookScraper::Books

  attr_accessor :book_info, :books, :current_page

  @@all = []

  def initialize
    gets_main_page
    scrape_books
    @@all << self
  end

  def self.all
    @@all
  end

  def gets_main_page
    @current_page = Nokogiri::HTML(open('http://books.toscrape.com/catalogue/category/books_1/page-1.html'))
  end

  def next_page
    new_page = @current_page.css("li.next a").map {|i| i.values.first}
    part = 'http://books.toscrape.com/catalogue/category/books_1/' + new_page.first
    @current_page = Nokogiri::HTML(open(part))
  end

  def previous_page
    new_page = @current_page.css("li.previous a").collect {|i| i.values.first}
    part = 'http://books.toscrape.com/catalogue/category/books_1/' + new_page.first
    @current_page = Nokogiri::HTML(open(part))
  end

  def scrape_books
    @books = @current_page.css("ol.row h3 a").collect {|book|book.values}
  end

  def titles
    scrape_books
    @books.detect.with_index {|book, index| puts "#{index+1}. #{book[1]}"}
  end

  def page_info
    @current_page.css("li.current").text.strip
  end

  def change_page(input)
    if input == "next"
      self.next_page
    elsif input == "previous"
      self.previous_page
    end
  end

end
