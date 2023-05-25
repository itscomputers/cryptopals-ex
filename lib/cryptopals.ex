defmodule Cryptopals do
  @moduledoc """
  Documentation for `Cryptopals`.
  """

  def convert_to_binary(string, base)
  def convert_to_binary(string, 16), do: Base.decode16!(string, case: :lower)
  def convert_to_binary(string, 64), do: Base.decode64!(string)

  def convert_from_binary(binary, base)
  def convert_from_binary(binary, 16), do: Base.encode16(binary, case: :lower)
  def convert_from_binary(binary, 64), do: Base.encode64(binary)

  def convert(string, from, to) do
    string |> convert_to_binary(from) |> convert_from_binary(to)
  end

  def string_to_bytes(string, base) do
    string
    |> convert_to_binary(base)
    |> :binary.bin_to_list()
  end

  def bytes_to_string(bytes, base) do
    bytes
    |> :binary.list_to_bin()
    |> convert_from_binary(base)
  end

  def byte_wise_xor(left, right) do
    Enum.zip(left, right)
    |> Enum.map(&(Bitwise.bxor(elem(&1, 0), elem(&1, 1))))
  end

  def xor(left, right, base) do
    byte_wise_xor(string_to_bytes(left, base), string_to_bytes(right, base))
    |> bytes_to_string(base)
  end
end
