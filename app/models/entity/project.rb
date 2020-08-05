
# encoding: utf-8
module Entity
  class Project < Base
    expose :name, documentation: {type: "string", desc: "Name"}, format_with: :to_string
    expose :tags, documentation: {type: "JSON", desc: "Tags"}
    expose :type, documentation: {type: "enum", desc: "Type (a,b,c)"}

    with_options(format_with: :to_date_string) do
      expose :created_at, documentation: {type: "DateTime", desc: "Project created at "}
      expose :updated_at, documentation: {type: "DateTime", desc: "Project updated at "}
    end
  end
end
