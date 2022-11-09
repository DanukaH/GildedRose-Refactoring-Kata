class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|

      case item.name
      when 'Normal Item'
        return normal_item_update_quality(item)
      when 'Aged Brie'
        return brie_update_quality(item)
      when 'Sulfuras, Hand of Ragnaros'
        return sulfuras_update_quality(item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        return backstage_update_quality(item)
      else
        # type code here
      end
    end
  end

  def normal_item_update_quality(item)
    item.sell_in -= 1
    return if item.quality == 0

    item.quality -= 1
    item.quality -= 1 if item.sell_in <= 0
  end

  def brie_update_quality(item)
    item.sell_in -= 1
    return if item.quality >= 50

    item.quality += 1
    item.quality += 1 if item.sell_in <= 0
  end

  def sulfuras_update_quality(item)
  end

  def backstage_update_quality(item)
    item.sell_in -= 1
    return if item.quality >= 50
    return item.quality = 0 if item.sell_in < 0

    item.quality += 1
    item.quality += 1 if item.sell_in < 10
    item.quality += 1 if item.sell_in < 5
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
