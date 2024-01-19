defmodule HyperliquidElixirSdk.InfoWs do
  def build_mid_stream_opts() do
    [
      subscription: %{
        type: "allMids"
      }
    ]
  end

  @type subscription :: %{type: type :: binary}

  @callback on_message(message :: term) :: term
  @callback build_opts() ::
              opts :: [
                subscription: sub :: subscription
              ]

  defmacro __using__(opts) do
    quote location: :keep, bind_quoted: [opts: opts] do
      use WebSockex
      @behaviour HyperliquidElixirSdk.InfoWs

      def start_link() do
        opts = build_opts()

        {:ok, pid} =
          WebSockex.start_link(
            "wss://api.hyperliquid-testnet.xyz/ws",
            __MODULE__,
            %{},
            opts
          )

        WebSockex.send_frame(
          pid,
          {:text,
           Jason.encode!(%{
             "method" => "subscribe",
             "subscription" => opts[:subscription]
           })}
        )

        {:ok, pid}
      end

      def handle_frame({:text, msg}, state) do
        Task.start_link(fn ->
          on_message(Jason.decode!(msg))
        end)

        {:ok, state}
      end
    end
  end
end
