defmodule ExpressionConverter do
  @moduledoc """
  Documentation for `ExpressionConverter`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> "(+ 1 2)" |> ExpressionConverter.convert
      ["1 + 2"]
      iex> "(sum 1 2)" |> ExpressionConverter.convert
      ["sum(1, 2)"]

  """
  def hello do
    :world
  end

  def convert(input) do
    input
    |> Tokenizer.tokenize()
    |> Parser.parse()
    |> Enum.map(fn x -> Transformer.transform(x) end)
    |> Enum.map(fn x -> Macro.to_string(x) end)
  end
end
