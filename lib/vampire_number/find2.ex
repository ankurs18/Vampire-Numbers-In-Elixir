defmodule VampireNumber.Find2 do
  def fetch(min, max) do
    list = Enum.to_list(min..max)
    Enum.reduce(list, Map.new(), &isVampire/2)
  end

  defp isVampire(num, map) do
    listOfDigits = Integer.digits(num)
    number_length = length(listOfDigits)

    if rem(number_length, 2) != 0 do
      map
    else
      permutations = generatePermutations(listOfDigits)

      set =
        Enum.reduce(permutations, MapSet.new(), fn x, acc ->
          {a, b} = Enum.split(x, div(number_length, 2))
          num1 = Integer.undigits(a)
          num2 = Integer.undigits(b)

          if num1 < num2 do
            MapSet.put(acc, [num1, num2])
          else
            MapSet.put(acc, [num2, num1])
          end
        end)

      # IO.puts(set)

      res =
        for n <- set do
          a = List.first(n)
          b = List.last(n)

          if checkFangs(num, a, b) do
            [a, b]
          end
        end

      set2 = Enum.reduce(res, MapSet.new(), &reducer/2)
      processed = process(num, set2)

      if processed != nil do
        Map.merge(map, processed)
      else
        map
      end
    end
  end

  defp process(num, result) do
    if MapSet.size(result) > 0 do
      list = MapSet.to_list(result)

      Map.put(
        %{},
        "#{num} ",
        Enum.map_join(list, " ", fn e ->
          [a, b] = e
          "#{a} #{b}"
        end)
      )
    end
  end

  defp reducer(x, set) do
    if x != nil, do: MapSet.put(set, x), else: set
  end

  defp checkFangs(num, a, b) do
    cond do
      rem(a, 10) == 0 and rem(b, 10) == 0 ->
        false

      a * b == num ->
        true

      true ->
        false
    end
  end

  defp generatePermutations([]), do: [[]]

  defp generatePermutations(list),
    do: for(elem <- list, rest <- generatePermutations(list -- [elem]), do: [elem | rest])
end
