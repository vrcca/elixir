ExUnit.start()

defmodule ManualTest do
  use ExUnit.Case

  defmacrop qtoa(do: code) do
    code = Macro.escape(code)

    quote do
      {:ok, doc} = Code.Formatter.public_quoted_to_algebra(unquote(code), [])

      doc
      |> Inspect.Algebra.format(98)
      |> IO.iodata_to_binary()
    end
  end

  test "it works" do
    assert qtoa(do: 1 + 1) == "1 + 1"
  end
end
