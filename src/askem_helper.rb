
module Merb::AskemHelper

  def question
    q = Merb::Parse.unescape params[:question]  # must have
    @question ||= Question.new(q + (q !~ /([.!?])$/ ? '?' : ''),
      (params[:ans].split('|').collect { |a| a.strip } if params[:ans]))
    # TODO other punctuation (Japanese?)
  end

  def answer
    @answer ||=
      skin.answer(question, params[:skin],
                  params[:ssim_x].to_i, params[:ssim_y].to_i)
  end

  def skin
    Skin
  end

end
