class CountingFlames
    attr_accessor :switch_counts

    def initialize
        @count = 0
        @short_count = 0
        @display = true
        @short_display = true
        @count_all = 0
    end

    def get_display
        @count += 1
        if @count >= 60
            @display = !@display
            @count = 0
        end
        return @display
    end

    def get_short_display
        @short_count += 1
        if @short_count >= 3
            @short_display = !@short_display
            @short_count = 0
        end
        return @short_display
    end

    def neo_display(switch_counts)
        @short_count += 1
        if @short_count >= switch_counts
            @short_display = !@short_display
            @short_count = 0
        end
        return @short_display
    end
    
    def get_flames
        @count_all += 1
        return @count_all
    end

    def reset
        @count_all = 0
    end

end

class DisplayFrame
    attr_accessor :num

    def initialize
        @dt_count = 0
        @display_frame = false
    end

    def is_true_frame?
        if @dt_count == 2
            @dt_count = 0
            @display_frame = true
        else
            @dt_count += 1
            @display_frame = false
        end
        return @display_frame
    end

    def hackable_true_frame(num)
        if @dt_count == num
            @dt_count = 0
            @display_frame = true
        else
            @dt_count += 1
            @display_frame = false
        end
        return @display_frame
    end
end