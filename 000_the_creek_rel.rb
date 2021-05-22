chord_map = {}
chord_map["EM"] = (chord :e3, :M)
chord_map["AM"] = (chord :a3, :M)
chord_map["BM"] = (chord :b3, :M)

define :translate do |accum:, chords:, repeat: 1|
  ar = chords.split(" ")
  repeat.times{ar.each{|e| accum.push(chord_map[e])}}
end

use_synth :pluck
use_synth_defaults attack_level: 1.0, decay_level: 1, sustain_level: 1, coef: 0.1
duration_factor = 1.0
dec = 0.3*duration_factor
sus = 0.6*duration_factor
rel = 0.1*duration_factor

num_chord = 6
e_part = "EM "*num_chord
a_part = "AM "*num_chord
b_part = "BM "*num_chord
e4b4_part = e_part*4 + b_part*4
chords_string = [
  ##| ("EM EM EM EM EM EM "*4 + "BM BM BM BM BM BM "*4)*2,
  ##| "AM AM AM AM AM AM "*4 + "EM EM EM EM EM EM "*2 + "BM BM BM BM BM BM "*2,
  ##| "EM EM EM EM EM EM "*4 + "BM BM BM BM BM BM "*4
  e4b4_part*2,
  a_part*4 + e_part*2 + b_part*2,
  e4b4_part
]
ws_1st = 0.28
atime = [ws_1st, 0.41, 0.14, 0.11, 0.10, 0.03]
num_picks = [0, 0, 2, 2, 2, 2]

a = 4.0
tl = atime.length
live_loop :l1 do
  with_fx :reverb, room: 1, mix: 0.5 do
    with_fx :rhpf, mix: 0.3 do
      ws = 0.0
      chords_string.each {|e|
        puts e
        achord = []
        translate accum: achord, chords: e
        i = 0
        achord.each { |ac|
          t = atime[i%tl]
          cd = ac
          cs = 1
          cs = cd.length if cd.instance_of?(SonicPi::Core::RingVector)
          if num_picks[i%tl] != 0 && cs != 1
            cs = num_picks[i%tl]
            cd = cd.pick(cs)
            ##| cd = cd.reverse.take(cs)
            ##| cd = cd.take(cs)
          end
          
          with_swing ws, pulse: num_chord do
            play cd, amp: a*cs, decay: t*dec*cs, sustain: t*sus*cs, release: t*rel*cs
          end
          ws = ws_1st
          sleep t
          i += 1
        }
      }
    end
  end
end