require_relative 'player_character'

class Bullet < PlayerCharacter
    attr_accessor :move

    def shot(move)
        if Input.keyPush?(K_SPACE)
            bullets << Bullet.new(pc.x+10, pc.y+15, red_bullet_image)
        end
        
        return bullets
    end

    # 弾を撃つ
    def shot
        self.draw
   end
end