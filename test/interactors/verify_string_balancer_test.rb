require "test_helper"

class VerifyStringBalancerTest < ActionDispatch::IntegrationTest
  def setup
    @subject = VerifyStringBalancer
  end

  def test_it_must_be_balanced_if_strings_is_empty
    result = @subject.call(prompt: "")

    assert result.success?
  end

  def test_it_must_be_balanced_if_string_has_letters_spaces_two_points
   result = @subject.call(prompt: "asdkhfb s df::asas: ")

    assert result.success?
  end

  def test_it_must_be_balanced_if_string_has_parentheses
    result = @subject.call(prompt: "(())(()())")

    assert result.success?
  end

  def test_it_must_be_balanced_if_string_has_emoticons
    result = @subject.call(prompt: ":):(:)")

    assert result.success?
  end

  def test_it_must_be_valid_balanced_or_unbalanced_strings
    assert @subject.call(prompt: "hola").success?
    assert @subject.call(prompt: "(hola)").success?
    assert @subject.call(prompt: "(()").failure?
    assert @subject.call(prompt: "(:)").success?
    assert @subject.call(prompt: "no voy (:()").success?
    assert @subject.call(prompt: "hoy pm: fiesta :):)").success?
    assert @subject.call(prompt: ":((").failure?
    assert @subject.call(prompt: "a (b (c (d) c) b) a :)").success?
    assert @subject.call(prompt: ":(:())").success?
  end
end
