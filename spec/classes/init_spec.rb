require 'spec_helper'
describe 'loadmaster' do

  context 'with defaults for all parameters' do
    it { should contain_class('loadmaster') }
  end
end
