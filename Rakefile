#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

MovercadoAnalysis::Application.load_tasks

#rake namespace to generate trokaAki stuffs
namespace :trokaAkiGenerator  do
	desc "Create 1000 trokaAki interactions as a vendor"
	task :generate1000TrokaAki  => :environment do
		initial_time = Time.now
		puts "Starded now: " + initial_time.to_s
		t = App.find_or_create_by_name_and_type_and_code(:name => "Troca Aki Campaign", :type => "TrocaAkiValidation", :code => "ttt")
		u_user = User.create!
  		u_user.roles.create(app_id: t.id, name: "vendor")
  		#added 1001 to raise after create validation
		1001.times do
  			Interaction.create(:name => 'Troca Aki interaction', :user_id =>u_user.id, :app_id =>t.id)
  		end
  		final_time = Time.now
  		puts "Finished now: " + final_time.to_s
  		puts "Time elapsed: " + (final_time - initial_time).round(2).to_s + " seconds"
	end
end