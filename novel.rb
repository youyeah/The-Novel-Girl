#! ruby -Ku
# -*- mode:ruby; coding:utf-8 -*- 
require 'dxruby'
require 'uri'

Dir[File.expand_path('../novel_classes',__FILE__) << '/*.rb'].each do |file|
    require file
end
Dir[File.expand_path('../messages',__FILE__) << '/*.rb'].each do |file|
    require file
end
t = [
    "",
    "よく来ましたね。ここでは、エンターキーかスペースキーで次の文章を表示できます。",
    "うまく表示できましたね！",
    "今から確認テストを始めます。テストは正誤問題です。",
    "・・・・しっかりと、本は読んでいただけましたか？今回は、夏目漱石の『こころ』の前半について問題を出します。あまり低い点数を取らないように取り組んでくださいね。",
    "では、準備はいいですか？",
    "それでは、第１問です。こころでは、私、先生、K、お嬢さんが主な登場人物です。その先生の奥さんの名前は「静香」でしょうか？",
    "不正解です。本作中では名前を呼ばれる機会が少なく覚えていなかったのかもしれませんね。正解は「静」でした。",
    "正解です。さすがに、引っ掛かりませんでしたね。正しい名前は「静」でした。",
    "では、第２問です。「 魔法棒のために一度に化石されたようなものです。」とあります。これはKの告白を予想できておらず、私の体が硬直してしまうほどの衝撃を隠せなかったことを表現している。",
    "正解です。魔法の杖の魔力によって、化石のように固められてしまった、という比喩表現でした。よくできましたね！",
    "不正解です。魔法の杖の魔力によって、化石のように固められてしまった、という比喩表現でした。１問目に比べて少し難しくなりましたね。",
    "最終問題です。「私」は「先生」の関係は、私は先生のことを心から尊敬をしていて、先生の人生から教訓を受けたいと願い出るようなものである。",
    "大正解です！おめでとうございます。この問題はしっかりと読まないと解けません。今回のテストの内容は、こころの前半部分を扱っていましたので、引き続き文学的作業を続けてください！",
    "間違いです。私がなぜ先生のもとへ通い話を聞いているのかをよく読み解いてください",
    "・・・・・実は、まだできていません。また今度いらっしゃってください。"

]

width = Window.width/2
height = Window.height/2
title_image = Image.load('./images/title.png')
title_shadow_image = Image.load('./images/title_shadow.png')
title_back_image = Image.load('./images/title_back.jpg')
title = Sprite.new(-10, 50, title_image)
title_shadow = Sprite.new(-5, 52,  title_shadow_image)
title_back = Sprite.new(0, 0, title_back_image)
titles = [title_back, title]
library_image = Image.load('./images/library.jpg')
library_back = Sprite.new(0, 0, library_image)

game_start_image = Image.load('./images/game_start.png')
game_start = Sprite.new(180, 300, game_start_image)
read_active_image = Image.load('./images/read_active.png')
read_active = Sprite.new(230, 300, read_active_image)
read_image = Image.load('./images/read.png')
read = Sprite.new(230, 300, read_image)
test_active_image = Image.load('./images/test_active.png')
test_active = Sprite.new(230, 340, test_active_image)
test_image = Image.load('./images/test.png')
test = Sprite.new(230, 340, test_image)
quite_active_image = Image.load('./images/quite_active.png')
quite_active = Sprite.new(230, 380, quite_active_image)
quite_image = Image.load('./images/quite.png')
quite = Sprite.new(230, 380, quite_image)
ready_image = Image.load('./images/ready.png')
ready = Sprite.new(65, 380, ready_image)
ready.alpha = 60
ready_alpha = 2

# title フォント設定
Font.install('./fonts/komorebi-gothic.ttf')
font = Font.new(20,font_name="ヒラギノ角ゴシック W1",option={weight: 600})
komorebi_font = Font.new(20,font_name="木漏れ日ゴシック")
komorebi_font_heavy = Font.new(20,font_name="木漏れ日ゴシック",option={weight: 600})

# title_load    default font settings
font_size_title = 20
font_title_x = 190
font_title_y = 300
title_load_alpha = 0

