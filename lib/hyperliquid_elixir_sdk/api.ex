defmodule HyperliquidElixirSdk.Api do
  use HTTPoison.Base

  def process_request_url(url) do
    "https://api.hyperliquid.xyz" <> url
  end

  def process_request_headers(headers) do
    headers ++
      [
        {
          "Content-Type",
          "application/json"
        }
      ]
  end

  def process_request_body(body) do
    if is_map(body),
      do: Jason.encode!(body),
      else: body
  end

  def process_response_body(body) do
    Jason.decode!(body)
  end
end
