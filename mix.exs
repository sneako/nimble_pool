defmodule NimblePool.MixProject do
  use Mix.Project

  @version "0.2.1"
  @url "https://github.com/dashbitco/nimble_pool"

  def project do
    [
      app: :nimble_pool,
      version: @version,
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      name: "NimblePool",
      description: "A tiny resource-pool implementation",
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [
      mod: {NimblePool.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [{:ex_doc, "~> 0.21", only: :docs}]
  end

  defp docs do
    [
      main: "NimblePool",
      source_ref: "v#{@version}",
      source_url: @url
    ]
  end

  defp package do
    %{
      licenses: ["Apache 2"],
      maintainers: ["José Valim"],
      links: %{"GitHub" => @url}
    }
  end
end
