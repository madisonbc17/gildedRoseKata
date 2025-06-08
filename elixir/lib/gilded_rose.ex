defmodule GildedRose do
  @moduledoc """
  The Gilded Rose kata is a classic coding exercise that involves updating the quality of items in a shop based on specific rules.
  This module provides functions to update the quality of items according to the rules defined in the kata.
  """

  @spec update_items([%Item{}]) :: list()
  def update_items(items) when is_list(items) do
    Enum.map(items, &update_item/1)
  end

  @spec update_item(%Item{}) :: %Item{}
  def update_item(item) do
    type = item_type(item.name)

    %Item{
      item
      | sell_in: update_sell_in(type, item.sell_in),
        quality: update_quality(type, item)
    }
  end

  defp item_type(name) do
    cond do
      String.contains?(name, "Aged Brie") -> :aged_brie
      String.contains?(name, "Sulfuras") -> :sulfuras
      String.contains?(name, "Backstage passes") -> :backstage
      String.contains?(name, "Conjured") -> :conjured
      true -> :normal
    end
  end

  defp update_sell_in(:sulfuras, sell_in), do: sell_in
  defp update_sell_in(_, sell_in), do: sell_in - 1

  defp update_quality(:sulfuras, %Item{quality: quality}), do: quality

  defp update_quality(:aged_brie, %Item{quality: quality, sell_in: sell_in}) do
    inc = if sell_in <= 0, do: 2, else: 1
    min(quality + inc, 50)
  end

  defp update_quality(:backstage, %Item{quality: quality, sell_in: sell_in}) do
    cond do
      sell_in <= 0 -> 0
      sell_in <= 5 -> min(quality + 3, 50)
      sell_in <= 10 -> min(quality + 2, 50)
      true -> min(quality + 1, 50)
    end
  end

  defp update_quality(:conjured, %Item{quality: quality, sell_in: sell_in}) do
    dec = if sell_in <= 0, do: 4, else: 2
    max(quality - dec, 0)
  end

  defp update_quality(:normal, %Item{quality: quality, sell_in: sell_in}) do
    dec = if sell_in <= 0, do: 2, else: 1
    max(quality - dec, 0)
  end
end
