require 'date'

class Interaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :app
  attr_accessible :name, :user_id, :app_id

  after_create :validate_over_1000_vendor_sells

  #args: {:roles => "activista", :top_order => "DESC", :n_results => 10, :day_of_the_week => "25/03/2013"} 
  def self.top_by_week(args={})
	   t_array = Interaction.by_week(args[:day_of_the_week].to_time.strftime("%V").to_i - 2).joins(:user => :roles).where( :roles => {:name => args[:roles].to_s}).count(:group => "interactions.user_id", :order => "count_all " + args[:top_order].to_s, :limit => args[:n_results].to_i).to_a
     t_array.each do |elem|
        elem << User.find(elem[0]).first_interaction_of_the_week({:roles => args[:roles].to_s, :day_of_the_week => args[:day_of_the_week].to_s}).to_s 
        elem << User.find(elem[0]).last_interaction_of_the_week({:roles => args[:roles].to_s, :day_of_the_week => args[:day_of_the_week].to_s}).to_s
     end
     return t_array
  end

  #method to get the first intertaction date to use inside calendar date validation
  def self.first_interaction_date
  	Interaction.first.created_at
  end

  #method to get the first intertaction date to use inside calendar date validation
  def self.last_interaction_date
  	Interaction.last.created_at
  end

  #make a validation to check if an user sell more than 1000 items per month
  def validate_over_1000_vendor_sells
    total_trokaAki = Interaction.by_month.joins(:user =>:roles).where(:user_id => self.user_id, :roles => { :name => "vendor"}).group("interactions.user_id").count
    unless total_trokaAki.size == 0
      if total_trokaAki.first.last > 1000
         ValidatorMailer.vendor_over_1000_warning(self.user_id).deliver
      end
    end
  end

end
