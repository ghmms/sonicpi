use_bpm 60
unit_sec = 0.25
a = 4

##| 8 beat Drum 1
comment do
  live_loop :drum do
    [
      "10201020"*3,
      "10201223"*1,
    ].each {|beats|
      beats.length.times {|i|
        b = beats[i]
        sample :drum_cymbal_closed, amp: a #hihat
        sample :drum_bass_hard, amp: a if (["1"].include?(b))
        sample :drum_snare_hard, amp: a if (["2", "3"].include?(b))
        sample :drum_cymbal_hard, amp: a if (["3"].include?(b))
        sleep unit_sec
      }
    }
  end
end

##| 8 beat Drum 2
comment do
  live_loop :drum do
    [
      "10201020"*3,
      "10201334"*1,
    ].each {|beats|
      beats.length.times {|i|
        b = beats[i]
        sample :bd_ada, amp: a*2.0
        sample :bd_haus, amp: a*1.0 if (b == "1")
        sample :bd_haus, amp: a*2.0 if (["2","3","4"].include?(b))
        sample :drum_snare_hard, amp: a if (["3","4"].include?(b))
        sample :drum_cymbal_hard, amp: a if (b == "4")
        sleep unit_sec
      }
    }
  end
end

##| 16 beat Drum 1
uncomment do
  live_loop :drum do
    [
      "1000200010002000"*3,
      "1000200010202030"*1,
      "1004200112002000"*3,
      "1004200112202030"*1,
    ].each {|beats|
      beats.length.times {|i|
        b = beats[i]
        sample :drum_cymbal_closed, amp: a #hihat
        sample :drum_bass_hard, amp: a if (["1"].include?(b))
        sample :drum_snare_hard, amp: a if (["2", "3"].include?(b))
        sample :drum_cymbal_hard, amp: a if (["3"].include?(b))
        sample :bd_haus, amp: a*1.0 if (b == "4")
        sleep unit_sec*0.5
      }
    }
  end
end

