require 'spec_helper'

describe Magdex::Store do
  it 'should be persistable' do
    Magdex::Store.maglev_persistable?.should be_true
  end

  it 'should require a name' do
    lambda { Magdex::Store.new }.should raise_exception(ArgumentError)
    Magdex::Store.new(:batman).name.should be(:batman)
  end

  describe 'basics' do
    let(:bob) { Person.new(1, 'Bob') }
    let(:people) { Magdex::Store.new(:people).tap { |s| s.store(bob) } }

    it 'should make indexes' do
      people.index_by(:id, Fixnum).should be_true
    end

    it 'should find things' do
      people.index_by(:id, Fixnum)
      people.find(:id => [:eql, 1]).should == [bob]
      people.find(:id => [:eql, 0]).should == []
      people.find(:id => [:gte, 1]).should == [bob]
      people.find(:id => [:lt, 10]).should == [bob]
    end

    it 'should combine indexes' do
      people.index_by(:id, Fixnum)
      people.index_by(:name, String)

      jims = (2..10).map { |id| Person.new(id, 'Jim') }
      jims.each { |jim| people.store(jim).should be_true }

      # sanity
      people.find(:name => [:eql, 'Jim']).should match_array(jims)
      people.find(:id => [:lt, 5], :name => [:eql, 'Jim']).should match_array(jims.take(3))
    end
  end
end