# MUSIC
opening_music = Music.new('./musics/tw008.mid')
test_music = Music.new('./musics/valse.mid')
read_music = Music.new('./musics/k-nocturn2.mid')
game_start_se = Music.new('./musics/game_start.wav')
game_start_se.set_volume(180, time=0)
mode_start_se = Music.new('./musics/mode_start.wav')
select_se = Music.new('./musics/select_se.wav')
seikai = Music.new('./musics/q_seikai.wav')
hazure = Music.new('./musics/q_hazure.wav')
inception = Music.new('./musics/inception.wav')
ejection_se = Music.new('./musics/ejection.wav')
ejection_se.set_volume(180, time=0)

# title selecter
selecter_image = Image.load('./images/book_shiori.png')
s_icon_x = 190
s_icon_y = 0    # selecterの位置によって変動する
selecter = 1
selecter_back_image = Image.load('./images/selecter_back.png')
sb_x = 225
sb_y = 0

# fumichan
fumichan_image = Image.load('./images/fumichan.png')
fumichan_x = 230
fumichan_y = 0
fumichan = Sprite.new(fumichan_x, fumichan_y,fumichan_image)
title_load_alpha2 = 255

# maru batsu
maru_image = Image.load('./images/maru.png')
maru_x = 20
maru_y = 170
maru = Sprite.new(maru_x, maru_y, maru_image)
maru.center_x = 70
maru.center_y = 70
batsu_image = Image.load('./images/batsu.png')
batsu_x = 200
batsu_y = 170
batsu = Sprite.new(batsu_x,batsu_y,batsu_image)
batsu.center_x = 70
batsu.center_y = 70

# serif frame
serif_frame_image = Image.load('./images/serif_frame.png')
serif_frame = Sprite.new(5.5, 290, serif_frame_image)

# serif
serif_x = 53
serif_y = 348
serif = "こんにちは"
serif_s = []
serif_s << serif.split

txt_count = 0
txts = []
s_message = Messagebox.new
test_txts = Messagebox.new
splited_txt = "めっちゃ冗長で、無駄に長く、果てしなく意味がなく、暇つぶしのためのテストメッセージ１２３４５６７８９０"
splited_txt.split
display_txt = nil

classroom_image = Image.load('./images/class_room.jpg',100,100)
classroom_back = Sprite.new(0,0,classroom_image)
classroom_backs = [classroom_back, fumichan]

# 画面暗転　黒色加算合成
black = Image.new(600, 450, C_BLACK)
black_back = Sprite.new(0,0,black)

Window.width = 590
Window.height = 440

count = CountingFlames.new
text_delay = DisplayFrame.new

one = 1 # １。便利に使う用
scaling = 0.002 # scaleの値を増やすための変数
test_select = 1 # 〇×問題の選んでる最中の変数。１が〇で、２が×

scene = "attention1"
menu = nil
text_count = 1
page_count = 1
m_count = 0

score = 0 # テストスコア

# WebBrowser.open 'https://www.google.co.jp/'

