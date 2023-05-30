defmodule BytesTest do
  use ExUnit.Case
  doctest Bytes

  test ".hamming/2" do
    assert Bytes.hamming("this is a test", "wokka wokka!!!") == 37
  end

  test ".norm/1 when bitstring is one byte" do
    assert Bytes.norm(<<5>>) == 2
  end

  test ".norm/1 when bitstring is multiple bytes" do
    assert Bytes.norm(<<5, 15, 21>>) == 2 + 4 + 3
  end

  test ".norm/1 when given list of bytes" do
    assert Bytes.norm([5, 15, 21]) == 2 + 4 + 3
  end
end
