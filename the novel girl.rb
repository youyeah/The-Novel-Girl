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
Window.width = 590
Window.height = 440

Font.install('./fonts/rounded-mplus-1c-black.ttf')
sans_font = Font.new(20,"Rounded M+ 1c black")
sans_big_font = Font.new(40,"Rounded M+ 1c black")
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

megalovania = Music.new('./musics/MEGALOVANIA-origin.wav')
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
dog_song = Music.new('./musics/dogsong.wav')
dog_song.loop_count=(-1)

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
cure_arrow_image = Image.load('./bad_images/cure_arrow.png')
arrows = []
arrows_l = []
arrows_r = []
arrow_rapid = []
cure_arrows = []
counts = 0
dog1_i = Image.load('./bad_images/dog1.png')
dog2_i = Image.load('./bad_images/dog2.png')
dog3_i = Image.load('./bad_images/dog3.png')
dog4_i = Image.load('./bad_images/dog4.png')
dog1 = Sprite.new(50,250,dog1_i)
dog2 = Sprite.new(200,220,dog2_i)
dog3 = Sprite.new(370,260,dog3_i)
dog4 = Sprite.new(400,230,cure_arrow_image)
dogs = [dog1,dog2,dog3,dog4]

sans_txts = Messagebox.new
display_txt = Messagebox.new
text_delay = DisplayFrame.new
sans_serif_x = 340
sans_serif_y = 70
s_t = [
    ["ほんとうに一問も分からなかったのか？","わざと間違えて、俺様に会いに来たんじゃないだろうな？"],
    "１つもわからなかったお前にHPなんてあげられないんだけど.....",
    "仕方ないから1だけ回復してやるよ！",
    "それともうひとつアドバイスだ",
    "すぐ下に逃げろ",
    "ここからが地獄だぜえええ！精一杯よけ続けるんだな！",
]

start = Time.new
stop = Time.new
sans_scene = 1

