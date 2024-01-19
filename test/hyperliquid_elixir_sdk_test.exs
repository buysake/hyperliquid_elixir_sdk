defmodule HyperliquidElixirSdkTest do
  use ExUnit.Case
  doctest HyperliquidElixirSdk

  test "greets the world" do
    assert HyperliquidElixirSdk.hello() == :world
  end
end
