class BookScraper::Books

  attr_accessor :book_info, :books

  @@all = []

  def initialize
    scrape_books
    @@all << self
  end

  def self.all
    @@all
  end

  def gets_page
    Nokogiri::HTML(open('http://books.toscrape.com/catalogue/category/books_1/page-1.html'))
  end

  def scrape_books
    @books = gets_page.css("ol.row h3 a").collect {|book|book.values}
  end

  def book_titles
    @books.detect.with_index {|book, index| puts "#{index+1}. #{book[1]}"}
  end

end
