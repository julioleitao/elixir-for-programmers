defmodule KvCacheTest do
  use ExUnit.Case
  doctest KvCache

  test "greets the world" do
    assert KvCache.hello() == :world
  end
end
