defmodule VampireApp.Application do
  use Application

  defp poolboy_config do
    [
      {:name, {:local, :worker}},
      {:worker_module, VampireApp.Worker},
      {:size, 128},
      {:max_overflow, 0}
    ]
  end

  def start(_type, _args) do
    children = [
      :poolboy.child_spec(:worker, poolboy_config())
    ]

    opts = [strategy: :one_for_one, name: VampireApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
