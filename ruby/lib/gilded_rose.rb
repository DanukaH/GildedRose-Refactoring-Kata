class GildedRose
  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        return AgedBrie.new(item).update_quality
      when 'Sulfuras, Hand of Ragnaros'
        return Sulfuras.new(item).update_quality
      when 'Backstage passes to a TAFKAL80ETC concert'
        return Backstage.new(item).update_quality
      else
        return NormalItem.new(item).update_quality
      end
    end
  end

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

  class Backstage
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

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
