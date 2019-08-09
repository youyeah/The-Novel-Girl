# coding: utf-8
require 'dxruby'

Dir[File.expand_path('../defined_classes',__FILE__) << '/*.rb'].each do |file|
    require file
end

# character
image = Image.load_tiles("./character.png",4,4)
image2 = Image.load_tiles("./character2.png",6,4)
field = Image.new(640,640)
field.box_fill(0,0,640,160,[216,117,35])
pc = PlayerCharacter.new(320,240,image2[0])

# red_bullet
red_bullet_image = Image.new(5,5,C_WHITE)
bullets = []

# portal_bullet
p_bullet_image = Image.new(7,7,C_BLUE)
p_shot = nil

# portal gate
gate_image = Image.new(10,10,C_BLUE)
p_gate = nil

# score
score = 20
font = Font.new(32)

# enemy
enemy_image = Image.load("./face2.png",0,0)
enemy = Sprite.new(270,100,enemy_image)
# enemyの上下運動
one = 1

back = set_background(Window.width, Window.height)

sample_var = false

Window.loop do
    break if Input.keyPush?(K_ESCAPE)
    # 背景描画
    Window.draw(0,320,field)

    # 攻撃弾（発射）
    if Input.keyPush?(K_SPACE)
        bullets << Bullet.new(pc.x+10, pc.y+15, red_bullet_image)
    end

    # ポータル弾
    if Input.keyPush?(K_F) && p_shot == nil
        p_shot = PortalShot.new(pc.x+10, pc.y, p_bullet_image)
    end
    # ポータル弾進む
    if !p_shot.nil?
        p_shot.x += 3
    end
    # ポータル弾当たる
    if p_shot === back
        p_gate = nil
        p_gate = Gate.new(p_shot.x-10, p_shot.y, gate_image)
        p_shot = nil
    end
    # ポータル移動
    if Input.keyPush?(K_R) && !p_gate.nil?
        pc.x = p_gate.x-5
        pc.y = p_gate.y
    end

    bullets.each do |b|
        b.x += 5
        if b === enemy
            bullets.delete(b)
            score -= 1
        end
    end
    
    pc.start(back)

    Window.draw_font(50, 50, "YUIYA HP:#{score.to_s}", font)
    
    # 描画させる群
    Bullet.draw(bullets)
    Sprite.draw(back)
    enemy.draw
    PortalShot.draw(p_shot)
    Gate.draw(p_gate)

    
    # enemy が上下に動く
    enemy.y += one
    if enemy.y == 170
        one = one * -1
    elsif enemy.y == 50
        one = one * -1
    end


    if score <= 0
        Window.draw_font(100,200,"Game Clear\nPress ESC to close window",font)
        break if Input.keyPush?(K_ESCAPE)
    end
    sample_var = true if Input.keyPush?(K_Q)
    Window.draw_font(Window.width / 2, Window.height / 2,"テスト成功",font) if sample_var
end