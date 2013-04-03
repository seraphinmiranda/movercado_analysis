class ValidatorMailer < ActionMailer::Base
  	default from: "seraphinmiranda.movercado@gmail.com"

  	def vendor_over_1000_warning(user_id)
  		@user_id = user_id
  		@host = @@domain
    	mail(:to => "movercado-jobs@psi.org.mz", :subject => "Final movercado-analysis submission")
	end

end
