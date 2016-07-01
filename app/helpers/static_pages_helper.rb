module StaticPagesHelper
  
  # Except front page return "container-fluid", others return "container"
  def container_class(container)
    return 'container' if container.blank?
    return 'container-fluid'
  end
end
