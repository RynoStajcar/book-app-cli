class BookScraper::Summary

  attr_accessor :book_page

  def initialize(book_info)
    @book_page = book_info
    summary
  end

  def get_page
    Nokogiri::HTML(open(@book_page))
  end


  def summary
    @summary = get_page.css("article.product_page p")[3].text
  end

  def title
    @title = get_page.css("div.col-sm-6 h1").text
  end

  def price
    @price = get_page.css("div.col-sm-6 p.price_color").text
  end

end
