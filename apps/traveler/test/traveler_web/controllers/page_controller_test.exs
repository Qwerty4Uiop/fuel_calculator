defmodule TravelerWeb.PageControllerTest do
  use TravelerWeb.ConnCase

  alias Traveler.Repo
  alias Traveler.SpaceObject

  test "returns fuel weight for correct params", %{conn: conn} do
    conn = get(conn, "/calc", %{"ship_mass" => "28801", "from_0" => "Earth", "to_0" => "Moon", "from_1" => "Moon", "to_1" => "Earth"})
    assert html_response(conn, 200) =~ "Required fuel: 51898"
  end

  test "returns an error if path is invalid", %{conn: conn} do
    conn = get(conn, "/calc", %{"ship_mass" => "28801", "from_0" => "Earth", "to_0" => "Moon", "from_1" => "Earth", "to_1" => "Earth"})
    assert html_response(conn, 200) =~ "Error: invalid_path"
  end

  test "adds a new space object", %{conn: conn} do
    post(conn, "/add_object", %{"gravity" => "10.44", "object_name" => "Saturn"})
    assert %{object_name: "Saturn", gravity: 10.44} = Repo.get_by(SpaceObject, object_name: "Saturn")
  end
end
