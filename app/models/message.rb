class Message < ActiveRecord::Base
  before_create :send_sms
  # before_save :tos
  has_and_belongs_to_many :contacts
  accepts_nested_attributes_for :contacts

  private
  #
  # def tos=(tos)
  #  tos.reject(&:blank?)
  # end

  def send_sms
    begin
      JSON.parse(to).each do |recipient|
        response = RestClient::Request.new(
        :method => :post,
        :url => 'https://api.twilio.com/2010-04-01/Accounts/AC4cd1074a87b255c311152ea873ddd453/Messages.json',
        :user => ENV['TWILIO_ACCOUNT_SID'],
        :password => ENV['TWILIO_AUTH_TOKEN'],
        :payload => { :Body => body,
                      :From => from,
                      :To => recipient }
        ).execute
    end
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      throw(:abort)
    end
  end
end