Window.loop do

    opening_music.playing
    read_music.playing
    test_music.playing
    ejection_se.play_once

    case scene
    when "attention1"
        black_back.draw
        Window.draw_font(50,100,"注意：このゲームは音が出ます",komorebi_font)
        Window.draw_font(50,150,"音量に注意してください",komorebi_font)
        Window.draw_font(50,200,"操作：矢印キー、エンター、スペースを用います",komorebi_font)
        if count.get_flames >= 250 || Input.keyPush?(K_SPACE)
            count.reset
            scene = "attention2"
        end

    when "attention2"
        black_back.draw
        Window.draw_font(50,100,"注意：このゲームは音が出ます",komorebi_font)
        Window.draw_font(50,150,"音量に注意してください",komorebi_font)
        Window.draw_font(50,200,"操作：矢印キー、エンター、スペースを用います",komorebi_font)

        title_load_alpha +=5  unless title_load_alpha == 225
        Window.draw_alpha(0,0,black,title_load_alpha)

        # black_back.draw if count.get_flames >= 30
        if count.get_flames >= 40
            count.reset
            title_load_alpha = 0
            scene = "before_title"
        end

    when "before_title"
        opening_music.want_play
        title_back.draw
        if count.get_flames >= 150
            Window.draw_alpha(-5, 52,  title_shadow_image,title_load_alpha)
            Window.draw_alpha(-10, 50, title_image,title_load_alpha)
            title_load_alpha += 1
        end

        Window.draw_alpha(0,0,black,title_load_alpha2)
        title_load_alpha2 -= 1 unless title_load_alpha2 == 0

        if count.get_flames >= 550 || Input.keyPush?(K_SPACE)
            title_load_alpha2 = 255
            count.reset
            scene = "title"
        end


    when "title"
        read_music.want_stop
        test_music.want_stop
        opening_music.want_play
        title_back.draw
        title_shadow.draw
        title.draw
        game_start.draw if count.get_display
        scene = "btw_title_and_select" if Input.keyPush?(K_SPACE)

    when "btw_title_and_select"
        game_start_se.play
        title_back.draw
        title_shadow.draw
        title.draw
        game_start.draw if count.get_short_display
        if count.get_flames >= 40
            count.reset
            scene = "mode_select"
            menu = 1
        end

    when "mode_select"
        case menu
        when 1
            title_back.draw
            title_shadow.draw
            title.draw
        
            s_icon_y = 300
            selecter_icon = Sprite.new(s_icon_x, s_icon_y, selecter_image)
            selecter_icon.draw
            sb_y = 298
            selecter_back = Sprite.new(sb_x, sb_y, selecter_back_image)
            selecter_back.draw

            read_active.draw
            test.draw
            quite.draw

            if Input.keyPush?(K_DOWN)
                select_se.play
                menu = 2
            end

            if Input.keyPush?(K_RETURN) || Input.keyPush?(K_SPACE)
                opening_music.want_stop
                read_music.want_play
                scene = "mode_select1_load"
                menu = 0
            end

        when 2
            title_back.draw
            title_shadow.draw
            title.draw

            s_icon_y = 335
            selecter_icon = Sprite.new(s_icon_x, s_icon_y, selecter_image)
            selecter_icon.draw
            sb_y = 335
            selecter_back = Sprite.new(sb_x, sb_y, selecter_back_image)
            selecter_back.draw

            read.draw
            test_active.draw
            quite.draw

            if Input.keyPush?(K_UP)
                select_se.play
                menu = 1
            end
            if Input.keyPush?(K_DOWN)
                select_se.play
                menu = 3
            end

            if Input.keyPush?(K_RETURN) || Input.keyPush?(K_SPACE)
                opening_music.want_stop
                test_music.want_play
                mode_start_se.play
                scene = "mode_select2_load"
                menu = 0
            end

        when 3
            title_back.draw
            title_shadow.draw
            title.draw

            s_icon_y = 375
            selecter_icon = Sprite.new(s_icon_x, s_icon_y, selecter_image)
            selecter_icon.draw
            sb_y = 375
            selecter_back = Sprite.new(sb_x, sb_y, selecter_back_image)
            selecter_back.draw

            read.draw
            test.draw
            quite_active.draw

            if Input.keyPush?(K_UP)
                select_se.play
                menu = 2
            end
            break if Input.keyPush?(K_RETURN) || Input.keyPush?(K_SPACE)
        end

    # 暗転　本番
    when "mode_select1_load"
        title_back.draw
        title_shadow.draw
        title.draw
        
        s_icon_y = 300
        selecter_icon = Sprite.new(s_icon_x, s_icon_y, selecter_image)
        selecter_icon.draw
        sb_y = 298
        selecter_back = Sprite.new(sb_x, sb_y, selecter_back_image)
        selecter_back.draw

        read_active.draw
        test.draw
        quite.draw

        title_load_alpha += 2 unless title_load_alpha == 250
        Window.draw_alpha(0,0,black,title_load_alpha)
        if count.get_flames >= 120
            title_load_alpha = 0
            count.reset
            scene = "before_read"
        end
    
    when "mode_select2_load"
        title_back.draw
        title_shadow.draw
        title.draw

        s_icon_y = 335
        selecter_icon = Sprite.new(s_icon_x, s_icon_y, selecter_image)
        selecter_icon.draw
        sb_y = 335
        selecter_back = Sprite.new(sb_x, sb_y, selecter_back_image)
        selecter_back.draw

        read.draw
        test_active.draw
        quite.draw

        title_load_alpha += 2 unless title_load_alpha == 250
        Window.draw_alpha(0,0,black,title_load_alpha)
        if count.get_flames >= 120
            title_load_alpha = 0
            count.reset
            scene = "before_test"
        end

    # 暗転サンプル
    when "title_load"
        Sprite.draw(titles)
        font_size_title += 0.02
        font_title_x -= 0.01
        font_title_y -= 0.1
        font_title = Font.new(font_size_title)
        Window.draw_font(font_title_x, font_title_y,"Press SPACE to START !!",font_title)
        title_load_alpha += 2
        Window.draw_alpha(0,0,black,title_load_alpha)
        scene = "title_load2" if count.get_flames >= 120

    # 明転
    when "before_test"
        Sprite.draw(classroom_backs)
        Window.draw_alpha(0,0,black,title_load_alpha2)
        title_load_alpha2 -= 1 unless title_load_alpha2 == 0
        if count.get_flames >= 255
            count.reset
            title_load_alpha2 = 255
            scene = "test"
        end

    when "test画面の開発環境的なやつ"
        Sprite.draw(classroom_backs)
        serif_frame.draw
        
        if text_delay.is_true_frame?
            if txt_count != 0 &&  txt_count.modulo(20) == 0
                txts << "\n"
            end
            txts << splited_txt[txt_count]
            txt_count += 1
        end
        p txts.join('')
        display_txt = txts.join('')
        Window.draw_font(serif_x, serif_y, display_txt,font)

    when "before_read"
        library_back.draw
        Window.draw_alpha(0,0,black,title_load_alpha2)
        title_load_alpha2 -= 1 unless title_load_alpha2 == 0
        if count.get_flames >= 250
            title_load_alpha2 = 255
            count.reset
            scene = "read"
        end

    when "read"
        case page_count
        when 1
            library_back.draw
            Window.draw_font(30, 200,"こころが読みたいなら、SPACE",komorebi_font_heavy)
            Window.draw_font(30, 240,"そうでないなら、ESC",komorebi_font_heavy)
            scene = "before_title" if Input.keyPush?(K_ESCAPE)
            WebBrowser.open 'https://www.aozora.gr.jp/cards/000148/files/773_14560.html' if Input.keyPush?(K_SPACE)
        end

    when "test"
        case text_count
        when 1
            Sprite.draw(classroom_backs)
            serif_frame.draw
        
            test_txts.auto_return(t[1]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)
            if Input.keyPush?(K_RETURN) || Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                ejection_se.wanna_play_once
                text_count = 2
            end
            if Input.keyPush?(K_ESCAPE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                scene = "title"
                text_count = 1
            end

        when 2
            Sprite.draw(classroom_backs)
            serif_frame.draw
        
            test_txts.auto_return(t[2]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)
            if Input.keyPush?(K_RETURN) || Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                ejection_se.wanna_play_once
                text_count = 3
            end
            if Input.keyPush?(K_ESCAPE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                ejection_se.wanna_play_once
                scene = "title"
                text_count = 1
            end

        when 3
            Sprite.draw(classroom_backs)
            serif_frame.draw
        
            test_txts.auto_return(t[3]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)
            if Input.keyPush?(K_RETURN) || Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                ejection_se.wanna_play_once
                text_count = 4
            end
            if Input.keyPush?(K_ESCAPE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                ejection_se.wanna_play_once
                scene = "title"
                text_count = 1
            end

        when 4
            Sprite.draw(classroom_backs)
            serif_frame.draw
        
            test_txts.auto_return(t[4]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)
            if Input.keyPush?(K_RETURN) || Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                ejection_se.wanna_play_once
                text_count = 5
            end
            if Input.keyPush?(K_ESCAPE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                ejection_se.wanna_play_once
                scene = "title"
                text_count = 1
            end

        when 5
            Sprite.draw(classroom_backs)
            serif_frame.draw

            
            ready.draw if count.get_flames >= 400
            ready.alpha -= ready_alpha
            if ready.alpha == 250
                 ready_alpha = ready_alpha * -1
            elsif ready.alpha == 50
                ready_alpha = ready_alpha * -1
            end
        
            test_txts.auto_return(t[5]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)

            if Input.keyPush?(K_SPACE)
                count.reset
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                ejection_se.wanna_play_once
                text_count = 6
            end
            if Input.keyPush?(K_ESCAPE)
                count.reset
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                ejection_se.wanna_play_once
                scene = "title"
                text_count = 1
            end

        when 6
            Sprite.draw(classroom_backs)
            serif_frame.draw

            # t_6 問題第1問
            test_txts.auto_return(t[6]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)

            if test_select == 1
                maru.scale_x=(one)
                maru.scale_y=(one)
                maru.alpha=(255)
                batsu.alpha=(120)
                one += scaling
                if maru.scale_x >= 1.1
                    scaling = -0.002
                elsif maru.scale_x <= 0.9
                    scaling = 0.002
                end
            end
            if test_select == 2
                batsu.scale_x=(one)
                batsu.scale_y=(one)
                batsu.alpha=(255)
                maru.alpha=(120)
                one += scaling
                if batsu.scale_x >= 1.1
                    scaling = -0.002
                elsif batsu.scale_x <= 0.9
                    scaling = 0.002
                end
            end

            if Input.keyPush?(K_RIGHT)
                select_se.play
                maru.scale_x=(1)
                maru.scale_y=(1)
                scaling = 0.002
                test_select = 2
            end
            if Input.keyPush?(K_LEFT)
                select_se.play
                batsu.scale_x=(1)
                batsu.scale_y=(1)
                scaling = 0.002
                test_select = 1
            end

            maru.draw
            batsu.draw

            if Input.keyPush?(K_RETURN) || Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                ejection_se.wanna_play_once
                if test_select == 1
                    hazure.wanna_play_once
                    text_count = 7
                elsif test_select == 2
                    score += 1
                    seikai.wanna_play_once
                    test_select = 1
                    text_count = 8
                end
            end

        when 7
            hazure.play_once
            Sprite.draw(classroom_backs)
            serif_frame.draw

            test_txts.auto_return(t[7]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)

            if Input.keyPush?(K_SPACE)
                ejection_se.wanna_play_once
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                text_count = 9
            end

        when 8
            seikai.play_once
            Sprite.draw(classroom_backs)
            serif_frame.draw

            test_txts.auto_return(t[8]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)

            if Input.keyPush?(K_SPACE)
                ejection_se.wanna_play_once
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                text_count = 9
            end

        when 9
            Sprite.draw(classroom_backs)
            serif_frame.draw

            # 問題第2問
            test_txts.auto_return(t[9]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)

            if test_select == 1
                maru.scale_x=(one)
                maru.scale_y=(one)
                maru.alpha=(255)
                batsu.alpha=(120)
                one += scaling
                if maru.scale_x >= 1.1
                    scaling = -0.002
                elsif maru.scale_x <= 0.9
                    scaling = 0.002
                end
            end
            if test_select == 2
                batsu.scale_x=(one)
                batsu.scale_y=(one)
                batsu.alpha=(255)
                maru.alpha=(120)
                one += scaling
                if batsu.scale_x >= 1.1
                    scaling = -0.002
                elsif batsu.scale_x <= 0.9
                    scaling = 0.002
                end
            end

            if Input.keyPush?(K_RIGHT)
                select_se.play
                maru.scale_x=(1)
                maru.scale_y=(1)
                scaling = 0.002
                test_select = 2
            end
            if Input.keyPush?(K_LEFT)
                select_se.play
                batsu.scale_x=(1)
                batsu.scale_y=(1)
                scaling = 0.002
                test_select = 1
            end

            maru.draw
            batsu.draw

            if Input.keyPush?(K_RETURN) || Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                ejection_se.wanna_play_once
                if test_select == 1
                    score += 1
                    seikai.wanna_play_once
                    text_count = 10
                elsif test_select == 2
                    hazure.wanna_play_once
                    test_select = 1
                    text_count = 11
                end
            end

        when 10
            seikai.play_once
            Sprite.draw(classroom_backs)
            serif_frame.draw

            test_txts.auto_return(t[10]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)

            if Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                text_count = 12
            end

        when 11
            
            hazure.play_once
            Sprite.draw(classroom_backs)
            serif_frame.draw

            test_txts.auto_return(t[11]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)

            if Input.keyPush?(K_SPACE)
                ejection_se.wanna_play_once
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                text_count = 12
            end

        when 12
            Sprite.draw(classroom_backs)
            serif_frame.draw

            # 問題第2問
            test_txts.auto_return(t[12]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)

            if test_select == 1
                maru.scale_x=(one)
                maru.scale_y=(one)
                maru.alpha=(255)
                batsu.alpha=(120)
                one += scaling
                if maru.scale_x >= 1.1
                    scaling = -0.002
                elsif maru.scale_x <= 0.9
                    scaling = 0.002
                end
            end
            if test_select == 2
                batsu.scale_x=(one)
                batsu.scale_y=(one)
                batsu.alpha=(255)
                maru.alpha=(120)
                one += scaling
                if batsu.scale_x >= 1.1
                    scaling = -0.002
                elsif batsu.scale_x <= 0.9
                    scaling = 0.002
                end
            end

            if Input.keyPush?(K_RIGHT)
                select_se.play
                maru.scale_x=(1)
                maru.scale_y=(1)
                scaling = 0.002
                test_select = 2
            end
            if Input.keyPush?(K_LEFT)
                select_se.play
                batsu.scale_x=(1)
                batsu.scale_y=(1)
                scaling = 0.002
                test_select = 1
            end

            maru.draw
            batsu.draw

            if Input.keyPush?(K_RETURN) || Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                ejection_se.wanna_play_once
                if test_select == 1
                    seikai.wanna_play_once
                    score += 1
                    text_count = 13
                elsif test_select == 2
                    hazure.wanna_play_once
                    test_select = 1
                    text_count = 14
                end
            end

        when 13
            seikai.play_once
            Sprite.draw(classroom_backs)
            serif_frame.draw

            test_txts.auto_return(t[13]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)

            if Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                if score == 3
                    score = 0
                    text_count = 1
                    test_music.want_stop
                    inception.wanna_play_once
                    scene = "before_true"
                elsif score == 2 || score == 1
                    score = 0
                    text_count = 1
                    scene = "before_normal"
                elsif score == 0
                    text_count = 1
                    scene = "before_bad"
                end
            end

        when 14
            hazure.play_once
            Sprite.draw(classroom_backs)
            serif_frame.draw

            test_txts.auto_return(t[14]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)

            if Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                if score == 2 || score == 1
                    score = 0
                    text_count = 1
                    scene = "before_normal"
                elsif score == 0
                    text_count = 1
                    scene = "before_bad"
                end
            end

        when 100 # test未完成
            Sprite.draw(classroom_backs)
            serif_frame.draw
        
            test_txts.auto_return(t[6]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)
            if Input.keyPush?(K_ESCAPE) || Input.keyPush?(K_SPACE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                text_count = 1
                scene = "before_title"
            end
            if Input.keyPush?(K_ESCAPE)
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                text_count = 1
                scene = "before_title"
            end

        end
        
    when "before_true"
        inception.play_once
        black_back.draw
        Window.draw_font_ex(190,210,"満点です",komorebi_font,option={shadow: true})
        
        if count.get_flames >= 300
            title_load_alpha +=5  unless title_load_alpha == 255
            Window.draw_alpha(0,0,black,title_load_alpha)
        end

        if count.get_flames >= 650
            count.reset
            title_load_alpha = 0
            inception.wanna_play_once
            scene = "before_true2"
        end

    when "before_true2"
        inception.play_once
        black_back.draw
        Window.draw_font_ex(170,210,"TRUE END",komorebi_font,option={shadow: true})
        
        if count.get_flames >= 300
            title_load_alpha +=5  unless title_load_alpha == 255
            Window.draw_alpha(0,0,black,title_load_alpha)
        end

        if count.get_flames >= 650
            count.reset
            title_load_alpha = 0
            scene = "true"
        end

    end

end