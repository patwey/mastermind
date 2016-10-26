defmodule Mastermind do
  @colors ["R", "G", "B", "Y", "P", "W"]

  def play, do: pick_code |> play(10)
  def play(code, guesses) do
    get_guess
    |> check_guess(code, guesses)
    |> end_game?(code)
  end

  def play_again? do
    response = IO.gets("Play again? (y/n)\n> ") |> String.trim

    case response do
      "y" -> play
      "n" -> IO.puts "Thanks for playing!"
      _ -> play_again?
    end
  end

  def end_game?(%{positions: 4}, code) do
     IO.puts "You win! The code was: #{code}!\n"
     play_again?
  end
  def end_game?(%{positions: p, guesses: 0}, code) when p < 4 do
    IO.puts "\nGame Over! The code was: #{code}\n"
    play_again?
  end
  def end_game?(%{colors: c, positions: p, guesses: g}, code) do
    IO.puts "Colors: #{c}\nPositions: #{p}\nRemaining Guesses: #{g}\nCode: #{code}"
    play(code, g)
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
    IO.gets("What is your guess? (colors: #{Enum.join(@colors, ", ")})\n> ")
      |> String.trim
  end

  def check_guess(code, code, _), do: %{colors: 4, positions: 4}
  def check_guess(guess, code, guesses) when byte_size(guess) != 4 do
    IO.puts "\nGuesses must be 4 colors long, please guess again."
    get_guess |> check_guess(code, guesses)
  end
  def check_guess(guess, code, guesses) do
    guess_colors = String.to_charlist(guess)
    code_colors = String.to_charlist(code)

    colors = colors_cnt(guess_colors, code_colors)
    positions = positions_cnt(code_colors, guess_colors)

    %{colors: colors, positions: positions, guesses: guesses - 1}
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
