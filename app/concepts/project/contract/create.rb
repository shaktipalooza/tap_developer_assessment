module Project::Contract
  class Create < Reform::Form
    property :name
    property :type
    property :tags

    validates :name,  length: 1..36, presence: true
    validates :type, inclusion: { in: %w(A B C), message: "not a valid type" }
  end
end
