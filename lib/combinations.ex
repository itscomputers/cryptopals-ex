defmodule Combinations do
  def combinations(list, take)

  def combinations(list, 2) do
    indices(length(list), 2)
    |> Enum.map(fn {first, second} -> {Enum.at(list, first), Enum.at(list, second)} end)
  end

  defp indices(size, take)
  defp indices(2, 2), do: [{0, 1}]

  defp indices(size, 2) do
    Enum.concat(
      indices(size - 1, 2),
      0..(size - 2) |> Enum.map(fn i -> {i, size - 1} end)
    )
  end
end
