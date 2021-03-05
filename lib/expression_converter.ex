defmodule ExpressionConverter do
  @moduledoc """
  Documentation for `ExpressionConverter`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ExpressionConverter.hello()
      :world

  """
  def hello do
    :world
  end

  def convert(input) do
    input
    |> Tokenizer.tokenize
    |> Parser.parse
    |> Enum.map(fn x -> Transformer.transform x end)
    |> Enum.map(fn x -> Macro.to_string x end)
  end
end
