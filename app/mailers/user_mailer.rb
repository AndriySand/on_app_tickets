class UserMailer < ActionMailer::Base
  default from: 'australicyber@gmail.com'

  def welcome_email(ticket)
    @ticket = ticket
    mail(to: ticket.user_email, subject: 'We received your enquiry')
  end

end
