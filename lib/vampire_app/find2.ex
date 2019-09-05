defmodule VampireApp.Find2 do
  def fetch(min, max) do
    list = Enum.to_list(min..max)
    # Enum.map(list, &isVampire/1)
    Enum.reduce(list, Map.new(), &isVampire/2)
  end

  def isVampire(num, map) do
    listOfDigits = Integer.digits(num)
    number_length = length(listOfDigits)

    if rem(number_length, 2) != 0 do
      map
    else
      fangs_set1 = MapSet.new()

      res =
        for n <- generatePermutations(listOfDigits) do
          fangs_set2 = MapSet.new()
          {a, b} = Enum.split(n, div(number_length, 2))

          fangs_set =
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
      # IO.inspect(set)
      processed = process(num, set)

      if processed != nil do
        Map.merge(map, processed)
      else
        map
      end
    end
  end

  def process(num, result) do
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

  def reducer(x, set) do
    if x != nil, do: MapSet.put(set, x), else: set
  end

  def display(num, x) do
    if x != nil do
      [a, b] = x
      IO.puts("#{num} #{a} #{b}")
    else
    end
  end

  def checkFangs(num, a, b) do
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