t = [
    "",
    "よく来ましたね。ここでは、スペースキーで次の文章を表示できます。",
    "うまく表示できましたね！",
    "今から確認テストを始めます。テストは正誤問題です。",
    "・・・・しっかりと、本は読んでいただけましたか？今回は、夏目漱石の『こころ』の前半について問題が出ます。あまり低い点数を取らないように取り組んでくださいね。",
    "では、準備はいいですか？",
    "それでは、第１問です。こころでは、私、先生、K、お嬢さんが主な登場人物です。その先生の奥さんの名前は「静香」でしょうか？",
    "不正解です。本作中では名前を呼ばれる機会が少なく覚えていなかったのかもしれませんね。正解は「静」でした。",
    "正解です。さすがに、引っ掛かりませんでしたね。正しい名前は「静」でした。",
    "では、第２問です。「 魔法棒のために一度に化石されたようなものです。」とあります。これはKの告白を予想できておらず、私の体が硬直してしまうほどの衝撃を隠せなかったことを表現している。",
    "正解です。魔法の杖の魔力によって、化石のように固められてしまった、という比喩表現でした。よくできましたね！",
    "不正解です。魔法の杖の魔力によって、化石のように固められてしまった、という比喩表現でした。１問目に比べて少し難しくなりましたね。",
    "最終問題です。「私」は「先生」の関係は、私は先生のことを心から尊敬をしていて、先生の人生から教訓を受けたいと願い出るようなものである。",
    "大正解です！おめでとうございます。この問題はしっかりと読まないと解けません。今回のテストの内容は、こころの前半部分を扱っていましたので、引き続き文学的作業を続けてください！",
    "間違いです。私がなぜ先生のもとへ通い話を聞いているのかをよく読み解いてください。",
    "惜しいです！あとちょっとで全問正解だったのですが。。諦めずにまた挑戦してくださいね"

]
r = [
    "私は大学生ですが、まじめな学生ではなく教授の言葉には魅力を覚えることができませんでした。しかしそこに現れたのは先生です。先生は仕事待たず、人間との交流も少ない隠居状態の人ですが、この人の言葉、思想に私は極端に引かれ、毎日のように先生の家に通うようになります。そこにいるのは当然奥さんです。彼女は先生の冷たい態度を見るたびに、先生は自分を嫌っているのではないかと心配しています。先生の思想に惚れ込んだ私は先生の過去を知りたくなります。そこで名言、先生「私の過去を暴いてでもですか。」ここで先生は人間不信であることが分かり、先生の口から過去の話がつらつらと語られます。"
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
d_arrow_r_image = Image.load('./images/d_arrow_right.png')
d_arrow_r = Sprite.new(Window.width - 75, 5 , d_arrow_r_image)
d_arrow_l_image = Image.load('./images/d_arrow_left.png')
d_arrow_l = Sprite.new(5, 5 , d_arrow_l_image)
read_t = "図書館に来た。すぐ右に行ったところに夏目漱石の「こころ」がある。少し読んでみようかな...."

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
ending_song = Music.new('./musics/ending.wav')

# title selecter
selecter_image = Image.load('./images/book_shiori.png')
s_icon_x = 190
s_icon_y = 0    # selecterの位置によって変動する
selecter = 1
selecter_back_image = Image.load('./images/selecter_back.png')
sb_x = 225
sb_y = 0

read_paper_image = Image.load('./images/book_paper.png')
read_paper = Sprite.new(215,20,read_paper_image)
read_paper_l = Sprite.new(Window.width + 200,20,read_paper_image)
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
display_txt = nil
summary_txt = nil

classroom_image = Image.load('./images/class_room.jpg',100,100)
classroom_back = Sprite.new(0,0,classroom_image)
classroom_backs = [classroom_back, fumichan]

# 画面暗転　黒色加算合成
black = Image.new(600, 450, C_BLACK)
black_back = Sprite.new(0,0,black)

count = CountingFlames.new
text_delay = DisplayFrame.new

one = 1 # １。便利に使う用
scaling = 0.002 # scaleの値を増やすための変数
test_select = 1 # 〇×問題の選んでる最中の変数。１が〇で、２が×

# caseの対象達
scene = "attention1"
menu = nil
text_count = 1
page_count = 1
m_count = 0
rand_counts = 0

score = 0 # テストスコア

# trueエンド（エンドロール用素材）
staffs = []
staff1 = Image.load('./images/staff1.png')
badendsozai = Image.load('./images/badendsozai.png')
karitasozai = Image.load('./images/karitasozai.png')
sozaiya = Image.load('./images/sozaiya.png')
maou = Image.load('./images/maou.png')
ut = Image.load('./images/UT.png')
thanks = Image.load('./images/thanks.png')
staffs << Sprite.new(175,Window.height+40,staff1)
staffs << Sprite.new(175,Window.height+240,karitasozai)
staffs << Sprite.new(175, Window.height+340,maou)
staffs << Sprite.new(175,Window.height+440,sozaiya)
staffs << Sprite.new(175, Window.height+640,badendsozai)
staffs << Sprite.new(175, Window.height+740,ut)
staffs << Sprite.new(75,Window.height+1040, thanks)

Window.caption=("文豪美少女")
Window.loop do

    opening_music.playing
    read_music.playing
    test_music.playing
    ejection_se.play_once
    determination.playing
    encount.playing
    dog_song.playing
    megalovania.playing
    ending_song.playing

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
            title_load_alpha += 1 unless title_load_alpha == 255
        end

        Window.draw_alpha(0,0,black,title_load_alpha2)
        title_load_alpha2 -= 1 unless title_load_alpha2 == 0

        if count.get_flames >= 550 || Input.keyPush?(K_SPACE)
            title_load_alpha2 = 255
            count.reset
            scene = "title"
        end


    when "title"
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
            if Input.keyDown?(K_DOWN) && Input.keyPush?(K_ESCAPE)
                opening_music.want_stop
                scene = "sans"
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
            d_arrow_r.draw
            serif_frame.draw
            test_txts.auto_return(read_t) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)
            Window.draw_font(20,20,"戻る(ESC)",sans_font)
            if Input.keyPush?(K_ESCAPE)
                read_t = "図書館に来た。すぐ右に行ったところに夏目漱石の「こころ」がある。少し読んでみようかな...."
                display_txt = nil
                test_txts = Messagebox.new
                read_music.want_stop
                scene = "before_title"
            end
            if Input.keyPush?(K_RIGHT)
                read_t = "図書館に来た。すぐ右に行ったところに夏目漱石の「こころ」がある。少し読んでみようかな...."
                display_txt = nil
                test_txts = Messagebox.new
                page_count = 2
            end

        when 2
            library_back.draw
            read_paper_l.draw
            unless read_paper_l.x <= 225
                read_paper_l.x -= 20
            end
            if read_paper_l.x <= 225
                read_paper_l.x = Window.width + 200
                page_count = 3
            end

        when 2.1
            library_back.draw
            read_paper_l.draw
            unless read_paper_l.x >= Window.width + 200
                read_paper_l.x += 20
            end
            if read_paper_l.x >= Window.width + 200
                page_count = 1
            end

        when 3
            library_back.draw
            read_paper.draw
            d_arrow_l.draw
            Window.draw_font(30, 160,"こころ",sans_big_font)
            Window.draw_font(30, 200,"夏目漱石",sans_big_font)
            Window.draw_font(30, 240,"あらすじ",sans_big_font)
            Window.draw_font(30, 330,"SPACEを押して",sans_font)
            Window.draw_font(30, 342,"青空文庫を表示",sans_font)
            Window.draw_font(30, 365,"ESCAPEで戻る",sans_font)

            test_txts.read_return(r[0],15) if text_delay.hackable_true_frame(2)
            summary_txt = test_txts.join#('')
            Window.draw_font(240,33, summary_txt,komorebi_font,option={color: [255,25,25,25]})

            WebBrowser.open 'https://www.aozora.gr.jp/cards/000148/files/773_14560.html' if Input.keyPush?(K_SPACE)
            if Input.keyPush?(K_ESCAPE)
                test_txts = Messagebox.new
                read_music.want_stop
                scene = "before_title"
            end
            if Input.keyPush?(K_LEFT)
                test_txts = Messagebox.new
                read_paper_l.x = 225
                page_count = 2.1
            end

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
                    test_music.want_stop
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
                    text_count = 15
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
                    text_count = 15
                elsif score == 0
                    text_count = 1
                    scene = "sans"
                end
            end

        when 15
            Sprite.draw(classroom_backs)
            serif_frame.draw

            test_txts.auto_return(t[15]) if text_delay.is_true_frame?
            display_txt = test_txts.join('')
            Window.draw_font(serif_x, serif_y, display_txt,font)

            if Input.keyPush?(K_SPACE)
                test_music.want_stop
                display_txt = Messagebox.new
                test_txts = Messagebox.new
                score = 0
                text_count = 1
                scene = "before_title"
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
        Window.caption=("")
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
        Window.caption=("")
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

    when "sans"
        case sans_scene
        when 1
            Window.caption=("BadEnd")
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
            
            counts = count.get_flames

            if Input.keyPush?(K_SPACE) && counts >= 120
                # megalovania_midi.play
                megalovania.want_play
                counts = 0
                count.reset
                display_txt = Messagebox.new
                sans_txts = Messagebox.new
                sans_scene = 2.1
            end

        when 2.1
            megalovania.want_play
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
            if counts%100 == 0 || counts == 30 || counts == 100
                arrows << Sprite.new(rand(200..340),-64,arrow_image)
            end
            arrows.each do |a|
                a.collision=[15, 43, 12]
                a.y += 3
            end

            Sprite.draw(arrow_rapid)
            if counts <= 40 && counts >= 5
                arrow_rapid << Sprite.new(-64,rand(322..350),arrow_l_image)
            end
            arrow_rapid.each do |ap|
                ap.collision=[40, 15, 12]
                ap.x += 13
            end

            Sprite.draw(arrows_l)
            if counts%100 == 0
                arrows_l << Sprite.new(-64,rand(200..350),arrow_l_image)
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
            if counts%100 == 0
                arrows_r << Sprite.new(654,rand(200..350),arrow_r_image)
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

            Sprite.draw(cure_arrows)
            rand_counts = rand(0..150)
            if rand_counts == 0 && counts >= 120
                cure_arrows << Sprite.new(-60, rand(200..350), cure_arrow_image)
            end
            cure_arrows.each do |c|
                c.x += 10
                if count.neo_display(100)
                    c.y += 3
                else
                    c.y -= 33
                end
            end
            if mini_heart === cure_arrows
                Window.caption=("??? end")
                megalovania.stop
                sans_scene = 200
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
            Window.draw_font(180, 270, "Press SPACE to Exit this game.",sans_font)
            Window.draw_font(180, 290, "          If you want to retry",sans_font)
            Window.draw_font(130, 310, "press the DOWN-key and press the SPACE-key",sans_font)
            Window.draw_font(235, 330, "in mode selection",sans_font)
            Window.draw_font(262,360,"TIME : #{$elapsed_time}s",hp_font,option={color: C_WHITE})
            if $elapsed_time == 0
                Window.draw_font(190,390,"いつまでも下にいるんじゃなくて\n             ちゃんとよけるんだな",sans_font,option={color: C_WHITE})
            elsif $elapsed_time >= 10
                Window.draw_font(160,390,"曲とか気に入ったらUnderTale買ってくれよ",sans_font,option={color: C_WHITE})
            else
                Window.draw_font(135,390,"これに懲りたら、次からは「こころ」を読むんだな",sans_font,option={color: C_WHITE})
            end
            if Input.keyPush?(K_SPACE) || Input.keyPush?(K_ESCAPE)
                determination.want_stop
                break
            end

        when 200
            Window.caption=("??? end")
            dog_song.want_play
            Window.draw(0,0,black)
            Window.draw_font(70, 170, "Dogs are your GOOD Friends !",sans_big_font) if count.get_display
            Sprite.draw(dogs)
            break if Input.keyPush?(K_ESCAPE)
        
        end

    when "true"
        Window.caption=("HAPPY END")
        ending_song.want_play
        black_back.draw
        Sprite.draw(staffs)

        count.get_flames
        counts = count.get_flames
        if counts <= 1300*4
            staffs.each do |s|
                s.y -= 0.5
            end
        end
        if counts >= 1400*4
            Window.draw_font(120,270,"Special thanks for you !",sans_big_font)
            Window.draw_font(180,320,"please SPACE to close window",sans_font) if count.get_display
            break if Input.keyPush?(K_SPACE)
        end


    end

end