class Messagebox < Array
    attr_accessor :message, :letters

    def initialize
        @letters_count = 0
        @m_count = 0
        super
    end

    def auto_return(message_array)
        self << "\n" if @letters_count != 0 && @letters_count.modulo(26) == 0
        self << message_array[@letters_count]
        @letters_count += 1
        return self
    end

    def sans_auto_return(message_array)
        self << "\n" if @letters_count != 0 && @letters_count.modulo(9) == 0
        self << message_array[@letters_count]
        @letters_count += 1
        return self
    end

    def read_return(message_array,letters)
        self << "\n" if @letters_count != 0 && @letters_count.modulo(letters) == 0
        self << message_array[@letters_count]
        @letters_count += 1
        return self
    end

end