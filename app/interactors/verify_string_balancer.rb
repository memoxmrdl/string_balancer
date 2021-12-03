class VerifyStringBalancer
  include Interactor

  def call
    clean_spaces!
    clean_letters!
    clean_emoticons!
    review_string

    validate!
  end

  private

  def clean_spaces!
    context.prompt.delete!(" ")
  end

  def clean_letters!
    context.prompt.remove!(/[a-z]/)
  end

  def clean_emoticons!
    context.prompt.remove!(/(\:\))|(\:\()|(\(\:\))/)
  end

  def review_string
    context.stack = context.prompt.split("").each_with_object([]) do |chr, memo|
      next if chr == ":"

      if chr == "("
        memo << chr
        next
      end

      memo.length == 0 && (break)

      case chr
      when ")"
        check = memo.pop
        chr == "(" && (break)
      end
    end
  end

  def validate!
    context.fail! unless context.stack.empty?
  end
end
