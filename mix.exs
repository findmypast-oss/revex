defmodule Revex.Mixfile do
  use Mix.Project

  def project do
    [app: :revex,
     version: "0.1.0",
     elixir: "~> 1.4",
     description: "Client to Rev transcription service",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.travis": :test]]
  end

  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:meck, "~> 0.8.4", only: :test},
     {:httpoison, "~> 0.11.1"},
     {:poison, "~> 3.1"},
     {:excoveralls, "~> 0.6.3", only: :test},
     {:ex_doc, "~> 0.15.0", only: :dev}]
  end

  defp package do
    [name: :revex,
     files: ["lib", "mix.exs", "README.md", "LICENSE"],
     maintainers: ["Steven Blowers", "Patrick McDonnell"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/findmypast-oss/revex"}]
  end
end
