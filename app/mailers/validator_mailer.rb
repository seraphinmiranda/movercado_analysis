class ValidatorMailer < ActionMailer::Base
  	default from: "seraphinmiranda.movercado@gmail.com"

  	def vendor_over_1000_warning(user_id)
  		@user_id = user_id
  		@host = @@domain
    	mail(:to => "seraphinmiranda.movercado@gmail.com", :subject => "Warning vendor #{user_id}")
	end

end
