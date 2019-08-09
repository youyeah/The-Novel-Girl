class PlayerCharacter < Sprite
    attr_accessor :ground

    # 速度のｖとジャンプフラッグ
    def initialize(x,y,image)
        @v = 0
        @jflag = 0
        @direction = 1
        super
    end

    # 動き（右と左だけ）
    def move(ground)
        if Input.keyDown?(K_D)
            self.x += 4
            @direction = 1
            if self === ground
                self.x -= 4
            end
        end
        if Input.keyDown?(K_A)
            self.x -= 4
            @direction = -1
            if self === ground
                self.x += 4
            end
        end
    end

    # ジャンプ 始めの上向きの速度を毎フレーム下に力を加える
    def jump
        if Input.key_push?(K_R)
            @v = -2
        end
        if Input.key_push?(K_W) && @jflag >= 0
            @v = -20
            @jflag -= 1
        end
        @v += 1 # 重力加速　速度を1フレーム毎に追加
        self.y += @v
    end

    # 衝突判定（地面）
    def collision(ground)
        if self === ground
            # character の場合　-52
            # character2 の場合 -48
            self.y = Window.height-48
            @v = 0
            @jflag = 1
        end
    end

    # まとめた
    def start(ground)
        self.draw
        self.move(ground)   # groundは左右の壁。当たると、進んだ分だけ戻るように。
        self.jump
        self.collision(ground)  # groundは地面。沈まないようにしたり、ジャンプフラッグとか。
    end

end

def set_background(width, height)
    block_x = 0
    block_y = 0
    image = Image.new(20,20,C_CYAN)
    sprites = []

    loop do
        block_x = 0

        if block_y == 0 || block_y == height - 20
            loop do
                sprites << Sprite.new(block_x, block_y, image)
                break if block_x >= width - 20
                block_x += 20
            end
        else
            loop do
                sprites << Sprite.new(block_x, block_y, image)
                break if block_x >= width - 20
                block_x += width - 20
            end
        end

        if height < block_y
            break
        else
            block_y += 20
        end
    end

    return sprites
end