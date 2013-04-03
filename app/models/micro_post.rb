class MicroPost < ActiveRecord::Base
	after_create :send_mentions_email
  attr_accessible :content, :user_id
  
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, :length => { :in => 5..140 }
  
	def mentions
		results = []
		content.scan(/@[^@]+@/) do |match|
			name = match[1..match.length - 2]
			# Write some code to look up a user by name; if the result
			# is non-nil, then add them to the results array. You should also check that they
			# aren't @mentioning themselves
			# (remember you can use the '<<' operator to add to an array)
			mentioned_user = User.find_by_name name
			if(mentioned_user && mentioned_user != user)
				results<<mentioned_user
			end
		end
		results
	end
	
	def send_mentions_email
	 # using the function you just wrote iterate each mentioned user,
	 # and send them an email (check the previous slides for the 
	 # syntax of sending an email)
		mentions.each do |mentioned_user|
			UserMailer.mentioned(self, mentioned_user).deliver
		end
	end
end
