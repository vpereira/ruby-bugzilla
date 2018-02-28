require 'spec_helper'

describe Bugzilla::Utils do
  before do
    class Foo
      include Bugzilla::Utils
    end
    @info = { URL: 'https://foo.example.org:443/', Proxy: 'http://bar.example.org:8080' }
  end
  describe 'get_xmlrpc' do
    it 'should return an array' do
      expect(Foo.new.get_xmlrpc(@info)).to be_an Array
    end
  end
  describe 'get_proxy' do
    it 'should return an array' do
      expect(Foo.new.get_proxy(@info)).to be_an Array
    end
  end
end
