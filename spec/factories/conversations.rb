# == Schema Information
#
# Table name: conversations
#
#  id              :integer          not null, primary key
#  initiator_id    :integer
#  noninitiator_id :integer
#  listing_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :conversation do
    
  end

end
