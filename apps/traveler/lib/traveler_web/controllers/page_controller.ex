defmodule TravelerWeb.PageController do
  use TravelerWeb, :controller

  alias Traveler.SpaceObjects

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def calc(conn, params) do
    with {mass_number, _rest} <- Float.parse(params["ship_mass"]),
         {:ok, full_path} <- format_calc_params(params),
         {:ok, fuel_weight} <- CalculatorCore.calculate_fuel(mass_number, full_path) do
      render(conn, "calc_result.html", fuel_weight: fuel_weight)
    else
      {:error, error} -> render(conn, "error.html", error: error)
    end
  end

  def add_object(conn, params) do
    with {:ok, _space_object} <- SpaceObjects.create_or_update(format_create_params(params)) do
      render(conn, "index.html")
    end
  end

  defp format_calc_params(params) do
    params
    |> Map.delete("ship_mass")
    |> Enum.to_list()
    |> Enum.sort_by(&{String.last(elem(&1, 0)), String.first(elem(&1, 0))})
    |> Enum.reduce_while({:ok, []}, fn {key, object_name}, {:ok, paths} ->
      space_object = SpaceObjects.find_by_name(object_name)

      case check_and_format_path(key, params, space_object) do
        {:ok, path} -> {:cont, {:ok, paths ++ [path]}}
        result -> {:halt, result}
      end
    end)
  end

  defp check_and_format_path("from_" <> number, params, space_object) do
    if not is_nil(params["to_" <> number]) do
      {:ok, {:launch, space_object.gravity}}
    else
      {:error, :empty_destination}
    end
  end

  defp check_and_format_path("to_" <> number = key, params, space_object) do
    next_source = params["from_#{String.to_integer(number) + 1}"]

    cond do
      is_nil(params["from_" <> number]) -> {:error, :empty_source}
      next_source != params[key] and not is_nil(next_source) -> {:error, :invalid_path}
      true -> {:ok, {:land, space_object.gravity}}
    end
  end

  defp format_create_params(params) do
    {number_gravity, _rest} = Float.parse(params["gravity"])

    %{
      object_name: params["object_name"],
      gravity: number_gravity
    }
  end
end
