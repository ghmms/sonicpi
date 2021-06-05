chord_map = {}
chord_map["Cb"] = :cb4
chord_map["Db"] = :db4
chord_map["Eb"] = :eb4
chord_map["Ebm"] = (chord :eb4, :m)
chord_map["E"] = :e4
chord_map["Gb"] = :gb4
chord_map["Ab"] = :ab4
chord_map["B"] = :b4
chord_map["Db5"] = :db5

define :translate do |accum:, chords:, repeat: 1|
  ar = chords.split(" ")
  repeat.times{ar.each{|e| accum.push(chord_map[e])}}
end

a = 4.0
use_synth_defaults attack_level: 1.0, decay_level: 1, sustain_level: 1
duration_factor = 1.0
dec = 0.4*duration_factor
sus = 0.3*duration_factor
rel = 0.3*duration_factor

use_bpm 68

unit_sec = 0.25
s05 = unit_sec*2.0
s10 = unit_sec*4.0
s15 = unit_sec*6.0
s20 = unit_sec*8.0
s25 = unit_sec*10.0

##| Drum
uncomment do
  num_loop = 0
  define :drum_sample do |b|
    t = unit_sec
    b = "2" if (b =~ /[[:alpha:]]/ && num_loop > 0)
    if (b =~ /[[:digit:]]/)
      sample :drum_snare_soft, amp: a*2.0 if (["1","3"].include?(b))
      sample :drum_snare_hard, amp: a*2.0 if (b == "2")
      sample :drum_splash_hard, amp: a*2.0, release: 3.0 if (b == "3" && num_loop == 0)
    elsif (b == "a")
      dt = 0.04
      2.times do
        sample :drum_snare_soft, amp: a*6
        sleep dt
      end
      t -= dt*2
    end
    sleep t
  end
  
  live_loop :drum do
    [
      ("30102012"+"12102010"),
      ("10102012"+"12102010")*2,
      ("10102012"+"1210a000"),
    ].each {|beats|
      beats.length.times {|i| drum_sample beats[i]}
    }
    num_loop += 1
  end
end

##| Bass
uncomment do
  define :bass_synth do |ac, t|
    with_fx :reverb, room: 1, mix: 0.5 do
      synth :fm, note: ac, pitch: -6, amp: a*0.3, decay: t*dec, sustain: t*sus, release: t*rel, depth: 0.3, divisor: 4.0
      sleep t
    end
  end
  
  live_loop :bass, sync: :drum do
    chords_string = [
      "Eb Ab Ab E Eb Eb Eb Eb Ab Ab "*3,
      "Eb Ab Ab E Eb Eb Eb Ab ",
    ]
    atime = [
      ##| [2.5, 1.0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1.0, 0.5]*3,
      ##| [2.5, 1.0, 0.5, 0.5, 0.5, 0.5, 0.5, 2.0],
      [s25, s10, s05, s05, s05, s05, s05, s05, s10, s05]*3,
      [s25, s10, s05, s05, s05, s05, s05, s20],
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
  define :guitar_synth do |ac, t|
    with_fx :reverb, room: 1, mix: 0.5 do
      with_fx :nrlpf, mix: 0.3 do
        with_fx :rlpf do
          with_fx :rhpf, mix: 0.3 do
            with_fx :ping_pong, mix: 0.4, phase: 0.25, feedback: 0.3 do
              synth :pluck, note: ac, amp: a*2, decay: t*dec, sustain: t*sus, release: t*rel, coef: 0.1
              sleep t
            end
          end
        end
      end
    end
  end
  
  live_loop :guitar, sync: :drum do
    chords_string = [
      "Db B Ab E Gb E Gb E ",
      "Db B Ab E Gb E Cb E Gb Eb E ",
      "Db B Ab E Gb E Gb E ",
      "Db B Db5 B Gb E Ebm ",
    ]
    atime = [
      ##| [0.5, 1.5, 0.5, 1.5, 0.5, 1.5, 0.5, 1.5],
      ##| [0.5, 1.5, 0.5, 1.5, 0.5, 1.0, 0.5, 0.5, 0.5, 0.5, 0.5],
      ##| [0.5, 1.5, 0.5, 1.5, 0.5, 1.5, 0.5, 1.5],
      ##| [0.5, 1.5, 0.5, 1.5, 0.5, 1.5, 2.0],
      [s05, s15, s05, s15, s05, s15, s05, s15],
      [s05, s15, s05, s15, s05, s10, s05, s05, s05, s05, s05],
      [s05, s15, s05, s15, s05, s15, s05, s15],
      [s05, s15, s05, s15, s05, s15, s20],
    ]
    chords_string.each_with_index {|chords, i|
      achord = []
      translate accum: achord, chords: chords
      achord.each_with_index {|ac, j| guitar_synth ac, atime[i][j]}
    }
  end
end
