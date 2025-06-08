defmodule GildedRoseTest do
  use ExUnit.Case

  setup do
    items = [
      %Item{name: "+5 Dexterity Vest", sell_in: 10, quality: 20},
      %Item{name: "Aged Brie", sell_in: 2, quality: 0},
      %Item{name: "Elixir of the Mongoose", sell_in: 5, quality: 7},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: -1, quality: 80},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 49},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 49},
      %Item{name: "Conjured Mana Cake", sell_in: 3, quality: 6}
    ]

    {:ok, %{items: items}}
  end

  describe "Gilded Rose Kata Tests" do
    test "begin the journey of refactoring" do
      items = [%Item{name: "foo", sell_in: 0, quality: 0}]
      GildedRose.update_items(items)
      %{name: firstItemName} = List.first(items)
      assert "foo" == firstItemName
    end

    test "update_items/1 updates all items", %{items: items} do
      updated_items = GildedRose.update_items(items)

      expected = [
        %Item{name: "+5 Dexterity Vest", sell_in: 9, quality: 19},
        %Item{name: "Aged Brie", sell_in: 1, quality: 1},
        %Item{name: "Elixir of the Mongoose", sell_in: 4, quality: 6},
        %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
        %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: -1, quality: 80},
        %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 14, quality: 21},
        %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 50},
        %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 4, quality: 50},
        %Item{name: "Conjured Mana Cake", sell_in: 2, quality: 4}
      ]

      assert length(updated_items) == length(items)
      assert updated_items == expected
    end
  end

  describe "update_item/1" do
    test "Aged Brie increases by 1 and sell_in day decreases by 1" do
      item = %Item{name: "Aged Brie", sell_in: 2, quality: 0}
      expected = %Item{name: "Aged Brie", sell_in: 1, quality: 1}

      assert GildedRose.update_item(item) == expected
    end

    test "Sulfuras does not change in quality nor sell_in" do
      item = %Item{name: "Sulfuras", sell_in: 0, quality: 80}
      expected = %Item{name: "Sulfuras", sell_in: 0, quality: 80}

      assert GildedRose.update_item(item) == expected
    end

    test "Backstage passes increase quality by 1 when sell in is over 10 days" do
      item = %Item{name: "Backstage passes", sell_in: 15, quality: 20}
      expected = %Item{name: "Backstage passes", sell_in: 14, quality: 21}

      assert GildedRose.update_item(item) == expected
    end

    test "Backstage passes increase quality by 2 when sell in 10 days or less" do
      item = %Item{name: "Backstage passes", sell_in: 10, quality: 21}
      expected = %Item{name: "Backstage passes", sell_in: 9, quality: 23}

      assert GildedRose.update_item(item) == expected
    end

    test "Backstage passes increase quality by 3 when sell in 5 days or less" do
      item = %Item{name: "Backstage passes", sell_in: 5, quality: 27}
      expected = %Item{name: "Backstage passes", sell_in: 4, quality: 30}

      assert GildedRose.update_item(item) == expected
    end

    test "Backstage passes drop quality to 0 when sell in is less than 0 days" do
      item = %Item{name: "Backstage passes", sell_in: 0, quality: 40}
      expected = %Item{name: "Backstage passes", sell_in: -1, quality: 0}

      assert GildedRose.update_item(item) == expected
    end

    test "Conjured items decrease in quality by 2" do
      item = %Item{name: "Conjured", sell_in: 3, quality: 6}
      expected = %Item{name: "Conjured", sell_in: 2, quality: 4}

      assert GildedRose.update_item(item) == expected
    end

    test "Conjured items decrease in quality by 4 when sell_in is less than or equal to 0" do
      item = %Item{name: "Conjured", sell_in: 0, quality: 6}
      expected = %Item{name: "Conjured", sell_in: -1, quality: 2}

      assert GildedRose.update_item(item) == expected
    end

    test "Normal item decreases sell_in and quality by 1" do
      item = %Item{name: "Dexterity Vest", sell_in: 10, quality: 20}
      expected = %Item{name: "Dexterity Vest", sell_in: 9, quality: 19}

      assert GildedRose.update_item(item) == expected
    end

    test "Normal items decrease in quality by 2 when sell_in is less than or equal to 0" do
      item = %Item{name: "Dexterity Vest", sell_in: 0, quality: 20}
      expected = %Item{name: "Dexterity Vest", sell_in: -1, quality: 18}

      assert GildedRose.update_item(item) == expected
    end
  end
end
