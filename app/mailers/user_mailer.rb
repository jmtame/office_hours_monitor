class UserMailer < ActionMailer::Base
  default from: "notify@office-hours-monitor.herokuapp.com"

  def new_office_hours
    host = Slot.last.host
    User.all.each do |user|
      mail(:to => user.email, :subject => "#{host} just added office hours")
    end
  end
end
