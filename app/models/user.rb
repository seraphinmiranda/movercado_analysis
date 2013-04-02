class User < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :roles
  has_many :interactions
  has_many :codes
  has_many :phones

  attr_accessible :roles_attributes, :phones_attributes

  accepts_nested_attributes_for :roles, :phones

  def default_phone
    (phones.blank?) ? Phone.create(number: SecureRandom.hex) : phones.first
  end

  def interacted?(app)
    self.interactions.where(app_id: app.id).present?
  end

  def vendor?(app)
    has_role?(app, "vendor")
  end

  def activista?(app)
    has_role?(app, "activista")
  end

  def has_role?(app, role_name)
    self.roles.where(app_id: app.id, name: role_name).present?
  end

  def to_s
    "#{self.id}"
  end

  #args: {:roles => "activista", :day_of_the_week => "25/03/2013" } 
  def first_interaction_of_the_week(args={})
     t_content = Interaction.by_week(args[:day_of_the_week].to_time.strftime("%V").to_i - 2).joins(:user => :roles).where(:user_id => self.id, :roles => {:name => args[:roles].to_s}).order("interactions.created_at ASC").limit(1)
     if t_content.size > 0
        return t_content.first.created_at
     else
        return ""
     end
  end

  #args: {:roles => "activista", :day_of_the_week => "25/03/2013" } 
  def last_interaction_of_the_week(args={})
     t_content = Interaction.by_week(args[:day_of_the_week].to_time.strftime("%V").to_i - 2).joins(:user => :roles).where(:user_id => self.id, :roles => {:name => args[:roles].to_s}).order("interactions.created_at DESC").limit(1)
     if t_content.size > 0
        return t_content.first.created_at
     else
        return ""
     end
  end

end
