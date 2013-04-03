class UserMailer < ActionMailer::Base
	default from: "web@info2310.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
	def welcome(user)
		@user = user
		mail(to: user.email, 
		subject: "Welcome to the Info2310 MicroPoster")
	end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.mentioned.subject
  #
  def mentioned(micro_post, mentioned_user)
    @mentioned_user = mentioned_user
	@micro_post = micro_post
    mail(to: @mentioned_user.email, subject: "You were mentioned")
  end
end