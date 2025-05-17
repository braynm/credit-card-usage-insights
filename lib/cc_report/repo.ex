defmodule CcReport.Repo do
  use Ecto.Repo,
    otp_app: :cc_report,
    adapter: Ecto.Adapters.Postgres
end
