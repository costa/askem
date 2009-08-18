
=begin

                          size
+-----------------------+
| Question?     |       |
|       |       |       |
|  Yes  |  No   | Maybe |
+-----------------------+

=end

class Skin
  include GD2

  class << self

    # TODO move it elsewhere?
    def question_max; 256 end
    def answer_max; 16 end
    def max_answers; 16 end

    # TODO user-replied answer indication
    def image(question, answers, style_s)
      skin = Skin.new question, answers, style_s
      skin.render
    end

    def answer(question, answers, style_s, x, y)
      skin = Skin.new question, answers, style_s
      x2 = -1
      vis_ans = answers.first max_answers
      vis_ans.each_with_index do |ans, i|
        x1 = x2+1
        x2 = skin.width * (i + 1) / vis_ans.size - 1
        return ans[0] if (x1..x2) === x and (0...skin.height) === y
      end
      nil  # TODO report that dashed each* bug?
    end

    def question_font
      @qfont ||= GD2::Font::TrueType['Helvetica', 18]
    end

    def answer_font(ratio)
      (@afonts ||= {})[ratio]||= GD2::Font::TrueType['Helvetica',
                                                     0.5*(2*(8+28*ratio)).round]
    end

  end


  attr_reader :width
  def height; @question_height + @answer_height; end


  def initialize(question, answers, s)
    # TODO make 'style' a CSS-style-coded param
    # NOTE historical dead code below

    @question = question
    @answers = answers[0...self.class.max_answers]

    # TODO the ellipsis trick

    qbr = Rectangle.new question_font.bounding_rectangle(@question)
    abr = @answers.inject(Rectangle.new) do |br, ans|
      br.expand! self.class.answer_font(1).
        bounding_rectangle answer_format(ans[0])
      br
    end
#    qbr.e += 2*margin
#    qbr.s = 0
#    qbr.w = 0
#    qbr.n -= 2*margin
#    abr.e = @answers.size * (abr.e + 2*margin)
#    abr.s = 0
#    abr.w = 0
#    abr.n -= 2*margin
#    @width = max(qbr.e, abr.e)
#    @height = -(qbr.n + abr.n)
##    abr.tile! :e, @answers.size, 2*margin
##    abr.dock! :s, qbr, :n, 2*margin
##    qbr.expand! abr
##    qbr.grow!(margin)
##    @width = qbr.width
##    @height = qbr.height

    @width = max(qbr.e + 2*margin, @answers.size * (abr.e + 2*margin))
    @question_height = -qbr.n + 2*margin
    @answer_height = -abr.n + 2*margin
  end

  def name
    "#{self.class}@#{@question.hash.abs.to_s(16)}-#{question_font}-"
    # TODO +++
  end

  def render
    tot = @answers.inject(0) { |s, a| a[1] + s }
    pad = max(0, 2 - tot / @answers.size) # TODO think of the 2
    tot += pad * @answers.size

    image = Image.new self.width, self.height
     # TODO preset and custom image loading
    image.save_alpha = true
    image.draw do |pen|
#      pen.anti_aliasing = true
      x2 = -1
      @answers.each_with_index do |ans, i|
        image.alpha_blending = false
        pen.color = answer_background(i, ans[0])
        x1 = x2+1
        x2 = width * (i + 1) / @answers.size - 1
        pen.rectangle x1, 0, x2, self.height-1, true
        pen.color = answer_color i, ans[0]
        pen.font = answer_font((ans[1] + pad).to_r / tot)
        br = Rectangle.new pen.font.bounding_rectangle answer_format(ans[0])
        pen.move_to(x1 + (x2-x1-br.e)/2, self.height - (@answer_height+br.n)/2)
        image.alpha_blending = true
        pen.text answer_format(ans[0])
      end
      image.alpha_blending = false
      pen.color = question_color
      pen.font = question_font
      pen.move_to margin, @question_height - margin
      image.alpha_blending = true
      pen.text question_format
    end
  end

protected

  def margin; 11; end

  def question_color
    Color::BLACK
  end

  def question_font
    self.class.question_font
  end

  def question_format
    @question.truncate self.class.question_max
  end

  def answer_color(i, answer)
    Color::BLACK
  end

  def answer_background(i, answer)
    h = answer.hash.abs
    Color[RGB_MAX/2 + h * 389 % RGB_MAX/2,
          RGB_MAX/2 + h * 631 % RGB_MAX/2,
          RGB_MAX/2 + h * 883 % RGB_MAX/2, 0.25]
  end

  def answer_font(ratio)
    self.class.answer_font ratio
  end

  def answer_format(s)
    s.truncate self.class.answer_max
  end

  def answer_position(i, answer)
  end

end
