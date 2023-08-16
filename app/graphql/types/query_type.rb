module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

     # /users
    field :users, [Types::UserType], null: false,
      description: "All Users"

    def users
      User.all
    end

    # /user/:id
    field :user, Types::UserType, null: false,
      description: "Fetch speccfic user" do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new('User does not exist.')
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
    end

    # /posts
    field :posts, [Types::PostType], null: false,
      description: "All posts"
    def posts
      Post.all
    end

    #/posts/:id
    field :post, Types::PostType, null: false,
      description: "Show specific post" do
      argument :id, ID, required:true
    end

    def post(id:)
      Post.find(id)
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new("Post doesn't exist")
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
