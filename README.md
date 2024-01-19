# HyperliquidElixirSdk

⚠ WIP ⚠

## WebSocket

This SDK provides it as a behavior. `InfoWs`

```elixir
defmodule AllMidsSubscriber do
  alias HyperliquidElixirSdk.InfoWs
  use InfoWs

  def build_opts() do
    InfoWs.build_mid_stream_opts()
  end

  def on_message(message) do
    IO.inspect(message)
  end
end

```

```
iex(1)> {:ok, pid} = AllMidsSubscriber.start_link()
```
