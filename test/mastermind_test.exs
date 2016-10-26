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

    assert result == %{colors: 4, positions: 4}
  end

  test "check_guess knows how many colors a guess matches" do
    code = "RGBY"
    guess = "RWPY"

    %{colors: colors} = Mastermind.check_guess(guess, code)

    assert colors == 2
  end

  test "check_guess knows how many positions a guess matches" do
    code = "RGBY"
    guess = "YGBR"

    %{positions: positions} = Mastermind.check_guess(guess, code)

    assert positions == 2
  end

  test "check_guess knows how many colors and positions a guess matches" do
    code = "RGBY"
    guess = "YGBR"

    %{colors: colors, positions: positions} = Mastermind.check_guess(guess, code)

    assert positions == 2
    assert colors == 4
  end

  test "positions_cnt knows how many positions match in two charlists" do
    code = 'RGBY'
    guess = 'RYBW'

    assert Mastermind.positions_cnt(guess, code) == 2
  end

  test "colors_cnt counts the number of correct colors" do
    code = 'RGGY'
    guess = 'GGGG'

    assert Mastermind.colors_cnt(guess, code) == 2
  end
end
