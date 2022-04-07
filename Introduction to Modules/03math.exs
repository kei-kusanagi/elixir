defmodule Math do
  def div(_, 0) do
    {:error, "Cannot divide by zero"}
  end

  def div(x, y) do
    {:ok, "value is #{x/y}" }
  end
end

IO.inspect Math.div(1,0)
IO.inspect Math.div(5,3)
