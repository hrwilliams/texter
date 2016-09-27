class CreateContactsMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts_messages do |t|
      t.integer 'message_id'
      t.integer 'contact_id'
    end
  end
end
