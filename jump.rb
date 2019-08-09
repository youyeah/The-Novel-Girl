# -*- coding: cp932 -*-

# Require
require          'dxruby'
require_relative 'functions'

# require display
Window.width, Window.height = 300, 500

# require image
chara_image = Image.load_tiles('images/character.png', 4, 4)
tile_image  = Image.load_tiles('images/colorbox.png',  6, 1)

# require chara sprite
chara = Sprite.new(200, 50, chara_image[0])

# require tiles sprites
tiles = []
(Window.width / 20).times do |i|
  tiles << Sprite.new(i * 20, Window.height - 20, tile_image[i % 6])
end

5.times do |i|
  tiles << Sprite.new(i * 20 + 60, Window.height - 140, tile_image[i % 6])
end
5.times do |i|
  tiles << Sprite.new(i * 20 + 140, Window.height - 260, tile_image[i % 6])
end

# require fall
g_teisu = 1.5
g_time  = 0.0
g_limit = 60
g_div   = 4

Window.loop do
  # character が地上に居るか判断（初期値：false）
  bool_landing = false

  # 
  val_t = g_time.fdiv(g_div)
  if g_time < 0
    chara.y -= val_t ** 2 * g_teisu
  else
    chara.y += val_t ** 2 * g_teisu
  end

  if g_time < g_limit
    g_time += 1
  end

  tiles.each do |tile|
    if chara === tile
      if g_time < 0
        g_time = (-1)*g_time
        chara.y = tile.y + 20
      elsif tile.x - 32 < chara.x and chara.x < tile.x + 12
        g_time = 0
        chara.y = tile.y - 32
        bool_landing = true
      end
    end
  end

  if chara.y > Window.height - 20 - 32
    chara.y = Window.height - 20 - 32
    bool_landing = true
  end

  if Input.keyDown?(K_RIGHT) and chara.x <= Window.width - 3 - 32
    chara.x += 3
  end

  if Input.keyDown?(K_LEFT) and chara.x >= 3
    chara.x -= 3
  end

  if Input.keyDown?(K_UP) and bool_landing == true
    g_time = -16
  end

  Sprite.draw(chara)
  Sprite.draw(tiles)
end