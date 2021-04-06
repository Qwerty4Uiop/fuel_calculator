defmodule CalculatorCore do
  @moduledoc """
  Calculates fuel required for launches and lands on space objects with different gravity
  """

  @doc """
  ## Examples

      iex> CalculatorCore.calculate_fuel(28801, [{:launch, 9.807}, {:land, 1.62}])
      22380

  """
  @spec calculate_fuel(number, [{:launch | :land, number}]) :: integer
  def calculate_fuel(ship_mass, travel_path) do
    travel_path
    # To calculate ship mass including fuel at the start of travel we should start from the end
    # because this is the point when ship will be empty
    # so we can just add required fuel on each step instead of recalculate all previous steps on each total fuel changing
    |> Enum.reverse()
    |> Enum.reduce(ship_mass, fn {action, gravity}, result_mass ->
      {coef, subtrahend} = constants(action)
      result_mass + calculate_additional_fuel(result_mass, gravity, coef, subtrahend)
    end)
    |> Kernel.-(ship_mass)
    |> trunc()
  end

  defp calculate_additional_fuel(0, _gravity, _coef, _subtrahend), do: 0

  defp calculate_additional_fuel(initial_fuel, gravity, coef, subtrahend) do
    additional_fuel = max(do_calculate_fuel(initial_fuel, gravity, coef, subtrahend), 0)

    additional_fuel + calculate_additional_fuel(additional_fuel, gravity, coef, subtrahend)
  end

  defp do_calculate_fuel(mass, gravity, coef, subtrahend), do: trunc(mass * gravity * coef - subtrahend)

  @launch_coef 0.042
  @land_coef 0.033
  @launch_subtrahend 33
  @land_subtrahend 42
  defp constants(:launch), do: {@launch_coef, @launch_subtrahend}
  defp constants(:land), do: {@land_coef, @land_subtrahend}
end
