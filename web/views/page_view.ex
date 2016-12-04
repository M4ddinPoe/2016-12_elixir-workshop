defmodule Wiki.PageView do
  use Wiki.Web, :view

  def wiki_to_html(nil), do: ""
  def wiki_to_html(markdown) do
    markdown
    |> String.replace(~r/\[\[([\w|\s]+)\]\]/, "[\\1](/\\1)")
    |> Earmark.to_html()
    |> raw()
  end
end
