defmodule CryptopalsTest do
  use ExUnit.Case
  doctest Cryptopals

  test ".hex_to_base_64" do
    hex = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    expected = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    assert Cryptopals.convert(hex, 16, 64) == expected
  end

  test ".xor" do
    hex = "1c0111001f010100061a024b53535009181c"
    other = "686974207468652062756c6c277320657965"
    xor = Cryptopals.xor(hex, other, 16)
    assert xor == "746865206b696420646f6e277420706c6179"
    [other, xor] |> Enum.map(&(Cryptopals.string_to_bytes(&1, 16))) |> Enum.map(&(IO.inspect(&1)))
  end
end
