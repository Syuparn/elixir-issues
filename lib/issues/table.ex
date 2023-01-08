defmodule Issues.Table do
  def generate_issue_table(issues) do
    generate_table(issue_rows(issues), issue_column_names())
  end

  def generate_table(rows, column_names) do
    widths = column_widths([column_names | rows])

    [
      generate_header(column_names, widths),
      generate_spacer(widths),
      generate_rows(rows, widths)
    ]
    |> Enum.join("\n")
    # add trailing breakline
    |> then(&(&1 <> "\n"))
  end

  def issue_rows(issues) do
    Enum.map(issues, &issue_row/1)
  end

  def issue_column_keys() do
    ["number", "created_at", "title"]
  end

  def issue_row(issue) do
    issue_column_keys()
    |> Enum.map(fn key ->
      to_string(issue[key])
    end)
  end

  def issue_column_names() do
    ["#", "created_at", "title"]
  end

  def column_widths(rows) do
    columns(rows)
    |> Enum.map(&column_width/1)
  end

  def columns(rows) do
    rows
    |> Stream.zip()
    |> Stream.map(&Tuple.to_list/1)
  end

  def column_width(column) do
    column
    |> Stream.map(&String.length/1)
    |> Enum.max()
  end

  def generate_header(column_names, widths) when length(column_names) == length(widths) do
    [column_names, widths]
    |> Stream.zip()
    |> Stream.map(fn {column_name, width} -> String.pad_trailing(column_name, width) end)
    |> Enum.join(" | ")
    |> String.trim_trailing()
  end

  def generate_spacer(widths) do
    widths
    |> Stream.map(&String.duplicate("-", &1))
    |> Enum.join("-+-")
  end

  def generate_rows(rows, widths) do
    rows
    |> Enum.map(&generate_row(&1, widths))
    |> Enum.join("\n")
  end

  def generate_row(row, widths) do
    [row, widths]
    |> Stream.zip()
    |> Stream.map(fn {row, width} -> String.pad_trailing(row, width) end)
    |> Enum.join(" | ")
    |> String.trim_trailing()
  end
end
