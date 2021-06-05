chord_map = {}
chord_map["A2"] = :a2
chord_map["Db"] = :db3
chord_map["E"] = :e3
chord_map["A"] = :a3

define :translate do |accum:, chords:, repeat: 1|
  ar = chords.split(" ")
  repeat.times{ar.each{|e| accum.push(chord_map[e])}}
end

a = 4.0
use_synth_defaults attack_level: 1.2, decay_level: 1, sustain_level: 1
duration_factor = 1.5
dec = 0.4*duration_factor
sus = 0.3*duration_factor
rel = 0.3*duration_factor

use_bpm 33

unit_sec = 0.25

##| Drum
uncomment do
  define :drum_sample do |b|
    sample :drum_snare_soft, amp: a*0.7 if (b == "1")
    sample :drum_cymbal_closed, amp: a*0.6 if (b == "2")
    sample :drum_snare_hard, amp: a*0.5 if (b == "3")
    sleep unit_sec
  end
  
  live_loop :drum do
    [
      "1232",
    ].each {|beats|
      beats.length.times {|i| drum_sample beats[i]}
    }
  end
end

##| Bass
uncomment do
  define :bass_synth do |ac, t|
    with_fx :reverb, room: 1, mix: 0.5 do
      with_fx :rlpf, mix: 0.5 do
        synth :fm, note: ac, amp: a*0.6, decay: t*dec, sustain: t*sus, release: t*rel, depth: 0.3, divisor: 2.0
        sleep t
      end
    end
  end
  
  live_loop :bass do
    chords_string = [
      "A2 Db E A ",
    ]
    atime = [
      [unit_sec*4.0]*4,
    ]
    chords_string.each_with_index {|chords, i|
      achord = []
      translate accum: achord, chords: chords
      achord.each_with_index {|ac, j| bass_synth ac, atime[i][j]}
    }
  end
end

##| Guitar
uncomment do
  gt = unit_sec*16.0
  dt = 0.025
  chd = chord(:a1, :M)+chord(:a3, :M)
  chd = chd.reverse
  cl = chd.length
  live_loop :guitar do
    with_fx :reverb, room: 1, mix: 0.5 do
      with_fx :nrlpf, mix: 0.5 do
        with_fx :rhpf, mix: 0.3 do
          with_fx :flanger, mix: 0.5, phase: 4 do
            with_fx :distortion, mix: 0.5, distort: 0.6 do
              with_synth :pluck do
                ##| play chd, amp: a*cl*1.0, decay: gt*dec, sustain: gt*sus, release: gt*rel, coef: 0.1
                ##| sleep gt
                play_pattern_timed chd, dt, amp: a*1.0, decay: gt*dec, sustain: gt*sus, release: gt*rel, coef: 0.1
                sleep gt-dt*cl
              end
            end
          end
        end
      end
    end
  end
end
