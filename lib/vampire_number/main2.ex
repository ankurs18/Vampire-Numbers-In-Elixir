defmodule VampireNumber.Main2 do
  def start(min \\ 100_000, max \\ 200_000) do
    total_length = max - min + 1
    no_of_sublists = System.schedulers_online() * 2
    # no_of_sublists = System.schedulers_online * 2
    chunk_length = Integer.floor_div(total_length, no_of_sublists)
    # chunk_length = 128
    # IO.puts("len: #{chunk_length}")

    Enum.to_list(min..max)
    |> Enum.chunk_every(chunk_length)
    # |> IO.inspect(label: "list")
    |> Enum.map(fn i -> genserver_async_call(i) end)
    |> Enum.each(fn task -> await_and_inspect(task) end)

    # |> Enum.map(fn i -> genserver_call(i) end)
    # |> Enum.each(fn task -> print(task) end)
  end

  defp genserver_async_call(i) do
    Task.async(fn ->
      {:ok, pid} = VampireNumber.Supervisor.start_worker()
      x = GenServer.call(pid, {:find, i}, :infinity)
      # IO.inspect(x, label: "list")
      x
    end)
  end

  defp genserver_call(i) do
    {:ok, pid} = VampireNumber.Supervisor.start_worker()
    GenServer.cast(pid, {:find, i})
    pid
  end

  defp await_and_inspect(task),
    do: task |> Task.await(:infinity) |> Enum.map(fn {k, v} -> IO.puts("#{k}#{v}") end)

  defp print(pid),
    do:
      pid |> GenServer.call({:fetch}, :infinity) |> Enum.map(fn {k, v} -> IO.puts("#{k}#{v}") end)

  # do: task |> Enum.map(fn {k, v} -> IO.puts("#{k}#{v}") end)
end
