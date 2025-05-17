defmodule CcReport.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CcReportWeb.Telemetry,
      CcReport.Repo,
      {DNSCluster, query: Application.get_env(:cc_report, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CcReport.PubSub},
      # Start a worker by calling: CcReport.Worker.start_link(arg)
      # {CcReport.Worker, arg},
      # Start to serve requests, typically the last entry
      CcReportWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CcReport.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CcReportWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
