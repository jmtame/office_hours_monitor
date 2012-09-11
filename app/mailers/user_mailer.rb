class UserMailer < ActionMailer::Base
  default from: "jmtame@gmail.com"

  def new_office_hours(user)
    host = Slot.last.host
    User.all.each do |user|
      mail(:to => user.email, :subject => "#{host} just added office hours")
    end
  end
end
