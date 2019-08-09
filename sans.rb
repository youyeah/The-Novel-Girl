#! ruby -Ku
# -*- mode:ruby; coding:utf-8 -*- 
require 'dxruby'

Dir[File.expand_path('../novel_classes',__FILE__) << '/*.rb'].each do |file|
    require file
end
Dir[File.expand_path('../messages',__FILE__) << '/*.rb'].each do |file|
    require file
end

black = Image.new(600, 450, C_BLACK)
count = CountingFlames.new
Window.width = 590
Window.height = 440

Font.install('./fonts/rounded-mplus-1c-black.ttf')
sans_font = Font.new(20,"Rounded M+ 1c black")
Font.install('./fonts/misaki_gothic.ttf')
hp_font = Font.new(20,"美咲ゴシック")
hitpoint_y_image = Image.new(10,20,C_YELLOW)
hitpoint_r_image = Image.new(20,20,C_RED)
hp_y = Sprite.new(320,398,hitpoint_y_image)
hp_r = Sprite.new(330,398,hitpoint_r_image)
hp_bar = [hp_y,hp_r]

white_tate_image = Image.new(5, 170, C_WHITE)
white_yoko_image = Image.new(170,5,C_WHITE)
sans_frames = []
sans_frames << Sprite.new((Window.width/2)-(170/2),Window.height/2-20,white_tate_image)
sans_frames << Sprite.new((Window.width / 2)+(170/2),Window.height/2-20,white_tate_image)
sans_frames << Sprite.new((Window.width / 2)-(170/2)+5,(Window.height/2-20),white_yoko_image)
sans_frames << Sprite.new((Window.width / 2)-(170/2)+5,Window.height/2+145,white_yoko_image)

megalovania = Music.new('./musics/MEGALOVANIA.wav')
megalovania.loop_count=(-1)
# megalovania_midi = Music.new('./musics/Undertale_-_Megalovania (1).mid')
megalovania.set_volume(70)
sans_attack1 = Music.new('./musics/sans_attack1.wav')
sans_attack1.set_volume(70)
sans_out = Music.new('./musics/sans_out.wav')
determination = Music.new('./musics/Determination.wav')
encount = Music.new('./musics/Encount.wav')
determination.set_volume(70)
cure = Music.new('./musics/cure.wav')
cure.set_volume(70)
serifnate = Music.new('./musics/serifnate.wav')

heart_image = Image.load('./bad_images/Undertale_heart.png')
heart = Sprite.new(100, 100, heart_image)
sans_image = Image.load('./bad_images/sans.png')
sans = Sprite.new(200,100, sans_image)
mini_heart_image = Image.load('./bad_images/mini_heart.png')
mini_heart = Sprite.new((Window.width/2)-6,(Window.height/2)+170/2-25,mini_heart_image)
mini_sans_image = Image.load('./bad_images/mini_sans.png')
mini_sans_x = Window.width/2-50
mini_sans = Sprite.new(mini_sans_x,50,mini_sans_image)
mini_sans_l = Sprite.new(Window.width/2-120,50,mini_sans_image)
mini_sans_float = 0.05
speak_balloon_image = Image.load('./bad_images/speak_balloon.png')
speak_balloon = Sprite.new(Window.width/2-18,30,speak_balloon_image)
blaster_l_x = Window.width/2 + 100
blaster_l_y = Window.height/2
blaster_r_x = Window.width/2 - 167
blaster_r_y = Window.height/2
blaster_l_image = Image.load('./bad_images/blaster_l.png')
blaster_l = Sprite.new(blaster_l_x, blaster_l_y,blaster_l_image)
blaster_r_image = Image.load('./bad_images/blaster_r.png')
blaster_r = Sprite.new(blaster_r_x, blaster_r_y,blaster_r_image)
razor_image = Image.new(405,30,C_WHITE)
razor_l = Sprite.new(-10,blaster_l_y+10,razor_image)
razor_r = Sprite.new(blaster_r_x+63,blaster_r_y+10,razor_image)
razor_aplha1 = 255
razor_aplha2 = 255
razor_aplha3 = 255
razor_aplha4 = 255
sans_gameover_image = Image.load('./bad_images/undertale-gameover.png')
sans_gameover = Sprite.new(145,100,sans_gameover_image)
arrow_image = Image.load('./bad_images/arrow.png')
arrow_l_image = Image.load('./bad_images/arrow_l.png')
arrow_r_image = Image.load('./bad_images/arrow_r.png')
arrows = []
arrows_l = []
arrows_r = []
arrow_rapid = []
counts = 0

