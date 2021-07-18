chord_map = {}
chord_map["R"] = :r
chord_map["E3"] = :e3
chord_map["D3#"] = :ds3
chord_map["G3#"] = :gs3
chord_map["A3"] = :a3
chord_map["C4b"] = :cb4
chord_map["E4"] = :e4
chord_map["E4m"] = (chord :e4, :m)
chord_map["G4#"] = :gs4
chord_map["A4"] = :a4

define :translate do |accum:, chords:, repeat: 1|
  ar = chords.split(" ")
  repeat.times{ar.each{|e| accum.push(chord_map[e])}}
end

a = 5.0
use_synth_defaults attack_level: 1.0, decay_level: 1, sustain_level: 1

bass_duration_factor = 1.2
batt = 0.1*bass_duration_factor
bdec = 0.3*bass_duration_factor
bsus = 0.3*bass_duration_factor
brel = 0.3*bass_duration_factor

guitar_duration_factor = 2.0
gdec = 0.4*guitar_duration_factor
gsus = 0.4*guitar_duration_factor
grel = 0.2*guitar_duration_factor

use_bpm 58
unit_sec = 0.25

##| Drum
uncomment do
  define :drum_sample do |b|
    sample :drum_cymbal_closed, amp: a*1.0 if (b == "1")
    sample :drum_snare_soft, amp: a*2.5, rate: 1.5 if (b == "2")
    sample :drum_snare_hard, amp: a*1.0, rate: 1.5 if (b == "3")
    sleep unit_sec*0.9
  end
  
  live_loop :drum do
    sync :guitar_cue
    [
      "10101010"*4,
      "20302030"*8,
    ].each_with_index {|beats, i| beats.length.times {|j| drum_sample beats[j]}}
  end
end

##| Bass
uncomment do
  live_loop :bass do
    sync :guitar_cue
    cptn1 = "A3 "*16+"G3# "*16
    cptn2 = "E3 "*16+"D3# "*16
    tptn = [unit_sec*0.9]*33
    [
      [cptn1, tptn],
      [cptn2, tptn],
      [cptn1, tptn],
    ].each_with_index {|ct, i|
      achord = []
      translate accum: achord, chords: ct[0]
      achord.each_with_index {|ac, j|
        t = ct[1][j]
        synth :fm, note: ac, amp: a*1.0, attack: t*batt, decay: t*bdec, sustain: t*bsus, release: t*brel, depth: 0.3
        sleep t
      }
    }
  end
end

##| Guitar
uncomment do
  define :guitar_synth do |ac, t, cl, amp, dur|
    with_fx :reverb, room: 0.8, mix: 0.5 do
      with_fx :tremolo, mix: 0.32, depth: 0.7, phase: 0.05 do
        synth :pluck, note: ac, amp: a*1.5*cl+amp, decay: t*(gdec+dur), sustain: t*(gsus+dur), release: t*(grel+dur), coef: 0.1
        sleep t
      end
    end
  end
  
  live_loop :guitar do
    cptn1 = "A3 A4 A3 G4# "*4+"G3# G4# G3# E4 "*3+"G3# G4# G3# E4m "
    cptn2 = "E3 E4m E3 C4b "+"E3 E4 E3 C4b "*7
    cptn3 = "E3 E4m E3 E4m "+"E3 E4 E3 C4b "*2+"E3 E4 E3 E4m "+"E4m R E4m R "*4
    tptn = [unit_sec*0.8, unit_sec]*16
    [
      [cptn1, tptn],
      [cptn2, tptn],
      [cptn1, tptn],
      [cptn3, tptn],
    ].each_with_index {|ct, i|
      cue :guitar_cue if (i == 1)
      
      achord = []
      translate accum: achord, chords: ct[0]
      achord.each_with_index {|ac, j|
        t = ct[1][j]
        cl = 1
        cl = ac.length if ac.instance_of?(SonicPi::Core::RingVector)
        
        amp = 1.5*((i == 3) ? 1 : (j%2))
        dur = (i == 3) ? 0.125*Math::log(1.0+j.to_f) : 0.0
        amp += dur
        if (j%2 == 1 || (i == 3 && j > 16))
          guitar_synth ac, t, cl, amp, dur
        else
          with_fx :reverb, room: 0.8, mix: 0.5 do
            synth :pluck, note: ac, amp: a*0.8*cl+amp, decay: t*(gdec+dur), sustain: t*(gsus+dur), release: t*(grel+dur), coef: 0.1
            sleep t
          end
        end
      }
    }
    sleep 2
  end
end
