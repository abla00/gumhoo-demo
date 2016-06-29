module StaticPagesHelper
  
  # Except front page return "container-fluid", others return "container"
  def container_class
    (action_name == 'home' && !logged_in?) ? 'container-fluid' : 'container'
  end
end
