require 'rails_helper'

RSpec.describe Project::Operation::Index do
  it 'returns a Trailblazer Operation result' do
    result = Project::Operation::Index.(params: {sort_by: :name, order: :desc})

    expect( result.class ).to eq Trailblazer::Operation::Railway::Result
  end

  it 'creates a new Project on success' do
    result = Project::Operation::Index.(params: {sort_by: :name, order: :desc})

    expect( result.success? ).to eq true
    expect( result[:projects].class ).to eq Array
    expect( result[:projects].first[:name] ).to eq "Zombie Penitentiary"
  end

  it 'creates a new Project on success' do
    result = Project::Operation::Index.(params: {sort_by: :name, order: :desc})
    # byebug
    expect( result.success? ).to eq true
    expect( result[:projects].class ).to eq Array
    expect( result[:projects].first[:tags] ).to eq({"beverages"=>"Paul Masson", "capacity"=>5000, "guards"=>50})
  end
end
