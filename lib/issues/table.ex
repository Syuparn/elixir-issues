defmodule Issues.Table do
  def generate_issue_table(issues) do
    generate_table([], issue_column_names())
  end

  def generate_table(rows, column_names) do
    widths = column_widths([column_names | rows])

    [
      generate_header(column_names, widths),
      generate_spacer(widths)
    ]
    |> Enum.join("\n")
    |> then(&(&1 <> "\n")) # add trailing breakline
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
  end

  def generate_spacer(widths) do
    widths
    |> Stream.map(&(String.duplicate("-", &1)))
    |> Enum.join("-+-")
  end
end
