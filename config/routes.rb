Rails.application.routes.draw do
  mount API::Base => '/'
  mount GrapeSwaggerRails::Engine, at: "/documentation"
end
