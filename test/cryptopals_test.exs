defmodule CryptopalsTest do
  use ExUnit.Case
  doctest Cryptopals

  test ".convert/3" do
    hex =
      "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"

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
    {<<key::8>>, decoded} = Cryptopals.single_byte_decrypt(hex, 16)
    assert 0 <= key && key < 256
    assert decoded == "Cooking MC's like a pound of bacon"
  end

  test ".single_byte_decrypt on multiple" do
    {<<key::8>>, decoded} =
      File.stream!(Path.join("inputs", "1-4.txt"))
      |> Enum.map(&String.trim/1)
      |> Enum.map(&Cryptopals.single_byte_decrypt(&1, 16))
      |> Enum.max_by(fn {_key, string} -> CharacterFrequency.text_score(string) end)

    assert 0 <= key && key < 256
    assert decoded == "Now that the party is jumping\n"
  end

  test ".repeating_key_xor" do
    string = "Burning 'em, if you ain't quick and nimble\nI go crazy when I hear a cymbal"

    expected =
      "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f"

    hex = Bytes.encode(string, 16)
    encoded = Cryptopals.repeating_key_xor(hex, 16, "ICE")
    assert encoded == expected
  end
end
