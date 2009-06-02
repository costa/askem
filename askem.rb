
class Askem < Merb::Controller

  def _template_location(action, type = nil, controller = controller_name)
    controller == "layout" ? "layout.#{action}.#{type}" : "#{action}.#{type}"
  end

  def index

  end

  def show_stats
  end

  def show_image
    content_type :png

    # TODO image caching

    skin.image(question, params['skin']).png(1)
# TODO      comment = 'An Askem question'
# TODO      label = question.statement
  end

  def show_flash
    raise BadRequest unless answer
    # HERE
    answer.statement
  end

end
