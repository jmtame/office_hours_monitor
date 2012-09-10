class Slot < ActiveRecord::Base
  attr_accessible :date, :host, :start_end_times
  validates_uniqueness_of :host, :scope => [:start_end_times, :date]

  after_create :notify

  def self.update
    agent = Mechanize.new
    page = agent.get("http://news.ycombinator.com/newslogin?whence=news")

    # Create the session
    form = agent.page.forms.first
    form.u = 'jmtame'
    form.p = APP_CONFIG['YC_PW'] || ENV['YC_PW']
    logged_in_page = form.submit form.buttons.first

    # Parse out the date, time, and host
    page = agent.get("http://news.ycombinator.com/booker")

    page.search("td.admin tr td").each do |td|
      if td.text =~ /\d+:\d.*to.*\d:\d+/i # "12:00 pm to 12:20 pm"
        date = td.text.scan(/\d{1,}.*\d{4}/i).first # eg "10 September 2012"
        start_end_times = td.text.scan(/\d+:\d+.* to \d+:\d+.{3}/i).first # "12:00 pm to 12:20 pm"
        host = td.text.scan(/with\s\w{1,50}/i).first.split(" ")[1] # "harj"
        Slot.create(:date => date, :start_end_times => start_end_times, :host => host)
      end
    end
  end

  def notify
    UserMailer.new_office_hours
  end
end
