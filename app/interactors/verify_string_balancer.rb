class VerifyStringBalancer
  include Interactor

  def call
    validate_balance
  end

  private

  def validate_balance
    context.left = 0
    context.right = 0
    context.smile = 0
    context.sad = 0
    context.pre = ""

    context.prompt.split("").each do |chr|
      if chr == ")"
        if context.pre == ":"
          context.smile += 1
        else
          context.right += 1

          if context.right > (context.left + context.sad)
           context.fail!
           break
          end
        end
      elsif chr == "("
        if context.pre == ":"
          context.sad += 1
        else
          context.left += 1
        end
      end

      context.pre = chr
    end

    context.fail! if context.left > (context.right + context.smile)
  end
end
