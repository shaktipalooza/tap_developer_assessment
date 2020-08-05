require 'rails_helper'

RSpec.describe Project, type: :model do
  fixtures :projects
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  describe 'Portfolio that doesn\'t allow stubbing' do
    let(:project) { Project.first }

    it 'prevents a duplicate name' do
      new_project = Project.new(name: project.name, type: 'A')
      expect(new_project).to_not be_valid
    end
  end
end
