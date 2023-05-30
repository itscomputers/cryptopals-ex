defmodule RepeatingKeyXorDecoder do
  def decode(binary) do
    binary
    |> RepeatingKeyXorDecoder.optimal_key_size(4, 40)
    |> RepeatingKeyXorDecoder.decode_key(binary)
    |> repeating_key_xor(binary)
  end

  def repeating_key_xor(key, binary), do: Bytes.repeating_key_xor(binary, key)

  def decode_key(key_size, binary) do
    binary
    |> transpose_chunks(key_size)
    |> Enum.map(&Bytes.single_byte_decrypt/1)
    |> Enum.map(&elem(&1, 0))
    |> :binary.list_to_bin()
  end

  def optimal_key_size(binary, chunk_count, max_key_size) do
    2..max_key_size
    |> Enum.min_by(&key_size_score(binary, &1, chunk_count))
  end

  defp transpose_chunks(binary, chunk_size) do
    binary
    |> :binary.bin_to_list()
    |> Enum.chunk_every(chunk_size, chunk_size, Stream.cycle([0]))
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&:binary.list_to_bin/1)
  end

  defp key_size_score(binary, key_size, chunk_count) do
    compute_score = fn dist -> dist / (key_size * chunk_count) end

    binary
    |> :binary.bin_to_list()
    |> Enum.chunk_every(key_size)
    |> Enum.take(chunk_count)
    |> Combinations.combinations(2)
    |> Enum.map(&get_hamming/1)
    |> Enum.sum()
    |> compute_score.()
  end

  defp get_hamming({chunk, other}) do
    Bytes.hamming(
      :binary.list_to_bin(chunk),
      :binary.list_to_bin(other)
    )
  end
end
