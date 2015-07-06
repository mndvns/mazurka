defmodule Mazurka.Resource.Error do
  defexception [:message]

  defmacro error(mediatype, name, [do: block]) do
    Mazurka.Compiler.Utils.register(mediatype, __MODULE__, block, name)
  end

  def compile(mediatype, block, globals, {_, _, [arg]}) do
    quote do
      unquote_splicing(globals[:let] || [])
      unquote(arg) = prop(:error)
      error = unquote(mediatype).handle_error(unquote(block))
      ^^Mazurka.Resource.Error.set_error(error)
    end
    |> Mazurka.Resource.Param.format
  end

  def format_name({name, _meta, _args}) when is_atom(name) do
    name
  end

  def set_error([message], conn, _parent, _ref, _attrs) do
    conn = Plug.Conn.put_private(conn, :mazurka_error, true)
    {:ok, message, conn}
  end
end