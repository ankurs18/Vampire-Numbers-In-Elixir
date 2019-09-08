defmodule VampireNumber.Worker do
  use GenServer

  def start_link(range) do
    GenServer.start_link(__MODULE__, range, [])
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:find, range}, _state) do
    {:noreply, VampireNumber.Find.fetch(List.first(range), List.last(range))}
  end

  def handle_call({:fetch}, _from, state) do
    {:reply, state, state}
  end
end
