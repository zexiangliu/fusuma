module Fusuma
  # manage actions
  class GestureInfo
    def initialize(finger, direction, action_type)
      @finger      = finger.to_i
      @direction   = direction
      @action_type = action_type
    end
    attr_reader :finger, :direction, :action_type

    def trigger_keyevent(history)
      shortc = shortcut
      unless shortc.nil?
             case history
	     when "mousedown 1"
		if(@finger >=3)
                   shortc = "mouseup 1"
		end
	      when "keydown alt+Tab keyup Tab"
		hist = history
		if(@finger == 4 && @direction == "left")
                   shortc = "Tab"
		elsif (@finger == 4 && @direction == "right")
		   shortc = "shift+Tab"
		elsif (shortc == history||@finger == 4 && @direction == 'up')
		   shortc = "Escape keyup alt"
		   hist = "exit"
		elsif (@finger == 4 && @direction == "down")
	 	   shortc = "keyup alt"
		   hist = "exit"
		else
		   shortc = "keyup alt key #{shortc}"
		   hist = "exit"
		end
             	exec_xdotool(shortc)
		return hist
	      when "super+s"
		if(shortc == "shift+super+w")
		    shortc = history 
		end
		shortc += " "
	      when "shift+super+w"
		if(shortc == "super+s")
		    shortc = history 
		end
		shortc += " "
	      when "super+a"
		if(shortc == "super+a")
		    shortc = "super" 
		end
		shortc += " "
	      when "super"
		if(shortc == "super+A")
		    shortc = history 
		end
		shortc += " "
	      end

        end

      exec_xdotool(shortc)
      shortc
    end

    private

    def exec_xdotool(keys)
      `xdotool key #{keys}` unless keys.nil?
    end

    def shortcut
      Config.shortcut(self)
    end
  end
end
