defmodule Transformer do
  @moduledoc """
  Transforms Lisp AST into Elixir AST
  """
  def transform({:int, x}), do: x

  def transform({:float, x}), do: x

  def transform({:atom, atom}) do
    {atom, [], Elixir}
  end

  def transform({:list, [{:atom, f} | args]}) do
    f_args = args |> Enum.map(fn arg -> transform arg end)

    {f, [], f_args}
  end

  def transform({:quote, x}) do
    x_transformed = transform x
    {:quote, [], x_transformed}
  end

end
