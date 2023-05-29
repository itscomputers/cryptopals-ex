defmodule CryptopalsTest do
  use ExUnit.Case
  doctest Cryptopals

  test ".convert/3" do
    hex = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    expected = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    assert Cryptopals.convert(hex, 16, 64) == expected
    assert Cryptopals.convert(expected, 64, 16) == hex
  end

  test ".xor/3" do
    hex = "1c0111001f010100061a024b53535009181c"
    other = "686974207468652062756c6c277320657965"
    xor = Cryptopals.xor(hex, other, 16)
    assert xor == "746865206b696420646f6e277420706c6179"
    assert Bytes.decode(other, 16) |> to_string() == "hit the bull's eye"
    assert Bytes.decode(xor, 16) |> to_string() == "the kid don't play"
  end

  test ".single_byte_decrypt" do
    hex = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
    {key, decoded} = Cryptopals.single_byte_decrypt(hex, 16)
    assert 0 <= key && key < 256
    assert decoded == "Cooking MC's like a pound of bacon"
  end
end
