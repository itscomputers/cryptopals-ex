defmodule Cryptopals do
  @moduledoc """
  Documentation for `Cryptopals`.
  """

  def convert(string, from, to) do
    string |> Bytes.decode(from) |> Bytes.encode(to)
  end

  @spec xor(String.t(), String.t(), integer()) :: String.t()
  def xor(string, other, base) do
    [string, other]
    |> Enum.map(&Bytes.decode(&1, base))
    |> Bytes.xor()
    |> Bytes.encode(base)
  end

  @spec single_byte_xor(String.t(), integer(), integer()) :: String.t()
  def single_byte_xor(string, base, key) do
    string
    |> Bytes.decode(base)
    |> Bytes.repeating_key_xor(<<key::8>>)
    |> Bytes.encode(base)
  end

  @spec single_byte_decrypt(String.t(), integer()) :: {integer(), String.t()}
  def single_byte_decrypt(string, base) do
    string
    |> Bytes.decode(base)
    |> Bytes.single_byte_decrypt()
  end

  @spec repeating_key_xor(String.t(), integer(), String.t()) :: String.t()
  def repeating_key_xor(string, base, key) do
    string
    |> Bytes.decode(base)
    |> Bytes.repeating_key_xor(key)
    |> Bytes.encode(base)
  end
end
