defmodule CharacterFrequency do
  @text_frequencies %{
    " " => 25000,
    "a" => 8200,
    "b" => 1500,
    "c" => 2800,
    "d" => 4300,
    "e" => 13000,
    "f" => 2200,
    "g" => 2000,
    "h" => 6100,
    "i" => 7000,
    "j" => 150,
    "k" => 770,
    "l" => 4000,
    "m" => 2400,
    "n" => 6700,
    "o" => 7500,
    "p" => 1900,
    "q" => 95,
    "r" => 6000,
    "s" => 6300,
    "t" => 9100,
    "u" => 2800,
    "v" => 980,
    "w" => 2400,
    "x" => 150,
    "y" => 2000,
    "z" => 74,
  }

  def text_score(text) do
    text
    |> String.split("", trim: true)
    |> Enum.map(fn c -> Map.get(@text_frequencies, c, 0) end)
    |> Enum.sum()
  end
end
