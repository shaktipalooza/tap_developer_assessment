require 'rails_helper'

RSpec.describe Project::Operation::Create do
  it 'returns a Trailblazer Operation result' do
    result = Project::Operation::Index.(params: {sort_by: :name, order: :desc})

    expect( result.class ).to eq Trailblazer::Operation::Railway::Result
  end

  it 'creates a new Project on success' do
    result = Project::Operation::Create.(params: {name: 'test_project', type: 'A'})

    expect( result.success? ).to eq true
    expect( result[:model].class ).to eq Project
  end

  it 'fails when creating an invalid Project' do
    result = Project::Operation::Create.(params: {name: nil, type: 'A'})

    expect( result.success? ).to eq false
    expect( result[:model].valid? ).to eq false
  end
end
