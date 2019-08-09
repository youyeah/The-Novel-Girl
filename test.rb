require 'dxruby'

Window.width=1280
Window.height=720

txt_area = Image.new(1280,720,color=[0,0,0,0])

font=Font.new(32) # "ＭＳ ゴシック"

txt_ary = Array.new

px=30
py=400
row=0

File.open('./test.txt') do |file|
    txt_ary = file.readlines
end

@countframes = 0

Window.loop do

    @countframes += 1
    if @countframes%30 == 0
        if row < txt_ary.length
            txt_area.draw_font(px,py,txt_ary[row],font)
            row = row + 1
            py = py + 50
        end
    end

    Window.draw(0,0,txt_area)

end