defmodule MazurkaTest.Resources.Root do
  @moduledoc """
  Root resource, here.
  """

  use Mazurka.Resource
  alias MazurkaTest.Resources

  let user_id = Auth.user_id

  @doc """
  This is a foo
  """
  let foo = 123

  @doc """
  This is a mediatype
  """
  mediatype Mazurka.Mediatype.Hyperjson do
    action do
      user = link_to Resources.Users.Read, %{user: user_id}
      %{
        "account" => user,
        "foo" => foo
        # oauth: %Oauth{},
        # search: %Search{} |> pointer :search,
        # translations: %Translations{}
      }
    end
  end

  event do
    :ok
  end

  event do
    :ok
  end

  test "should response with a 200" do
    conn = request do
      accept "hyper+json"
    end

    assert conn.status == 200
  end
end