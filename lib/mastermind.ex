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
  # check guess -> return correct colors / positions
end
