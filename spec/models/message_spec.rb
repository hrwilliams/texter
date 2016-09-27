
require 'rails_helper'


describe Message do
  it "doesn't save the message if twilio gives an error" do
    message = Message.new(:body => 'hi', :to => '1111', :from => '9717035923')
    message.save.should be false
  end

  it "adds an error if the number is invalid" do
    message = Message.new(:body => 'hi', :to => '1111', :from => '9717035923')
    message.save
    message.errors[:base].should eq ["The 'To' number 1111 is not a valid phone number."]
  end
end
