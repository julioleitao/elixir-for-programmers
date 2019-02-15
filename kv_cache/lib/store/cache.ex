defmodule KvCache.Cache do

  @me __MODULE__

  def start_link, do: Agent.start_link(fn -> %{} end, name: @me)

  def get(key), do: Agent.get(@me, fn mem -> mem[key] end)

  def update([{key, value}]) do
    Agent.update(@me, fn mem -> Map.put(mem, key, value) end)
  end
end
