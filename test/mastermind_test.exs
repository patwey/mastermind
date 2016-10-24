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
end
