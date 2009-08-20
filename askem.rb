
class Askem < Merb::Controller

  # TODO figure this out
  def _template_location(action, type = nil, controller = controller_name)
    controller == "layout" ? "layout.#{action}.#{type}" : "#{action}.#{type}"
  end

  def index
    render
  end

  def show
    # params:
    #   hui
    #   ref
    #   skin
    #   flash

    case params['hui']
    when 'img'
      content_type :png

      # TODO image caching

      skin.image(question, answers, params['skin']).png(1)
    else
      render
    end
  end

  def ssim_reply
    @answer = skin.answer(question, answers, params[:skin],
                          params[:ssim_x].to_i, params[:ssim_y].to_i)

    raise BadRequest unless request.referer and @answer

    reply @answer, request.referer

    redirect url(:show, :flash => flash_delay)
  end

end
