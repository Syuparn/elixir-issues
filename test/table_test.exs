defmodule TableTest do
  use ExUnit.Case
  doctest Issues

  import Issues.Table, only: [generate_issue_table: 1]

  test "generate an issue table with no issues" do
    issues = fake_issues([])

    assert generate_issue_table(issues) == """
           # | created_at | title
           --+------------+------
           """
  end

  defp fake_issues(values) do
    Enum.map(values, &fake_issue/1)
  end

  defp fake_issue({number, created_at, title}) do
    %{"number" => number, "created_at" => created_at, "title" => title}
  end
end
