# ExpressionConverter

Convert Lisp's parenthesized expressions into Elixir expressions.

```elixir
❯ iex -S mix
Erlang/OTP 23 [erts-11.1.7] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe]

Interactive Elixir (1.11.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> ExpressionConverter.convert "(+ 1 2) (sum 1 2)"
["1 + 2", "sum(1, 2)"]
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `expression_converter` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:expression_converter, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/expression_converter](https://hexdocs.pm/expression_converter).

