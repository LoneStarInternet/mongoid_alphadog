require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mongoid::Alphadog, "with 1 field provided" do
  
  it "should include :name_loweralpha field" do
    Item.fields['name_loweralpha'].should_not be_nil
  end
  
  it "should include index on name_loweralpha" do
    Item.index_options[:name_loweralpha].should_not be_nil
  end
  
  %w[ Rabbit xylophone antelope ].each do |name|
    let name.to_s.downcase do
      Item.create(:name => name)
    end
  end  
  
  it "should set the loweralpha field properly" do
    rabbit.name_loweralpha.should == 'rabbit'
    xylophone.name_loweralpha.should == 'xylophone'
    antelope.name_loweralpha.should == 'antelope'
  end
  
  it "should produce the right results with the alphabetized_by scope" do
    provided = %w[ Rabbit Aardvark xylophone fairy Zebra antelope ]
    expected = %w[ Aardvark antelope fairy Rabbit xylophone Zebra ]
    provided.each { |name| Item.create(:name => name) }
    Item.alphabetized_by(:name).map(&:name).should == expected
  end

end

describe Mongoid::Alphadog, "with multiple fields provided" do
  
  it "should include three loweralpha fields" do
    User.fields['first_name_loweralpha'].should_not be_nil
    User.fields['last_name_loweralpha'].should_not be_nil
    User.fields['favorite_color_loweralpha'].should_not be_nil
  end
  
  it "should include indexes" do
    User.index_options[:first_name_loweralpha].should_not be_nil
    User.index_options[:last_name_loweralpha].should_not be_nil
    User.index_options[:favorite_color_loweralpha].should_not be_nil
  end
  
  it "should set the loweralpha fields properly" do
    user = User.create(:first_name => 'John', :last_name => 'Doe', :favorite_color => 'orange')
    user.first_name.should == 'John'
    user.first_name_loweralpha.should == 'john'
    user.last_name_loweralpha.should == 'doe'
    user.favorite_color_loweralpha.should == 'orange'
  end
  
  it "should produce the right results with the alphabetized_by scope" do
    user1 = User.create(:first_name => 'John', :last_name => 'Doe', :favorite_color => 'orange')
    user2 = User.create(:first_name => 'Mary', :last_name => 'Doe', :favorite_color => 'red')
    user3 = User.create(:first_name => 'Steve', :last_name => 'Jobs', :favorite_color => 'orange')
    user4 = User.create(:first_name => 'Arnold', :last_name => 'Bodybuilder', :favorite_color => 'blue')
    user5 = User.create(:first_name => 'frank', :last_name => 'jobs', :favorite_color => 'blue')
    user6 = User.create(:first_name => 'Frank', :last_name => 'Imitator', :favorite_color => 'green')
    results = User.alphabetized_by(:first_name, :last_name, :favorite_color).map(&:first_name)
    results.should == %w[ Arnold Frank frank John Mary Steve ]
  end

end