require 'rails_helper'

RSpec.describe "ApiDevelopments", type: :request do

	def parsed_body
    JSON.parse(response.body)
  end

  describe 'RDBMS-backed' do
	  before(:each) { Foo.delete_all }
	  after(:each)  { Foo.delete_all }

	  it 'create RDBMS-backed model' do
		  obj = Foo.create(name: 'Test')
		  expect(Foo.find(obj.id).name).to eq('Test')
	  end
	  it 'expose RDBMS-backed API resource' do
      obj = Foo.create(name: 'Test')
      expect(foos_path).to eq('/api/foos')
		  get foo_path(obj.id)
		  expect(response).to have_http_status(:ok)
		  expect(parsed_body['name']).to eq('Test')
	  end
  end

  describe 'MongoDB-backed' do
    before(:each) { Bar.delete_all }
    after(:each)  { Bar.delete_all }

	  it 'create MongoDB-backed model' do
		  obj = Bar.create(name: 'Test')
		  expect(Bar.find(obj.id).name).to eq('Test')
	  end

	  it 'expose MongoDb-backed API resource' do
		  obj = Bar.create(name: 'Test')
		  expect(bars_path).to eq('/api/bars')
		  get (bar_path(obj.id))
		  expect(response).to have_http_status(:ok)
		  expect(parsed_body['name']).to eq('Test')
	  end
  end
end
