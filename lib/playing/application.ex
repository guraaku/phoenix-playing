defmodule Playing.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PlayingWeb.Telemetry,
      Playing.Repo,
      {DNSCluster, query: Application.get_env(:playing, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Playing.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Playing.Finch},
      # Start a worker by calling: Playing.Worker.start_link(arg)
      # {Playing.Worker, arg},
      # Start to serve requests, typically the last entry
      PlayingWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Playing.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PlayingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
