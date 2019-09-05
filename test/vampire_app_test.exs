defmodule VampireAppTest do
  use ExUnit.Case
  doctest VampireApp

  test "greets the world" do
    assert VampireApp.hello() == :world
  end
end
