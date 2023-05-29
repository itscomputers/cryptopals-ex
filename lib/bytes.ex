defmodule Bytes do
  @spec decode(binary(), integer()) :: binary()
  def decode(string, base)
  def decode(string, 16), do: Base.decode16!(string, case: :lower)
  def decode(string, 64), do: Base.decode64!(string, padding: false)

  @spec encode(binary(), integer()) :: binary()
  def encode(binary, base)
  def encode(binary, 16), do: Base.encode16(binary, case: :lower)
  def encode(binary, 64), do: Base.encode64(binary)

  @spec xor(binary(), binary()) :: binary()
  def xor(binary, other) do
    Enum.zip(:binary.bin_to_list(binary), :binary.bin_to_list(other))
    |> Enum.map(&Bitwise.bxor(elem(&1, 0), elem(&1, 1)))
    |> :binary.list_to_bin()
  end

  @spec xor([binary()]) :: binary()
  def xor(_binary_list = [binary, other]), do: xor(binary, other)

  @spec single_byte_xor(binary(), binary()) :: binary()
  def single_byte_xor(binary, key) when byte_size(key) == 1 do
    key
    |> :binary.bin_to_list()
    |> Stream.cycle()
    |> Enum.take(byte_size(binary))
    |> :binary.list_to_bin()
    |> xor(binary)
  end
end
