defmodule VampireNumber.Application do
  use Application

  def start(_type, _args) do
    children = [
      {DynamicSupervisor, strategy: :one_for_one, name: VampireNumber.Supervisor}
    ]

    # opts = [strategy: :one_for_one, name: VampireNumber]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
