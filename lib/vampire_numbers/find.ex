defmodule VampireNumber.Find do
  def fetch(min, max) do
    list = Enum.to_list(min..max)
    Enum.map(list, &isVampire/1)
  end

  def isVampire(num) do
    listOfDigits = Integer.digits(num)
    number_length = length(listOfDigits)

    if rem(number_length, 2) != 0 do
      0
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

              # if num1 < num2, do: fangs_set = MapSet.put(fangs_set, [num1,num2]), else: fangs_set = MapSet.put(fangs_set, [num2, num1])
              if num1 < num2 do
                [num1, num2]
                # MapSet.put(fangs_set, [num1,num2])
              else
                [num2, num1]
                # MapSet.put(fangs_set, [num2,num1])
              end
            end

          # MapSet.put(fangs_set2, fangs_set)
          # IO.puts("this #{MapSet.size(fangs_set)}")
          # if checkFangs(num,a,b), do: IO.puts ({num, a, b})
          # MapSet.union(fangs_set, checkFangs(num,a,b))
        end

      # IO.puts(res)
      process(num, res)
      # fangs_set1 = MapSet.new()
      # MapSet.union(fangs_set1, res)
      # IEx.Info.info(res)
      # if MapSet.size(fangs_set) > 0, do: IO.puts "#{num} #{MapSet.to_list(fangs_set)}"
    end
  end

  def process(num, result) do
    # Enum.map(result, fn x ->
    #   if x != nil do
    #     [a, b] = x
    #     IO.puts("#{num} #{a} #{b}")
    #     # "#{num} #{a} #{b}"
    #   end
    # end)

    set = Enum.reduce(result, MapSet.new(), &reducer/2)
    # IO.puts("siZe: #{MapSet.size(set)}")

    if MapSet.size(set) > 0 do
      IO.write("#{num}")
      list = MapSet.to_list(set)
      # IO.puts("len: #{length(list)}")
      Enum.map(list, fn e ->
        [a, b] = e
        IO.write(" #{a} #{b}")
      end)

      IO.write("\n")
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
        num1 = Integer.undigits(a)
        num2 = Integer.undigits(b)
        true

      true ->
        false
    end
  end

  def generatePermutations([]), do: [[]]

  def generatePermutations(list),
    do: for(elem <- list, rest <- generatePermutations(list -- [elem]), do: [elem | rest])
end
