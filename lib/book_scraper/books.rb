class BookScraper::Books

  attr_accessor :book_page, :books, :subject_page, :sub_name

  def initialize(sub_page, sub)
    @subject_page = sub_page
    @sub_name = sub
    @books = []
    @book_page = []
    scrape_books
  end

  def get_page
    Nokogiri::HTML(open(@subject_page))
  end

  def scrape_books
    @books << get_page.css("ol.row h3 a").collect {|book|book.values.last}
    if get_page.css("li.next").any?
      page = get_page.css("li.next a").first.values.first
      next_page = @subject_page[0..-11] + page
      scrape_next_page(next_page)
    else
      @books = @books.join("+").split("+")
    end
  end

  def scrape_next_page(next_page)
    @subject_page = next_page
    scrape_books
    book_page
  end

  def book_page
    @book_page << get_page.css("ol.row h3 a").collect {|book|"http://books.toscrape.com/catalogue/#{book.values.first[9..-1]}"}
  end

  def books
    @books
  end

end
