class BookScraper::Books

  attr_accessor :book_page, :books, :subject_page

  def initialize(sub)
    @subject_page = sub
    scrape_books
    book_page
  end

  def get_page
    Nokogiri::HTML(open(@subject_page))
  end

  def self.all
    @@all
  end

  def scrape_books
    @books = get_page.css("ol.row h3 a").collect {|book|book.values.last}
  end

  def book_page
    @book_page = get_page.css("ol.row h3 a").collect {|book|"http://books.toscrape.com/catalogue/#{book.values.first[9..-1]}"}
  end

  def titles
    @books.detect.with_index {|book, index| puts "#{index+1}. #{book}"}
  end


end
