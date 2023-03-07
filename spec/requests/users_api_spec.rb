require 'rails_helper'
require 'httparty'

describe 'Reqres API' do
  include HTTParty
  base_uri 'https://reqres.in'

    it 'returns a list of users' do
        response = self.class.get('/api/users')
        expect(response.code).to eq(200)
        expect(response.content_type).to eq("application/json")
    end

    it 'returns a single user' do
        response = self.class.get('/api/users/2')
        expect(response.code).to eq(200)
        user = JSON.parse(response.body)
        expect(user['data']['id']).to eq(2)
        expect(user['data']['email']).to eq('janet.weaver@reqres.in')
        expect(user['data']['first_name']).to eq('Janet')
        expect(user['data']['last_name']).to eq('Weaver')
    end

    it 'error when single user is not found' do
        response = self .class.get('/api/users/23')
        expect(response.code).to eq(404)

    end

    it 'returns a list of resources' do
        response = self.class.get('/api/unknown')
        expect(response.code).to eq(200)
        expect(response.content_type).to eq("application/json")
    end

    it 'returns a single resource' do
        response = self.class.get('/api/unknown/2')
        expect(response.code).to eq(200)
        resource = JSON.parse(response.body)
        expect(resource['data']['id']).to eq(2)
        expect(resource['data']['name']).to eq('fuchsia rose')
        expect(resource['data']['year']).to eq(2001)
        expect(resource['data']['color']).to eq('#C74375')
    end

    it 'error when single resourse is not found' do
        response = self.class.get('/api/unknown/23')
        expect(response.code).to eq(404)
    end

    it 'create a user' do
        headers = {'Content-Type' => 'application/json'}
        body = {"name": "John", "job": "Tester"}
        response = self.class.post('/api/users', headers: headers, body: body.to_json)
        expect(response.code).to eq(201)
        expect(response.body).to include("John")
        expect(response.body).to include("Tester")
    end
    
    it 'update a user' do
        headers = {'Content-Type' => 'application/json'}
        body = {"name": "Tom", "job": "Dev"}
        response = self.class.put('/api/users/2', headers: headers, body: body.to_json)
        expect(response.code).to eq(200)
        expect(response.body).to include("Tom")
        expect(response.body).to include("Dev")
    end

    it "deletes a user by ID" do
        response = self.class.delete('/api/users/2')
        expect(response.code).to eq(204)
    end

    it "Register user and successful response" do
        headers = {'Content-Type' => 'application/json'}
        body = {"email": "eve.holt@reqres.in", "password": "pistol"}
        response = self.class.post('/api/register', headers: headers, body: body.to_json)
        expect(response.code).to eq(200)
        expect(response.body).to include("token")
    end

    it "register unsuccessful" do
        headers = {'Content-Type' => 'application/json'}
        body = {"email": "sydney@fife"}
        response = self.class.post('/api/register', headers: headers, body: body.to_json)
        expect(response.code).to eq(400)
        expect(response.body).to include("error")
    end

    it "Login-Succesful" do
        headers = {'Content-Type' => 'application/json'}
        body = {"email": "eve.holt@reqres.in", "password": "cityslicka"}
        response = self.class.post('/api/login', headers: headers, body: body.to_json)
        expect(response.code).to eq(200)
        expect(response.body).to include("token")
    end

    it "Login.unsuccessful" do
        headers = {'Content-Type' => 'application/json'}
        body = {"email": "peter@klaven"}
        response = self.class.post('/api/login', headers: headers, body: body.to_json)
        expect(response.code).to eq(400)
        expect(response.body).to include("error")
    end

    it "delayed response" do
        response = self.class.get('/api/users?delay=3')
        expect(response.code).to eq(200)
        expect(response.body).to include("data")
        expect(response.body).to include("page")
    end

end
