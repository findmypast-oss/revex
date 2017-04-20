defmodule Rev do
  @moduledoc """
  Overrides HTTPoison.Base to add specifics to contacting Rev API.
  """

  use HTTPoison.Base

  @base_url Application.get_env(:revex, :url)
  @user_api_key Application.get_env(:revex, :user_api_key)
  @client_api_key Application.get_env(:revex, :client_api_key)

  def process_request_headers(headers) do
    [{"Authorization", "Rev #{@client_api_key}:#{@user_api_key}"} | headers]
  end

  def process_url(route) do
    "#{@base_url}#{route}" |> IO.inspect 
  end
end
