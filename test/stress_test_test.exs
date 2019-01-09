defmodule StressTestTest do
  use ExUnit.Case
  doctest StressTest

  test "greets the world" do
    assert StressTest.hello() == :world
  end
end
