class ProjectSerializer < ActiveModel::Serializer
  attributes :name, :tags, :type, :created_at, :updated_at
end
