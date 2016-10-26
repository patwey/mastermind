defmodule Mastermind do
  @colors ["R", "G", "B", "Y", "P", "W"]

  def play, do: pick_code |> play
  def play(code) do
    get_guess
    |> check_guess(code)
    |> end_game?(code)
  end

  def end_game?(%{colors: 4, positions: 4}, _), do: IO.puts "You win!"
  def end_game?(%{colors: c, positions: p}, code) do
    IO.puts "Colors: #{c}\nPositions: #{p}\n"
    play(code)
  end

  def pick_code, do: pick_code("", 0)
  def pick_code(code, 4), do: code
  def pick_code(code, count) when count < 4  do
    new_code = code <> rand_color
    pick_code(new_code, String.length(new_code))
  end

  def rand_color do
    Enum.random(@colors)
  end

  def get_guess do
    IO.gets "What is your guess? (colors: #{Enum.join(@colors, ", ")})\n> "
  end

  def check_guess(code, code), do: %{colors: 4, positions: 4}
  def check_guess(guess, code) do
    guess_colors = guess |> String.trim |> String.to_charlist
    code_colors = String.to_charlist(code)

    colors = colors_cnt(guess_colors, code_colors)
    positions = positions_cnt(code_colors, guess_colors)

    %{colors: colors, positions: positions}
  end

  def positions_cnt(guess, code), do: _positions_cnt(guess, code, 0)
  defp _positions_cnt([h|gt], [h|ct], cnt), do: _positions_cnt(gt, ct, cnt + 1)
  defp _positions_cnt([_|gt], [_|ct], cnt), do: _positions_cnt(gt, ct, cnt)
  defp _positions_cnt(_, [], cnt), do: cnt

  def colors_cnt(code, guess), do: _colors_cnt(code, guess, 0)
  defp _colors_cnt([gh|gt], code, cnt) when is_list(code) do
    if Enum.member?(code, gh) do
      code |> List.delete(gh) |> _colors_cnt(gt, cnt + 1)
    else
      _colors_cnt(code, gt, cnt)
    end
  end
  defp _colors_cnt([gh|gt], code, cnt) when is_integer(code) do
    if gh == code do
      cnt + 1
    else
      _colors_cnt(gt, code, cnt)
    end
  end
  defp _colors_cnt([], _, cnt), do: cnt
end
