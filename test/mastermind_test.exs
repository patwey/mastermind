defmodule MastermindTest do
  use ExUnit.Case
  doctest Mastermind

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "pick_code chooses a 4 character string of numbers" do
    code = Mastermind.pick_code

    assert String.length(code) == 4
  end

  test "check_guess knows a winning guess" do
    code = "RGBY"
    guess = code

    result = Mastermind.check_guess(guess, code)

    assert result == %{ win: true, colors: 4, positions: 4}
  end

  test "check_guess knows how many colors a guess matches" do
    code = "RGBY"
    guess = "RWPY"

    %{colors: colors} = Mastermind.check_guess(guess, code)

    assert colors == 2
  end
end
