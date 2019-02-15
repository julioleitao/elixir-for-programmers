defmodule KvCache.Application do
  use Application

  def start(_type, _args) do
    KvCache.Cache.start_link()
  end
end
