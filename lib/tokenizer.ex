defmodule Tokenizer do
  @moduledoc """
  Tokenizer for parenthesized lists
  """
  @doc """
  Tokenize a parenthesized list.

  ## Examples

    iex> "(hello (world))" |> Tokenizer.tokenize
    ["(", "hello", "(", "world", ")", ")"]

  """

  def tokenize(input) do
    special_chars
    |> Enum.map(fn c -> {c, " " <> c <> " "} end)
    |> Enum.reduce(input, fn {c, r}, acc -> String.replace(acc, c, r) end)
    |> String.split
  end

  defp special_chars, do: ["(", ")", "'", "\""]
end
