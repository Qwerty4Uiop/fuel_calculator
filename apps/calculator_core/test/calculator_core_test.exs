defmodule CalculatorCoreTest do
  use ExUnit.Case
  doctest CalculatorCore

  test "calculates fuel for different travels" do
    assert {:ok, 51898} = CalculatorCore.calculate_fuel(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
    assert {:ok, 33388} = CalculatorCore.calculate_fuel(14606, [{:launch, 9.807}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}])
    assert {:ok, 212161} = CalculatorCore.calculate_fuel(75432, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62},{:land, 3.711}, {:launch, 3.711}, {:land, 9.807}])
  end
end
