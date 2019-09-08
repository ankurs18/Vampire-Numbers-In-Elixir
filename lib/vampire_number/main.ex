defmodule VampireNumber.Main do
  def start(min \\ 100_000, max \\ 200_000) do
    total_length = max - min + 1
    no_of_sublists = System.schedulers_online() * 2
    chunk_length = Integer.floor_div(total_length, no_of_sublists)
    range_list = Enum.to_list(min..max)
    if chunk_length > 0 do
      Enum.chunk_every(range_list, chunk_length)
    else
      [range_list]
    end
    |> Enum.map(fn range -> start_processing(range) end)
    |> Enum.each(fn pid -> print_output(pid) end)
  end

  defp start_processing(range) do
    {:ok, pid} = VampireNumber.Supervisor.start_worker()
    GenServer.cast(pid, {:find, range})
    pid
  end

  defp print_output(pid),
    do:
      pid |> GenServer.call({:fetch}, :infinity) |> Enum.map(fn {k, v} -> IO.puts("#{k}#{v}") end)
end
