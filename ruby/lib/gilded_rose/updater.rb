class GildedRose
  module Updater
    class AgedBrie
      attr_accessor :item

      def initialize(item)
        @item = item
      end

      def update_quality
        item.quality += 1 if item.quality < 50
        item.sell_in -= 1
        item.quality += 1 if item.sell_in < 0 && item.quality < 50
      end
    end

    class BackstagePasses
      attr_accessor :item

      def initialize(item)
        @item = item
      end

      def update_quality
        item.sell_in -= 1
        return if item.quality >= 50
        return item.quality = 0 if item.sell_in < 0

        item.quality += 1
        item.quality += 1 if item.sell_in < 10
        item.quality += 1 if item.sell_in < 5
      end
    end

    class Sulfuras
      attr_accessor :item

      def initialize(item)
        @item = item
      end

      def update_quality
      end
    end

    class NormalItem
      attr_accessor :item

      def initialize(item)
        @item = item
      end

      def update_quality
        item.sell_in -= 1
        return if item.quality == 0

        item.quality -= 1
        item.quality -= 1 if item.sell_in <= 0
      end
    end

    class Conjured
      attr_accessor :item

      def initialize(item)
        @item = item
      end

      def update_quality
        item.sell_in -= 1
        return if item.quality == 0

        item.quality -= 2
        item.quality -= 2 if item.sell_in <= 0
      end
    end

    NAME_TO_UPDATE = {
      'Aged Brie' => AgedBrie,
      'Sulfuras, Hand of Ragnaros' => Sulfuras,
      'Backstage passes to a TAFKAL80ETC concert' => BackstagePasses,
      'Conjured Mana Cake' => Conjured
    }

    def self.for(item)
      NAME_TO_UPDATE.fetch(item.name, NormalItem).new(item)
    end
  end
end