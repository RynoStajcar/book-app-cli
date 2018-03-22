class BookScraper::Summary

  attr_accessor :book_page

  def initialize(book_info)
    @book_page = book_info
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

  def information
    @information = get_page.css("table.table tr").detect do |info|
      puts "  #{info.css("th").text}:  #{info.css("td").text}"
    end
  end

end
