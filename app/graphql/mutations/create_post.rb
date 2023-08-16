class Mutations::CreatePost < Mutations::BaseMutation
  # Define what argument this mutation accepts
  argument :title, String, required: true
  argument :description, String, required: true

  # Define what type of value to be returned
  field :post, Types::PostType, null: false
  field :errors, [String], null: false

  def resolve(title:, description:)
    # we will use current_user in future
    post = context[:current_user].posts.new(title: title, description: description)
    # Here returns post field, which is defined above.
    if post.save
      {
        post: post,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        post: nil,
        errors: post.errors.full_messages
      }
    end
  end
end