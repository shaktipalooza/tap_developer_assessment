require 'rails_helper'

RSpec.describe "Projects", type: :request do
  fixtures :projects

  describe 'on GET to Index' do
    let(:data) { JSON.parse(response.body).with_indifferent_access }
    let(:projects) { data['projects'] }

    before do
      get '/api/v1/project'
    end

    it 'responds with :ok' do
      expect(response.code).to eq '200'
      expect(response.message).to eq 'OK'
    end
  end

  describe 'on GET to Index with paging' do
    let(:data) { JSON.parse(response.body).with_indifferent_access }
    let(:projects) { data['projects'] }

    before do
      get '/api/v1/project', params: {per: 2, page: 1}
    end

    it 'expects project count to equal 2' do
      expect(projects.size).to eq 2
    end
  end

  describe 'on GET to Index with sorting on tags (json data)' do
    let(:data) { JSON.parse(response.body).with_indifferent_access }
    let(:projects) { data['projects'] }

    before do
      get '/api/v1/project', params: {sort_by: :tags, order: :desc}
    end

    it 'expects project tags be desc' do
      expect(projects[0][:tags]).to eq({"weapon"=>"crowbow", "beverages"=>"schlitz malt liquor"})
    end
  end

  describe 'on GET to Index with sorting on name ascending' do
    let(:data) { JSON.parse(response.body).with_indifferent_access }
    let(:projects) { data['projects'] }

    before do
      get '/api/v1/project', params: {sort_by: :name, order: :asc}
    end

    it 'expects Disneyland to be first' do
      expect(projects[0][:name]).to eq 'Disneyland Reopening'
    end
    it 'expects Zombies to be last' do
      expect(projects.last[:name]).to eq 'Zombie Penitentiary'
    end
  end

  describe 'on GET to Index with sorting on name descending' do
    let(:data) { JSON.parse(response.body).with_indifferent_access }
    let(:projects) { data['projects'] }

    before do
      get '/api/v1/project', params: {sort_by: :name, order: :desc}
    end

    it 'expects Disneyland to be first' do
      expect(projects[0][:name]).to eq 'Zombie Penitentiary'
    end
    it 'expects Zombies to be last' do
      expect(projects.last[:name]).to eq 'Disneyland Reopening'
    end
  end

  describe 'on POST with valid params' do
    let(:data) { JSON.parse(response.body).with_indifferent_access }
    let(:project) { data['project'] }

    before do
      @projects_size = Project.all.size
      post '/api/v1/project', params: {name: 'New Project', type: 'a', tags: {tag_item_1: 'tag_item1_value'}}
    end

    it 'expects a record to be added the projects table' do
      expect(Project.all.size).to eq @projects_size + 1
    end

    it 'responds with :ok' do
      expect(response.code).to eq '201'
      expect(response.message).to eq 'Created'
    end

    it 'has JSON response' do
      expect(data[:project][:name]).to eq 'New Project'
      expect(data[:project][:type]).to eq 'A'
      expect(data[:project][:tags]).to eq({"tag_item_1"=>"tag_item1_value"})
    end
  end
end
