require 'ostruct'

module Merb::AskemHelper

  def flash_delay
    4
  end

  def flash
    if instance_variable_defined? :@flash
      @flash
    else
      f = params[:flash].to_i
      @flash = if f > 0 then f end
    end
  end

  def question
    @question ||=
      begin
        q = Merb::Parse.unescape params[:question]  # must have
        q += '?' if q !~ /([.!?])$/
        q
      end
  end

  def ask
    if instance_variable_defined? :@ask
      @ask
    else
      @ask =
        begin
          r = Merb::Parse.unescape params['ref'] if params['ref']

          # TODO the reference parameter trick
          Ask.first(:question => question, :ref => r)
        end
    end
  end

  def answers
    @answers ||=
      begin
        ans = params[:ans].split('|').collect { |a| a.strip } if params[:ans]

        # TODO the ellipsis trick

        if ans
          scores = if ! ask then { } else
            Hash[ask.replies.aggregate(:answer, :all.count, :answer.in => ans)]
                   end
          ans.collect { |a| [a, scores[a] || 0] }
        else
          if ask
            Hash[ask.replies.aggregate(:answer, :all.count)].sort { |a, b|
                                                                   a[1]<=>b[1] }
          end
        end
      end
  end

  def questions
    @questions ||=
      Reply.aggregate(:ask_id, :all.count, :at.max, :order => [:at.count]).
        collect { |ask_id, reply_count, last_reply_at|
          OpenStruct.new :text => Ask.get!(ask_id).question,
                         :replies => reply_count,
                         :last_at => last_reply_at }

# TODO: DM ticket?        Ask.all(:order => [:replies.count.desc])
  end

  def reply(answer, ref)
    # TODO fill in the reference
    if ! ask
      @ask = Ask.new :question => question
      @ask.save
    end

    @reply = ask.replies.new :answer => answer, :at => Time.now, :ref => ref
    @reply.save
  end

  def skin
    Skin
  end

end
