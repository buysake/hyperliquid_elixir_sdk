defmodule HyperliquidElixirSdk.Info do
  alias HyperliquidElixirSdk.Api

  def user_state(address) do
    call_info("clearinghouseState", address)
  end

  def open_orders(address) do
    call_info("openOrders", address)
  end

  def frontend_open_orders(address) do
    call_info("frontendOpenOrders", address)
  end

  def all_mids() do
    call_info("allMids")
  end

  def user_fills(address) do
    call_info("userFills", address)
  end

  def meta() do
    call_info("meta")
  end

  def funding_history(coin, start_ms) do
    funding_history(coin, start_ms, nil)
  end

  def funding_history(coin, start_ms, end_ms)
      when is_integer(start_ms) and (is_integer(end_ms) or is_nil(end_ms)) do
    params =
      if end_ms != nil,
        do: %{"coin" => coin, "startTime" => start_ms, "endTime" => end_ms},
        else: %{"coin" => coin, "startTime" => start_ms}

    call_info("fundingHistory", params)
  end

  def l2_snapshot(coin) do
    call_info("l2Book", %{"coin" => coin})
  end

  def candles_snapshot(coin, interval, start_ms, end_ms)
      when is_integer(start_ms) and is_integer(end_ms) do
    call_info("candleSnapshot", %{
      "req" => %{
        "coin" => coin,
        "interval" => interval,
        "startTime" => start_ms,
        "endTime" => end_ms
      }
    })
  end

  defp call_info(type) do
    body = %{
      "type" => type
    }

    info_response_handler(Api.post("/info", body))
  end

  defp call_info(type, params) when is_map(params) do
    body =
      params
      |> Map.put("type", type)

    info_response_handler(Api.post("/info", body))
  end

  defp call_info(type, "0x" <> _ = address) do
    body = %{
      "type" => type,
      "user" => address
    }

    info_response_handler(Api.post("/info", body))
  end

  defp call_info(_, _) do
    {:error, :invalid_address_format}
  end

  defp info_response_handler({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end

  defp info_response_handler({:ok, resp}) do
    {:error, :api_error, resp}
  end

  defp info_response_handler({:error, e}) do
    {:error, :network_error, e}
  end
end
