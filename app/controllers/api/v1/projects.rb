# encoding utf-8
module API
  module V1
    class Projects < Grape::API
      include API::V1::Defaults

      resource :project do
        ## INDEX
        desc 'Returns All Projects'
        params do
          optional :page, type: Integer, desc: "Page", default: 0
          optional :per, type: Integer, desc: "Results Per Page", default: 10
          optional :sort_by, type: Symbol, desc: "Sort Attribute", values: [:name, :tags, :type], default: :name
          optional :order, type: String, desc: "Sort Order", values: ['asc','desc'], default: 'asc'
        end
        get "", root: :project do
          result = Project::Operation::Index.(params: permitted_params)
          present :page, params[:page]
          present :per_page, params[:per]
          present :sort_by, params[:sort_by]
          present :order, params[:order]
          present :projects, result[:projects], with: Entity::Project
        end

        ## CREATE
        desc 'Creates a new Project'
        params do
          requires :name, type: String, desc: "Name"
          optional :tags, type: JSON, desc: "Tags"
          optional :type, type: String, desc: "STI Type", values: ['A','B','C'], coerce_with: ->(val) { val.upcase }
        end
        post "", root: :project do
          result = Project::Operation::Create.(params: permitted_params)
          if result.success?
            present :project, result[:model], with: Entity::Project
          else
            present :errors, result[:"result.contract.default"].errors
          end
        end
      end
    end
  end
end
