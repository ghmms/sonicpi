chord_map = {}
chord_map["E1"] = :e1
chord_map["F1#"] = :fs1
chord_map["A1"] = :a1
chord_map["B1"] = :b1
chord_map["C2#"] = :cs2
chord_map["D2"] = :d2
chord_map["E2"] = :e2
chord_map["F2"] = :f2
chord_map["F2#"] = :fs2
chord_map["G2"] = :g2
chord_map["A2"] = :a2
chord_map["A2#"] = :as2
chord_map["B2"] = :b2
chord_map["C3"] = :c3
chord_map["C3#"] = :cs3
chord_map["D3"] = :d3
chord_map["D3#"] = :ds3
chord_map["E3"] = :e3
chord_map["F3"] = :f3
chord_map["F3"] = :f3
chord_map["F3#"] = :fs3
chord_map["G3#"] = :gs3
chord_map["A3"] = :a3
chord_map["B3"] = :b3
chord_map["C4#"] = :cs4
chord_map["D4#"] = :ds4
chord_map["E4"] = :e4
chord_map["D2B2"] = (ring :d2, :b2)
chord_map["A2B2"] = (ring :a2, :b2)
chord_map["B2G3#"] = (ring :b2, :gs3)

define :translate do |accum:, chords:, repeat: 1|
  ar = chords.split(" ")
  repeat.times{ar.each{|e| accum.push(chord_map[e])}}
end

a = 4.0
use_synth_defaults attack_level: 1.0, decay_level: 1, sustain_level: 1

bass_duration_factor = 1.5
bdec = 0.3*bass_duration_factor
bsus = 0.3*bass_duration_factor
brel = 0.4*bass_duration_factor

guitar_duration_factor = 2.5
gatt = 0.05*guitar_duration_factor
gdec = 0.35*guitar_duration_factor
gsus = 0.3*guitar_duration_factor
grel = 0.3*guitar_duration_factor

use_bpm 130
unit_sec = 0.25

##| Drum
uncomment do
  define :drum_sample do |b|
    t = unit_sec
    if (b =~ /[[:digit:]]/)
      sample :drum_snare_hard, amp: a*2.0, rate: 1.5 if (b == "1")
      sample :drum_tom_mid_hard, amp: a*3.0, rate: 1.0 if (b == "1")
      sample :drum_heavy_kick, amp: a*5.0 if (b == "2")
    elsif (b =~ /[[:alpha:]]/)
      if (b == "a")
        sample :drum_bass_hard, amp: a*3.5
        t *= 0.8
      elsif (b == "b")
        sample :drum_bass_soft, amp: a*3.5
        t *= 2.2
      end
    end
    sleep t
  end
  
  live_loop :drum do
    [
      ("11ababab"+"aba10110"),
      ("20020020"+"10001000"+"20020020"+"10001100")*2,
      ("20020020"+"10001100"),
      ("11020020"+"10001000"),
      ("20020020"+"10001000"+"20020020"+"10001000"),
      ("20020020"+"10001100"),
      ("11020020"+"10001000"),
      ("20020020"+"10001100"),
      ("11020020"+"10000000"),
      ("20020020"+"10001000"),
      ("11020020"+"10001100"),
      ("20020020"+"10001100")*3,
      ("10001000"+"20002200"),
      ("20020020"+"10001100")*3,
      ("10001000"+"11022011"),
    ].each_with_index {|beats, i|
      cue :drum_cue if (i == 1)
      beats.length.times {|j| drum_sample beats[j]}
    }
    sleep 2
  end
end

##| Bass
uncomment do
  live_loop :bass do
    sync :drum_cue
    s075 = unit_sec*3.0
    s100 = unit_sec*4.0
    s300 = unit_sec*12.0
    s325 = unit_sec*13.0
    s500 = unit_sec*16.0
    cpattern1 = "C3 C3 C3 C3 "
    cpattern2 = "E3 E3 F3 F3 "
    cpattern3 = "E3 D3 C3 B2 "
    tpattern1 = [s325, s100, s075, s300]
    tpattern2 = [s500, s500, s500, s500]
    [
      [cpattern1*2, tpattern1*2],
      [cpattern2*1, tpattern1*1],
      [cpattern1*2, tpattern1*2],
      [cpattern2*1, tpattern1*1],
      [cpattern1*1, tpattern1*1],
      [cpattern3*2, tpattern2*2],
    ].each_with_index {|ct, i|
      achord = []
      translate accum: achord, chords: ct[0]
      achord.each_with_index {|ac, j|
        t = ct[1][j]
        synth :fm, note: ac, amp: a*0.4, attack_level: 6.0, decay: t*bdec, sustain: t*bsus, release: t*brel, depth: 0.3
        sleep t
      }
    }
  end
end

##| Guitar
uncomment do
  live_loop :guitar do
    sync :drum_cue
    pattern1 = "E1 D2 E2 F2# F2# B2 F2# G2 A2 F2# D2 E2 A1 D2 F2# A1 "
    pattern2 = "A1 A2 B2 D2 A2 F3  G2 A2 B2G3# D2B2 A2 B2G3# D2B2 A2 B2G3# A2B2 "
    pattern3 = "E1 D2 E2 F2 F2# F2# B2 F2# G2 A2 F2# D2 E2 A1 D2 F2# A1 "
    pattern4 = "A1 D2 B2 D2 A2 F3  G2 A2 B2G3# "
    pattern5 = "C2# E4 E3 D4# E4  E3 D4# E4  E3 D4# E4 E3 D4# E4  E3 "
    pattern6 = "B1 B3  B2 G3# B3 B2 G3# B3  B2 G3# B3 B2 G3# B3 B2 "
    pattern7 = "A1 C4# E3 D3# C4# E3 D3# C4# E3  D3# C4# E3  D3# C4# E3 "
    pattern8 = "A1 C4# E3  F1# E3 F3#  A2# C3 E3 G2  A2# A3 E3 C3#  G3# B3 "
    [
      [pattern1*4, [unit_sec]*16*4],
      [pattern2*2, [unit_sec]*16*2],
      [pattern1*2, [unit_sec]*16*2],
      [pattern3,   [unit_sec*16.0/17.0]*17],
      [pattern1,   [unit_sec]*16],
      [pattern2,   [unit_sec]*16],
      [pattern4,   [unit_sec]*8+[unit_sec*8.0]],
      [pattern1*2, [unit_sec]*16*2],
      [pattern5,   [unit_sec*16.0/15.0]*15],
      [pattern6,   [unit_sec*16.0/15.0]*15],
      [pattern7,   [unit_sec*16.0/15.0]*15],
      [pattern8,   [unit_sec*(16.0-1.25)/15.0]*15+[unit_sec*1.25]],
      [pattern5,   [unit_sec*16.0/15.0]*15],
      [pattern6,   [unit_sec*16.0/15.0]*15],
      [pattern7,   [unit_sec*16.0/15.0]*15],
      [pattern8,   [unit_sec*(16.0-1.25)/15.0]*15+[unit_sec*1.25]],
    ].each_with_index {|ct, i|
      achord = []
      translate accum: achord, chords: ct[0]
      achord.each_with_index {|ac, j|
        t = ct[1][j]
        s = synth :pluck, note: ac, amp: a*3.0, pitch: 12, attack: t*gatt, decay: t*gdec, sustain: t*gsus, release: t*grel, coef: 0.1
        sleep t
        kill s
      }
    }
  end
end
