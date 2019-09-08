defmodule VampireNumber.CLI do
  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  defp parse_args(args) do
    parse = OptionParser.parse(args, aliases: [h: :help], switches: [help: :boolean])

    case parse do
      {[help: true], _, _} -> :help
      {_, [min, max], _} -> {min, max}
      _ -> :help
    end
  end

  defp process(:help) do
    IO.puts("""
    Usage: mix run proj1.exs <min> <max>
    """)

    System.halt(0)
  end

  defp process({min, max}) do
    min = String.to_integer(min)
    max = String.to_integer(max)

    if(max < min) do
      IO.puts("""
        Error: Bad range entered 
        Usage: mix run proj1.exs <min> <max>
      """)

      System.halt(0)
    else
      # IO.inspect VampireNumber.Find2.fetch(String.to_integer(min), String.to_integer(max))
      VampireNumber.Main.start(min, max)
    end
  end
end
