if Rails.env.production?
	@@domain = "lit-anchorage-4827.herokuapp.com"
else
	@@domain = "localhost:3000"
end

ActionMailer::Base.smtp_settings = {
	:address              => "smtp.gmail.com",  
  	:port                 => 587,                 
  	:domain               => @@domain,  
  	:user_name            => 'seraphinmiranda.movercado@gmail.com',      
  	:password             => 'movercado2013',      
  	:authentication       => 'plain',             
  	:enable_starttls_auto => true
}