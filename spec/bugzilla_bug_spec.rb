require 'spec_helper'

describe Bugzilla::Bug do
  before do
    x = Bugzilla::XMLRPC.new 'bugzilla.suse.com'
    @b = Bugzilla::Bug.new x
  end
  describe :new do
    it 'should not be nil' do
      expect(@b).to_not be_nil
    end
  end
  describe :get_bugs do
    context 'fields default' do
      before do
        @b.stub(:get).and_return({"bugs"=>[{"id":"1","comments":"foo"}]})
        @b.stub(:get_comments).and_return({"1":{"comments":"foo"}})
      end
      it 'should return something good' do
        expect { @b.get_bugs([113,114])}.to_not raise_error
        expect(@b.get_bugs([113,114])).to be_an Array
      end
    end
  end
end
