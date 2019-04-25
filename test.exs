ExUnit.start()

defmodule X do
  def ast_to_string(ast) do
    ast
    |> Code.Formatter.public_quoted_to_algebra([])
    |> (fn {:ok, doc} -> doc end).()
    |> Inspect.Algebra.format(98)
    |> IO.iodata_to_binary()
  end
end

defmodule Test do
  use ExUnit.Case

  import X

  test "keyword lists" do
    ast = quote(do: [a: :b])

    assert ast_to_string(ast) == "[a: :b, c: :d]"
  end

  # test "do: blocks with non keywords" do
  #   ast =
  #     quote do
  #       foo(do: :ok, else: :error, dio: :can)
  #     end

  #   assert ast_to_string(ast) == "foo(:do => :ok, :else => :error, :dio => :can)"
  # end

  # test "do/end blocks with different keywords" do
  #   ast =
  #     quote do
  #       foo do
  #         :ok
  #       end
  #     end

  #   assert ast_to_string(ast) == """
  #          foo do
  #            :ok
  #          end\
  #          """

  #   ast =
  #     quote do
  #       foo do
  #         :ok
  #       else
  #         :error
  #       catch
  #         :caught
  #       end
  #     end

  #   assert ast_to_string(ast) == """
  #          foo do
  #            :ok
  #          else
  #            :error
  #          catch
  #            :caught
  #          end\
  #          """
  # end
end
