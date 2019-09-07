defmodule VampireNumber.Worker do
  use GenServer

  def start_link(range) do
    GenServer.start_link(__MODULE__, range, [])
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:find, range}, _from, state) do
    # IO.puts("process #{inspect(self())} calculating vampire numbers b/w #{range}")
    {:reply, VampireNumber.Find.fetch(List.first(range), List.last(range)), state}
  end

  def handle_call({:fetch}, _from, state) do
    # IO.puts("process #{inspect(self())} calculating vampire numbers b/w #{range}")
    {:reply, VampireNumber.Find.fetch(List.first(state), List.last(state)), state}
  end

  def handle_cast({:find, range}, state) do
    # IO.puts("process #{inspect(self())} calculating vampire numbers b/w #{range}")
    # IO.puts("Here")

    # IO.inspect()
    task = Task.async(fn -> VampireNumber.Find.fetch(List.first(range), List.last(range)) end)
    Task.await(task, :infinity) |> Enum.map(fn {k, v} -> IO.puts("#{k}#{v}") end)
    {:noreply, state}
  end
end
