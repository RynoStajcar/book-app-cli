class BookScraper::Subjects

  attr_accessor :subjects, :subject_page

  def initialize
    subjects
    subject_page
  end

  def gets_page
    Nokogiri::HTML(open('http://books.toscrape.com/index.html'))
  end

  def subjects
    @subjects = gets_page.css("div.side_categories li ul a").map {|subject|subject.text.strip}
  end

  def subject_page
    @subject_page = gets_page.css("div.side_categories li ul a").map {|subject|"http://books.toscrape.com/#{subject.values.first}"}
  end

end
