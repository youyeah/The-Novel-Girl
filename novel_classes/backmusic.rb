class Music < Sound

    def initialize(path)
        @play_once = false
        @should_play = false
        @already_played = false
        super
    end

    def want_play
        @should_play = true
    end

    def playing
        if @should_play && not(@already_played)
            @already_played = true
            self.play
        elsif @should_play && @already_played
            # return p " this song is playing now"
        end
    end

    def playing_now?
        return @already_played
    end

    def want_stop
        @should_play = false
        @already_played = false
        self.stop
    end
    
    def wanna_play_once
        @play_once = true
    end
    
    def play_once
        if @play_once
            @play_once = false
            self.play
        end
    end
end