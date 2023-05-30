defmodule CombinationsTest do
  use ExUnit.Case
  doctest Bytes

  test ".combinations/2" do
    list = ["a", "b", "c", "d"]

    expected =
      [
        {"a", "b"},
        {"a", "c"},
        {"a", "d"},
        {"b", "c"},
        {"b", "d"},
        {"c", "d"}
      ]
      |> MapSet.new()

    combinations = Combinations.combinations(list, 2) |> MapSet.new()
    assert combinations == expected
  end
end
