class BookScraper::Subjects

  attr_accessor :subjects

  def initialize
    scrape_subjects
  end

  def gets_page
    Nokogiri::HTML(open('http://books.toscrape.com/index.html'))
  end

  def scrape_subjects
    @subjects = gets_page.css("div.side_categories li ul a").collect {|subject|subject.text.strip}
  end

  def list_subjects
    @subjects.detect.with_index {|subject, index| puts "#{index+1}. #{subject}"}
  end

end
