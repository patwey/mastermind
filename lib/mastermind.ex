defmodule Mastermind do
  @colors ["R", "G", "B", "Y", "P", "W"]

  # pick code
  def pick_code do
    pick_code("", 0)
  end

  def pick_code(code, count) when count < 4  do
    new_code = code <> rand_color
    pick_code(new_code, String.length(new_code))
  end

  def pick_code(code, count) when count == 4, do: code

  def rand_color do
    Enum.random(@colors)
  end

  # get guess
  def get_guess do
    IO.gets "What is your guess?\n> "
  end

  # check guess -> return correct colors / positions
  def check_guess(code, code) do
    %{win: true, colors: 4, positions: 4}
  end

  def check_guess(guess, code) do
    guess_colors = String.to_charlist(guess)
    code_colors = String.to_charlist(code)

    colors = Enum.count(guess_colors, fn(c) -> Enum.member?(code_colors, c) end)
    positions = 0

    %{win: false, colors: colors, positions: positions}
  end
end
