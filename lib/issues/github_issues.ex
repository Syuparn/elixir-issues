defmodule Issues.GitHubIssues do
  @user_agent [{"User-agent", "Elixir dave@pragprog.com"}]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response()
  end

  # fetch config from config.exs in compile time
  @github_url Application.compile_env(:issues, :github_url)

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    {check_for_error(status_code), Poison.Parser.parse!(body)}
  end

  def check_for_error(200), do: :ok
  def check_for_error(_), do: :error
end
