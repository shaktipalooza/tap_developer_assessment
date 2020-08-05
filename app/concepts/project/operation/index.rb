module Project::Operation
  class Index < Trailblazer::Operation
    step :index

    def index(ctx, params:, **)
      paged = Pagenator.new(Project.all)
      ctx[:projects] = paged.fetch(params)
    end
  end
end
