class Comment::Contract::Update < BaseContract
  property :content

  validation do
    required(:content).filled
  end
end