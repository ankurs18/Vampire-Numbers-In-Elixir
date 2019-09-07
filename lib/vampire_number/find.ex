defmodule VampireNumber.Find do
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
      res =
        for n <- generatePermutations(listOfDigits) do
          {a, b} = Enum.split(n, div(number_length, 2))

          if checkFangs(num, a, b) do
            num1 = Integer.undigits(a)
            num2 = Integer.undigits(b)

            if num1 < num2 do
              [num1, num2]
            else
              [num2, num1]
            end
          end
        end

      set = Enum.reduce(res, MapSet.new(), &reducer/2)
      processed = process(num, set)

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
      List.first(a) == 0 or List.first(b) == 0 ->
        false

      List.last(a) == 0 and List.last(b) == 0 ->
        false

      Integer.undigits(a) * Integer.undigits(b) == num ->
        true

      true ->
        false
    end
  end

  defp generatePermutations([]), do: [[]]

  defp generatePermutations(list),
    do: for(elem <- list, rest <- generatePermutations(list -- [elem]), do: [elem | rest])
end
