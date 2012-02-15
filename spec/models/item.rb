class Item
  include Mongoid::Document
  include Mongoid::Alphadog
  
  field :name, type: String
  
  alphabetize_on :name
end