sans_txts = Messagebox.new
display_txt = Messagebox.new
text_delay = DisplayFrame.new
sans_serif_x = 340
sans_serif_y = 50
s_t = [
    ["一問も分からなかったのか","お仕置きしてやる"],
    "ほんとはお前みたいなやつには、体力なんていらないと思うんだがな",
    "お情けで1だけ回復してやるよ",
    "それともうひとつアドバイスだ",
    "すぐ下に逃げろ",
    "全間違いはふざけている。地獄を見ろ！",
]

start = Time.new
stop = Time.new
scene = "sans"
sans_scene = 1

Window.loop do
    determination.playing
    encount.playing

    case scene
    when "sans"
        case sans_scene
        when 1
            encount.want_play
            # 効果音も必要
            Window.draw(0,0,black) if count.neo_display(10)
            unless count.neo_display(10)
               heart.draw
                sans.draw
            end
            if  count.get_flames >= 50
                count.reset
                sans_scene = 1.1
            end

        when 1.1
            Window.draw(0,0,black)

            if count.get_flames >= 120
                count.reset
                sans_scene = 2
            end

        when 2
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            mini_heart = Sprite.new((Window.width/2)-6,(Window.height/2)+170/2-25,mini_heart_image)
            Sprite.draw(mini_heart)
            speak_balloon.draw

            sans_txts.sans_auto_return(s_t[0][0]) if text_delay.is_true_frame?
            display_txt = sans_txts.join('')
            Window.draw_font(sans_serif_x, sans_serif_y, display_txt,sans_font,option={color: [255, 20, 20, 20]})

            mini_sans_l.draw
            if count.neo_display(100)
                mini_sans_l.y += mini_sans_float
            else
                mini_sans_l.y -= mini_sans_float
            end
            

            if Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                sans_txts = Messagebox.new
                serifnate.play
                sans_scene = 2.01
            end

        when 2.01
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            mini_heart = Sprite.new((Window.width/2)-6,(Window.height/2)+170/2-25,mini_heart_image)
            Sprite.draw(mini_heart)
            speak_balloon.draw

            sans_txts.sans_auto_return(s_t[0][1]) if text_delay.is_true_frame?
            display_txt = sans_txts.join('')
            Window.draw_font(sans_serif_x, sans_serif_y, display_txt,sans_font,option={color: [255, 20, 20, 20]})

            mini_sans_l.draw
            if count.neo_display(100)
                mini_sans_l.y += mini_sans_float
            else
                mini_sans_l.y -= mini_sans_float
            end
            

            if Input.keyPush?(K_SPACE)
                # megalovania_midi.play
                megalovania.play
                display_txt = Messagebox.new
                sans_txts = Messagebox.new
                sans_scene = 2.1
            end

        when 2.1
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            mini_heart = Sprite.new((Window.width/2)-6,(Window.height/2)+170/2-25,mini_heart_image)
            Sprite.draw(mini_heart)
            speak_balloon.draw

            sans_txts.sans_auto_return(s_t[1]) if text_delay.is_true_frame?
            display_txt = sans_txts.join('')
            Window.draw_font(sans_serif_x, sans_serif_y, display_txt,sans_font,option={color: [255, 20, 20, 20]})

            mini_sans_l.draw
            if count.neo_display(100)
                mini_sans_l.y += mini_sans_float
            else
                mini_sans_l.y -= mini_sans_float
            end
            

            if Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                sans_txts = Messagebox.new
                serifnate.play
                sans_scene = 2.2
            end

        when 2.2
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            mini_heart = Sprite.new((Window.width/2)-6,(Window.height/2)+170/2-25,mini_heart_image)
            Sprite.draw(mini_heart)
            speak_balloon.draw

            sans_txts.sans_auto_return(s_t[2]) if text_delay.is_true_frame?
            display_txt = sans_txts.join('')
            Window.draw_font(sans_serif_x, sans_serif_y, display_txt,sans_font,option={color: [255, 20, 20, 20]})

            mini_sans_l.draw
            if count.neo_display(100)
                mini_sans_l.y += mini_sans_float
            else
                mini_sans_l.y -= mini_sans_float
            end
            

            if Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                sans_txts = Messagebox.new
                cure.play
                sans_scene = 2.3
            end

        when 2.3
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            mini_heart = Sprite.new((Window.width/2)-6,(Window.height/2)+170/2-25,mini_heart_image)
            Sprite.draw(mini_heart)
            speak_balloon.draw
            Sprite.draw(hp_bar)
            Window.draw_font(230,400,"HP 01/03",hp_font)

            sans_txts.sans_auto_return(s_t[3]) if text_delay.is_true_frame?
            display_txt = sans_txts.join('')
            Window.draw_font(sans_serif_x, sans_serif_y, display_txt,sans_font,option={color: [255, 20, 20, 20]})

            mini_sans_l.draw
            if count.neo_display(100)
                mini_sans_l.y += mini_sans_float
            else
                mini_sans_l.y -= mini_sans_float
            end
            

            if Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                sans_txts = Messagebox.new
                serifnate.play
                sans_scene = 2.4
            end

        when 2.4
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            mini_heart = Sprite.new((Window.width/2)-6,(Window.height/2)+170/2-25,mini_heart_image)
            Sprite.draw(mini_heart)
            speak_balloon.draw
            Sprite.draw(hp_bar)
            Window.draw_font(230,400,"HP 01/03",hp_font)

            sans_txts.sans_auto_return(s_t[4]) if text_delay.is_true_frame?
            display_txt = sans_txts.join('')
            Window.draw_font(sans_serif_x, sans_serif_y, display_txt,sans_font,option={color: [255, 20, 20, 20]})

            mini_sans_l.draw
            if count.neo_display(100)
                mini_sans_l.y += mini_sans_float
            else
                mini_sans_l.y -= mini_sans_float
            end
            

            if Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                sans_txts = Messagebox.new
                serifnate.play
                sans_scene = 3
            end

        when 3
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            Sprite.draw(mini_heart)
            Sprite.draw(hp_bar)
            Window.draw_font(230,400,"HP 01/03",hp_font)

            mini_sans_l.draw
            mini_sans_l.x += 2 if mini_sans_l.x <= mini_sans.x
            if count.get_flames >= 50
                mini_sans_l.x = Window.width/2-120
                count.reset
                sans_scene = 4
            end

        # battle
        when 4
            # Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            Sprite.draw(mini_heart)
            mini_sans.draw
            Sprite.draw(hp_bar)
            Window.draw_font(230,400,"HP 01/03",hp_font)

            # blaster
            if count.get_flames > 30 && count.get_flames < 500
                blaster_l.draw
                if count.get_flames >= 380 && count.get_flames <= 390
                    razor_l.draw
                end
                if count.get_flames >= 430
                    Window.draw_alpha(-10,blaster_l_y+10,razor_image,razor_aplha1)
                    razor_aplha1 -= 5 unless razor_aplha1 == 0
                end
            end
            # blaster 2
            if count.get_flames > 230 && count.get_flames < 700
                blaster_r.y = blaster_r_y + 50
                blaster_r.draw
                if count.get_flames >= 580 && count.get_flames <= 590
                    razor_r.y = blaster_r_y+5 + 55
                    razor_r.draw
                end
                if count.get_flames >= 630
                    Window.draw_alpha(razor_r.x,razor_r.y,razor_image,razor_aplha2)
                    razor_aplha2 -= 5 unless razor_aplha2 == 0
                end
            end
            # blaster 3
            if count.get_flames > 430 && count.get_flames < 1100
                blaster_l.y = blaster_l_y + 60
                blaster_l.draw
                if count.get_flames >= 1780 && count.get_flames <= 1790
                    razor_l.y = blaster_l_y+60
                    razor_l.draw
                end
                if count.get_flames >= 30
                    Window.draw_alpha(-10,blaster_l_y+70,razor_image,razor_aplha3)
                    razor_aplha3 -= 5 unless razor_aplha3 == 0
                end
            end

            # blaster発射音
            counts = count.get_flames
            if counts == 407 || counts == 735 || counts == 835
                sans_attack1.play
            end
            p counts

            # sans float
            if count.neo_display(100)
                mini_sans.y += mini_sans_float
            else
                mini_sans.y -= mini_sans_float
            end
            if mini_heart === razor_l || mini_heart === razor_r
                blaster_r.y = Window.height/2
                blaster_l.y = Window.height/2
                razor_aplha1 = 255
                razor_aplha2 = 255
                razor_aplha3 = 255
                razor_aplha4 = 255
                count.reset
                counts = 0
                sans_out.play
                sans_scene = 98
            end
            if Input.keyDown?(K_UP)
                mini_heart.y -= 2
                mini_heart.y += 2 if mini_heart === sans_frames
            end
            if Input.keyDown?(K_DOWN)
                mini_heart.y += 2
                mini_heart.y -= 2 if mini_heart === sans_frames
            end
            if Input.keyDown?(K_RIGHT)
                mini_heart.x += 2
                mini_heart.x -= 2 if mini_heart === sans_frames
            end
            if Input.keyDown?(K_LEFT)
                mini_heart.x -= 2
                mini_heart.x += 2 if mini_heart === sans_frames
            end
            if count.get_flames >= 1150
                blaster_r.y = Window.height/2
                blaster_l.y = Window.height/2
                razor_aplha1 = 255
                razor_aplha2 = 255
                razor_aplha3 = 255
                razor_aplha4 = 255
                count.reset
                counts = 0
                sans_scene = 5
            end

        when 5
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            Sprite.draw(mini_heart)
            Sprite.draw(hp_bar)
            Window.draw_font(230,400,"HP 01/03",hp_font)

            mini_sans.draw
            mini_sans.x -= 3 unless mini_sans.x <= mini_sans_l.x

            if count.get_flames >= 50
                count.reset
                mini_sans.x = mini_sans_x
                sans_scene = 6
            end

        when 6
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            Sprite.draw(mini_heart)
            speak_balloon.draw
            Sprite.draw(hp_bar)
            Window.draw_font(230,400,"HP 01/03",hp_font)

            sans_txts.sans_auto_return(s_t[5]) if text_delay.is_true_frame?
            display_txt = sans_txts.join('')
            Window.draw_font(sans_serif_x, sans_serif_y, display_txt,sans_font,option={color: [255, 20, 20, 20]})

            mini_sans_l.draw
            if count.neo_display(100)
                mini_sans_l.y += mini_sans_float
            else
                mini_sans_l.y -= mini_sans_float
            end

            if Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                sans_txts = Messagebox.new
                serifnate.play
                sans_scene = 7
            end
        when 7 
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            Sprite.draw(mini_heart)
            Sprite.draw(hp_bar)
            Window.draw_font(230,400,"HP 01/03",hp_font)

            mini_sans_l.draw
            mini_sans_l.x += 2 if mini_sans_l.x <= mini_sans.x
            if count.get_flames >= 50
                mini_sans_l.x = Window.width/2-120
                count.reset
                start = Time.now
                sans_scene = 8
            end

        when 8
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            Sprite.draw(mini_heart)
            # sans float
            mini_sans.draw
            Sprite.draw(hp_bar)
            Window.draw_font(230,400,"HP 01/03",hp_font)

            $elapsed_time = counts / 120
            Window.draw_font(70,30,"TIME : #{$elapsed_time}s",hp_font)

            if count.neo_display(100)
                mini_sans.y += mini_sans_float
            else
                mini_sans.y -= mini_sans_float
            end
            if Input.keyDown?(K_UP)
                mini_heart.y -= 2
                mini_heart.y += 2 if mini_heart === sans_frames
            end
            if Input.keyDown?(K_DOWN)
                mini_heart.y += 2
                mini_heart.y -= 2 if mini_heart === sans_frames
            end
            if Input.keyDown?(K_RIGHT)
                mini_heart.x += 2
                mini_heart.x -= 2 if mini_heart === sans_frames
            end
            if Input.keyDown?(K_LEFT)
                mini_heart.x -= 2
                mini_heart.x += 2 if mini_heart === sans_frames
            end
            count.get_flames
            counts = count.get_flames

            Sprite.draw(arrows)
            if counts%55 == 0 || counts == 30 || counts == 100
                arrows << Sprite.new(rand(200..340),-64,arrow_image)
            end
            arrows.each do |a|
                a.collision=[15, 43, 12]
                a.y += 3
            end

            Sprite.draw(arrow_rapid)
            if counts <= 40 && counts >= 10
                arrow_rapid << Sprite.new(-64,rand(322..340),arrow_l_image)
            end
            arrow_rapid.each do |ap|
                ap.collision=[40, 15, 12]
                ap.x += 15
            end

            Sprite.draw(arrows_l)
            if counts%55 == 0
                arrows_l << Sprite.new(-64,rand(200..340),arrow_l_image)
            end
            arrows_l.each do |al|
                al.collision=[40, 15, 12]
                al.x += 4
            end
            if mini_heart === arrows || mini_heart === arrows_l
                Window.draw_font(100,100,"HIT",sans_font)
                count.reset
                counts = 0
                sans_out.play
                sans_scene = 100
            end

            Sprite.draw(arrows_r)
            if counts%60 == 0
                arrows_r << Sprite.new(654,rand(200..340),arrow_r_image)
            end
            arrows_r.each do |ar|
                ar.collision=[24, 15, 12]
                ar.x -= 5 
            end
            if mini_heart === arrows || mini_heart === arrows_l || mini_heart === arrows_r || mini_heart === arrow_rapid
                Window.draw_font(100,100,"HIT",sans_font)
                count.reset
                counts = 0
                sans_out.play
                sans_scene = 100
            end

        when 9
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            Sprite.draw(mini_heart)
            mini_sans.draw
            Sprite.draw(hp_bar)
            Window.draw_font(230,400,"HP 01/03",hp_font)
            if count.get_flames >= 50
                count.reset
                sans_scene = 100
            end

        when 98
            megalovania.want_stop
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            Sprite.draw(mini_heart) if count.get_short_display

            if count.get_flames >= 40
                determination.want_play
                count.reset
                sans_scene = 99
            end

        when 99
            Window.draw(0,0,black)
            sans_gameover.draw
            Window.draw_font(180, 290, "You can't retry this gamemode.",sans_font)
            Window.draw_font(180, 310, "Press SPACE to Exit this game.",sans_font)

            Window.draw_font(230,360,"忠告は聞くもんだぜ",sans_font,option={color: C_WHITE})
            
            if Input.keyPush?(K_SPACE)
                determination.want_stop
                break
            end

        when 100
            megalovania.want_stop
            Window.draw(0,0,black)
            Sprite.draw(sans_frames)
            Sprite.draw(mini_heart) if count.get_short_display

            if count.get_flames >= 40
                determination.want_play
                count.reset
                sans_scene = 101
            end

        when 101
            Window.draw(0,0,black)
            sans_gameover.draw
            Window.draw_font(180, 290, "You can't retry this gamemode.",sans_font)
            Window.draw_font(180, 310, "Press SPACE to Exit this game.",sans_font)
            Window.draw_font(200,350,"TIME : #{$elapsed_time}s",hp_font,option={color: C_WHITE})
            if $elapsed_time == 0
                Window.draw_font(190,380,"いつまでも下にいるんじゃなくて\n             ちゃんとよけろよ",sans_font,option={color: C_WHITE})
            else
                Window.draw_font(150,380,"これにこりたら、次からは「こころ」を読むんだな",sans_font,option={color: C_WHITE})
            end
            if Input.keyPush?(K_SPACE)
                determination.want_stop
                break
            end
        end
    end
end