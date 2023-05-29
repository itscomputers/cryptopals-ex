defmodule Cryptopals do
  @moduledoc """
  Documentation for `Cryptopals`.
  """
# @hex_chars 0..15
# |> Enum.map(fn i -> Integer.to_string(i, 16) end)
# |> Enum.map(&(String.downcase(&1)))

# @base64_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
# |> String.split("", trim: true)

  def convert(string, from, to) do
    string |> Bytes.decode(from) |> Bytes.encode(to)
  end

  @spec xor(String.t(), String.t(), integer()) :: String.t()
  def xor(string, other, base) do
    [string, other]
    |> Enum.map(&(Bytes.decode(&1, base)))
    |> Bytes.xor()
    |> Bytes.encode(base)
  end

  @spec single_byte_xor(String.t(), integer(), integer()) :: String.t()
  def single_byte_xor(string, base, key) do
    string
    |> Bytes.decode(base)
    |> Bytes.single_byte_xor(<<key::8>>)
    |> Bytes.encode(base)
  end

  def single_byte_decrypt(string, base) do
    0..255
    |> Enum.map(fn key -> {key, single_byte_xor(string, base, key)} end)
    |> Enum.map(fn {key, string} -> {key, Bytes.decode(string, base)} end)
    |> Enum.map(fn {key, binary} -> {key, to_string(binary)} end)
    |> Enum.max_by(fn {_key, string} -> CharacterFrequency.text_score(string) end)
  end
end

