defmodule VampireApp.CLI do
  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(args) do
    parse = OptionParser.parse(args, aliases: [h: :help], switches: [help: :boolean])

    case parse do
      {[help: true], _, _} -> :help
      {_, [min, max], _} -> {min, max}
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts("""
    usage: mix run proj1.exs <min> <max>
    """)

    System.halt(0)
  end

  def process({min, max}) do
    # VampireApp.Find.fetch(String.to_integer(min), String.to_integer(max))
    VampireApp.Main.start(String.to_integer(min), String.to_integer(max))
  end
end
