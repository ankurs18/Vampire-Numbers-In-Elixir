defmodule VampireApp.Main do
  def start(min \\ 100_000, max \\ 200_000) do
    # total_length = max - min + 1
    # no_of_sublists = 128
    # chunk_length = Integer.floor_div(total_length, no_of_sublists)
    chunk_length = 64
    IO.puts("len: #{chunk_length}")

    Enum.chunk_every(Enum.to_list(min..max), chunk_length)
    # |> IO.inspect(label: "list")
    |> Enum.map(fn i -> async_call_square_root(i) end)
    |> Enum.each(fn task -> await_and_inspect(task) end)
  end

  defp async_call_square_root(i) do
    Task.async(fn ->
      :poolboy.transaction(
        :worker,
        fn pid -> GenServer.call(pid, {:find, i}) end,
        # fn pid -> GenServer.cast(pid, {:find, i}) end,
        :infinity
      )
    end)
  end

  defp await_and_inspect(task),
    do: task |> Task.await(:infinity) |> Enum.map(fn {k, v} -> IO.puts("#{k}#{v}") end)
end
