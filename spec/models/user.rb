class User
  include Mongoid::Document
  include Mongoid::Alphadog
  
  field :first_name, type: String
  field :last_name, type: String
  field :favorite_color, type: String
  
  alphabetize_on :first_name, :last_name, :favorite_color
end