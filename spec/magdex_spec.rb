require 'spec_helper'

describe Magdex do
  before(:all) { Maglev::PERSISTENT_ROOT.clear; Maglev.commit_transaction }
  before(:each) { Maglev.abort_transaction }

  it 'should have a version' do
    Magdex::VERSION.should be_a(String)
  end

  it 'should be persistable' do
    Magdex.maglev_persistable?.should be_true
  end

  it 'should list stores' do
    keys = [:foo, :bar, :baz]
    keys.each do |key|
      Magdex.store_for(key)
    end
    Magdex.stores.should match_array(keys)
  end

  describe 'store_for' do
    it 'should give me a store' do
      store = Magdex.store_for(:users)
      store.should be_a(Magdex::Store)
    end

    it 'should return the same store' do
      object_ids = 2.times.map { Magdex.store_for(:users).object_id }
      object_ids[0].should be(object_ids[1])
    end
  end
end
