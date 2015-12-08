# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  sender_id       :integer
#  recipient_id    :integer
#  subject         :string
#  content         :text
#  conversation_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :message do
    
  end

end
