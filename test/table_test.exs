defmodule TableTest do
  use ExUnit.Case
  doctest Issues

  import Issues.Table, only: [generate_issue_table: 1, issue_rows: 1]

  test "generate an issue table with no issues" do
    issues = fake_issues([])

    assert generate_issue_table(issues) == """
           # | created_at | title
           --+------------+------

           """
  end

  test "generate an issue table with one issue" do
    issues =
      fake_issues([
        {123, "2023-01-01-T01:23:45Z", "Simple bug"}
      ])

    assert generate_issue_table(issues) == """
           #   | created_at            | title
           ----+-----------------------+-----------
           123 | 2023-01-01-T01:23:45Z | Simple bug
           """
  end

  test "generate an issue table with multiple issues" do
    issues =
      fake_issues([
        {999, "2023-01-01-T01:23:45Z", "Simple bug"},
        {1000, "2023-01-02-T01:23:45Z", "Cool feature"}
      ])

    assert generate_issue_table(issues) == """
           #    | created_at            | title
           -----+-----------------------+-------------
           999  | 2023-01-01-T01:23:45Z | Simple bug
           1000 | 2023-01-02-T01:23:45Z | Cool feature
           """
  end

  test "issue_rows extracts specific keys from map" do
    issues =
      fake_issues([
        {123, "2023-01-01-T01:23:45Z", "Simple bug"}
      ])

    assert issue_rows(issues) == [["123", "2023-01-01-T01:23:45Z", "Simple bug"]]
  end

  defp fake_issues(values) do
    Enum.map(values, &fake_issue/1)
  end

  defp fake_issue({number, created_at, title}) do
    %{"number" => number, "created_at" => created_at, "title" => title}
  end
end
