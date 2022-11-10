require_relative '../lib/gilded_rose'

RSpec.describe GildedRose do
  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]

      GildedRose.new(items).update_quality

      expect(items[0].name).to eq "foo"
    end
  end

  context "Normal Item" do
    it "before sell date" do
      items = [Item.new("Normal Item", 5, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 4, quality: 9)
    end

    it "on sell date" do
      items = [Item.new("Normal Item", 0, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -1, quality: 8)
    end

    it "after sell date" do
      items = [Item.new("Normal Item", -10, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -11, quality: 8)
    end

    it "of zero quality" do
      items = [Item.new("Normal Item", 5, 0)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 4, quality: 0)
    end
  end

  context "Aged Brie" do
    it "before sell date" do
      items = [Item.new("Aged Brie", 5, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 4, quality: 11)
    end

    it "with max quality" do
      items = [Item.new("Aged Brie", 5, 50)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 4, quality: 50)
    end

    it "on sell date" do
      items = [Item.new("Aged Brie", 0, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -1, quality: 12)
    end

    it "on sell date near max quality" do
      items = [Item.new("Aged Brie", 0, 49)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -1, quality: 50)
    end

    it "on sell date with max quality" do
      items = [Item.new("Aged Brie", 0, 50)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -1, quality: 50)
    end

    it "after sell date" do
      items = [Item.new("Aged Brie", -10, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -11, quality: 12)
    end

    it "after sell date with max quality" do
      items = [Item.new("Aged Brie", -10, 50)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -11, quality: 50)
    end
  end

  context "Sulfuras" do
    it "before sell date" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 5, 80)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 5, quality: 80)
    end

    it "on sell date" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 0, quality: 80)
    end

    it "after sell date" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", -10, 80)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -10, quality: 80)
    end
  end

  context "Backstage Pass" do
    it "long before sell date" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 10, quality: 11)
    end

    it "long before sell date at max quality" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 50)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 10, quality: 50)
    end

    it "medium close to sell date upper bound" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 9, quality: 12)
    end

    it "medium close to sell date upper bound at max quality" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 9, quality: 50)
    end

    it "medium close to sell date lower bound" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 5, quality: 12)
    end

    it "medium close to sell date lower bound at max quality" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 50)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 5, quality: 50)
    end

    it "very close to sell date upper bound" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 4, quality: 13)
    end

    it "very close to sell date upper bound at max quality" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 50)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 4, quality: 50)
    end

    it "very close to sell date lower bound" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 0, quality: 13)
    end

    it "very close to sell date lower bound at max quality" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 50)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 0, quality: 50)
    end

    it "on sell date" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -1, quality: 0)
    end

    it "after sell date" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -10, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -11, quality: 0)
    end
  end

  context "Conjured Mana" do
    it "before sell date" do
      items = [Item.new("Conjured Mana Cake", 5, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 4, quality: 8)
    end

    it "before sell date at zero quality" do
      items = [Item.new("Conjured Mana Cake", 5, 0)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: 4, quality: 0)
    end

    it "on sell date" do
      items = [Item.new("Conjured Mana Cake", 0, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -1, quality: 6)
    end

    it "on sell date at zero quality" do
      items = [Item.new("Conjured Mana Cake", 0, 0)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -1, quality: 0)
    end

    it "after sell date" do
      items = [Item.new("Conjured Mana Cake", -10, 10)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -11, quality: 6)
    end

    it "after sell date at zero quality" do
      items = [Item.new("Conjured Mana Cake", -10, 0)]

      GildedRose.new(items).update_quality

      expect(items[0]).to have_attributes(sell_in: -11, quality: 0)
    end
  end
end
