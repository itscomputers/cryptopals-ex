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

  @spec single_byte_decrypt(binary()) :: {binary(), binary()}
  def single_byte_decrypt(binary) do
    0..255
    |> Enum.map(&{<<&1::8>>, binary})
    |> Enum.map(fn {key, binary} -> {key, repeating_key_xor(binary, key)} end)
    |> Enum.max_by(fn {_key, binary} -> CharacterFrequency.text_score(binary) end)
  end

  @spec repeating_key_xor(binary(), binary()) :: binary()
  def repeating_key_xor(binary, key) do
    key
    |> :binary.bin_to_list()
    |> Stream.cycle()
    |> Enum.take(byte_size(binary))
    |> :binary.list_to_bin()
    |> xor(binary)
  end

  @spec hamming(binary(), binary()) :: integer()
  def hamming(binary, other) do
    xor(binary, other)
    |> norm()
  end

  @spec hamming({binary(), binary()}) :: integer()
  def hamming({binary, other}), do: hamming(binary, other)

  @spec norm(bitstring()) :: integer()
  @spec norm([integer()]) :: integer()
  def norm(bitstring) when byte_size(bitstring) == 1 do
    0..7
    |> Enum.count(&is_one?(bitstring, &1))
  end

  def norm(byte_list) when is_list(byte_list) do
    byte_list
    |> :binary.list_to_bin()
    |> norm()
  end

  def norm(bitstring) do
    <<byte, remaining::binary>> = bitstring
    norm(<<byte>>) + norm(remaining)
  end

  defp is_one?(bitstring, position) do
    Bitwise.band(2 ** position, :binary.decode_unsigned(bitstring)) != 0
  end
end
