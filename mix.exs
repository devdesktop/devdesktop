defmodule Sys.MixProject do
  use Mix.Project

  def project do
    [
      app: :sys,
      version: "0.1.0",
      elixir: "~> 1.17",
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:habitat, path: Path.join(System.user_home(), "../habitat")}
    ]
  end
end