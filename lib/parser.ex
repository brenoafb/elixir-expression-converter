defmodule Parser do
  @moduledoc """
  Parser of Lisp expressions
  """

  @doc """
  Parse a list of tokens.
  Convert the list of tokens to an AST.

  ## Examples

    iex> "(hello (world))" |> Tokenizer.tokenize |> Parser.parse
    [list: [atom: :hello, list: [atom: :world]]]

  """
  def parse([]), do: []

  def parse(tokens) do
    case next(tokens) do
      {:error, _message} = e -> e
      {parsed, remaining} -> [parsed | parse remaining]
    end
  end

  @doc """
  Try to read a single token to an AST element
  And return it along with the remaining tokens.
  """
  defp next([]), do: {[], []}

  defp next(["(" | tail]) do
    {tokens, remaining} = collect_tokens(tail)
    {{:list, tokens}, remaining}
  end

  defp next([")" | _tail]) do
    {:error, "unmatched ')'"}
  end

  defp next(["\"" | tail]) do
    {string_tokens, [_p | remaining]} =
      tail |> Enum.split_while(fn x -> x != "\"" end)

    string = string_tokens |> Enum.join(" ")

    {{:string, string}, remaining}
  end

  defp next(["'" | tail]) do
    {element, remaining} = next(tail)
    {{:quote, element}, remaining}
  end

  defp next([token | tail]) do
    {(get_element token), tail}
  end

  @doc """
  Collect tokens from a parenthesized list into an AST list element
  """
  defp collect_tokens([")" | tail]), do: {[], tail}

  defp collect_tokens(["(" | _tail] = tokens) do
    {list, remaining} = next(tokens)
    {tokens, remaining1} = collect_tokens(remaining)
    {[list | tokens], remaining1}
  end

  defp collect_tokens(tokens) do
    {element, remaining} = next(tokens)
    {elements, remaining1} = collect_tokens(remaining)

    {[element | elements], remaining1}
  end

  @doc """
  Try to convert a token into an AST float, int, or atom.
  """
  defp get_element(token) do
    try do
      float = token |> String.to_float
      {:float, float}
    rescue
      ArgumentError -> try do
        int = token |> String.to_integer
        {:int, int}
      rescue
        ArgumentError -> {:atom, String.to_atom token}
      end

    end
  end

end
