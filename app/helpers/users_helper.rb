module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)   # calls hexdigest from the Digest library to create an MD5 hash of user's email address
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"  # acquires gravatar from site using MD5 hash in URL
    image_tag(gravatar_url, alt: user.name, class: "gravatar")  # returns an image tag for the Gravatar with a gravatar CSS class and alt text equal to the user's name
  end
end
