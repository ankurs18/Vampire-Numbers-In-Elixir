defmodule VampireNumber.Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:find, range}, _from, state) do
    # IO.puts("process #{inspect(self())} calculating vampire numbers b/w #{range}")
    {:reply, VampireNumber.Find2.fetch(List.first(range), List.last(range)), state}
  end

  def handle_cast({:find, range}, state) do
    # IO.puts("process #{inspect(self())} calculating vampire numbers b/w #{range}")
    VampireNumber.Find2.fetch(List.first(range), List.last(range))
    {:noreply, state}
  end
end
