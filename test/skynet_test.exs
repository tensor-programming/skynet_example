defmodule SkynetTest do
  use ExUnit.Case
  doctest Skynet

  test "greets the world" do
    assert Skynet.hello() == :world
  end
end
