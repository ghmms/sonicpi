use_bpm 85
use_synth :piano
unit_sec = 0.25
a = 0.5
duration_factor = 2.0
att = 0.02*duration_factor
dec = 0.3*duration_factor
sus = 0.3*duration_factor
rel = 0.4*duration_factor

define :part_1st do
  with_fx :reverb, room: 0.8, mix: 0.5 do
    2.times {
      [:fs6, :f6, :db6].each {|key|
        t = (ring 0.8, 0.8, 0.6, 0.8, 0.6, 0.6).tick(:r1)
        play key, amp: a*2, attack: t*att, decay: t*dec, sustain: t*sus, release: t*rel
        sleep t
      }
    }
  end
end

define :part_2nd do |append_chord, cue_trigger, thread_trigger|
  in_thread(sync: :thread_cue) {part_1st} if thread_trigger
  t = unit_sec
  ##| indices=[3,2,1,2]
  indices=[3,1,0,1]
  [:b4, :a4, :a4, :b4].each_with_index {|key, i|
    chd = chord(key, :M7)
    with_fx :reverb, room: 0.6, mix: 0.45 do
      play (ring :b3, :b3, :a3, :ds4).tick(:r2), amp: a*0.5, attack: t*att, decay: t*dec*8, sustain: t*sus*8, release: t*rel*8
      4.times { |n|
        play chd[indices[0]], amp: a*1.5, attack: t*att, decay: t*dec, sustain: t*sus, release: t*rel
        indices.each_with_index { |c, j|
          cue :drum_cue if cue_trigger && i == 3 && n == 2 && j == 2
          cue :thread_cue if thread_trigger && i == 3 && n == 0 && j == 0
          play chd[c], amp: a, attack: t*att, decay: t*dec, sustain: t*sus, release: t*rel
          if append_chord && n == 3 && j == 1
            sleep t*0.1
            play chd[indices[0]], pitch: 20, amp: a*2, decay: t*dec*0.50, sustain: t*sus*0.50, release: t*rel*0.5
            sleep t*0.9
          else
            sleep t
          end
        }
      }
    end
  }
end

define :part_3rd do |append_chord, thread_trigger, noise_amp_coef|
  in_thread {part_1st} if thread_trigger
  t = unit_sec
  ##| scl = (scale :b2, :major)
  scl = (scale :bs2, :major)
  indices = [0,1,2,3,2,1,0,1]
  with_fx :reverb, room: 0.6, mix: 0.45 do
    indices.each {|i|
      synth :cnoise, amp: a*noise_amp_coef, attack: t*att*0.1, decay: t*dec*0.5, sustain: t*sus*0.125, release: t*rel*0.125 if append_chord
      play scl[i], amp: a*1.5, attack: t*att*10, decay: t*dec, sustain: t*sus, release: t*rel
      sleep t
    }
  end
end

live_loop :drum do
  sync :drum_cue
  with_fx :reverb, room: 0.5, mix: 0.45 do
    [
      "111111",
      "2011002020100000"*7,
      "2011002020111111",
      "3011003030100000"*7,
      "3011003030141111",
      "5000000505000005",
      "5000005050050000",
      "5000000505000005",
      "5000005050000000",
      "5000000000000000"*3,
      "500000006000",
      "2002000020002000"*3,
      "0000000000000000",
      "2012070720127777",
      "2012070788887000",
      "2012070720127777",
      "2012070720121111",
    ].each {|beats|
      beats.length.times {|j|
        t = unit_sec
        b = beats[j]
        sample :elec_cymbal, amp: a*0.5, rate: 0.7, decay: t*0.1, sustain: t*0.1, release: t*0.1 if (["1","4"].include?(b))
        sample :bd_haus, amp: a*1.5 if b == "2"
        sample :drum_cymbal_closed, amp: a*1.5 if b == "2"
        sample :bd_haus, amp: a*2.0 if (["3","4"].include?(b))
        sample :bass_hit_c, amp: a*3.5, rate: 0.8 if b == "5"
        if b == "6"
          dt = t*0.5
          8.times { sample :elec_blup, amp: a*2; sleep dt }
        end
        sample :elec_cymbal, amp: a*0.5, rate: 1.2, decay: t*0.1, sustain: t*0.1, release: t*0.1 if b == "7"
        if b == "8"
          2.times {sample :elec_cymbal, amp: a*0.5, rate: 1.2, decay: t*0.1, sustain: t*0.1, release: t*0.1; sleep t*0.5}
          next
        end
        sleep t
      }
    }
  end
end

live_loop :main do
  part_1st
  
  part_2nd false, true, false
  2.times { part_2nd true, false, false }
  
  14.times { part_3rd false, false, 0 }
  part_3rd false, true, 0
  part_3rd false, false, 0
  4.times { part_3rd true, false, 0.2 }
  2.times { part_3rd true, false, 0.6 }
  part_3rd true, true, 0.2
  part_3rd true, false, 0.2
  4.times { part_3rd true, false, 0.2 }
  2.times { part_3rd true, false, 0.6 }
  part_3rd true, true, 0.2
  part_3rd true, false, 0.2
  
  2.times { part_2nd false, false, true }
  
  ##| stop
  sleep 5
end