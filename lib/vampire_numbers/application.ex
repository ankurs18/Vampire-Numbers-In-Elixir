defmodule VampireNumber.Application do
  use Application

  defp poolboy_config do
    [
      {:name, {:local, :worker}},
      {:worker_module, VampireNumber.Worker},
      {:size, 128},
      {:max_overflow, 0}
    ]
  end

  def start(_type, _args) do
    children = [
      :poolboy.child_spec(:worker, poolboy_config())
    ]

    opts = [strategy: :one_for_one, name: VampireNumber.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
