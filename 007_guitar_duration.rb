chord_map = {}
chord_map[":Ds2"] = :Ds2
chord_map[":F2"] = :F2
chord_map[":Fs2"] = :Fs2
chord_map[":G2"] = :G2
chord_map[":Gs2"] = :Gs2
chord_map[":A2"] = :A2
chord_map[":As2"] = :As2
chord_map[":Cs3"] = :Cs3
chord_map[":Ds3"] = :Ds3
chord_map[":E3"] = :E3
chord_map[":F3"] = :F3
chord_map[":Fs3"] = :Fs3
chord_map[":G3"] = :G3
chord_map[":Gs3"] = :Gs3
chord_map[":A3"] = :A3
chord_map[":As3"] = :As3
chord_map[":B3"] = :B3
chord_map[":C4"] = :C4
chord_map[":Cs4"] = :Cs4
chord_map[":D4"] = :D4
chord_map[":F4"] = :F4
chord_map[":Fs4"] = :Fs4
chord_map[":G4"] = :G4
chord_map[":Gs4"] = :Gs4
chord_map[":A4"] = :A4
chord_map[":As4"] = :As4
chord_map[":B4"] = :B4
chord_map[":C5"] = :C5
chord_map[":D5"] = :D5
chord_map[":Ds5"] = :Ds5
chord_map[":F5"] = :F5
chord_map["UD0"] = (ring :Ds4, :As3, :Fs3)
chord_map["UD1"] = (ring :Ds5, :As4, :Ds3)
chord_map["UD3"] = (ring :As3, :Fs3, :Cs3, :Gs2)
chord_map["UD8"] = (ring :Fs3, :Cs3)
chord_map["UD10"] = (ring :B3, :Fs3)
chord_map["UD11"] = (ring :Ds4, :B3, :Gs3)
chord_map["UD14"] = (ring :Fs4, :Cs4)
chord_map["UD19"] = (ring :Cs4, :As3)
chord_map["UD21"] = (ring :Cs4, :B3)
chord_map["UD31"] = (ring :Ds4, :B3)
chord_map["UD47"] = (ring :As3, :Ds3)
chord_map["UD49"] = (ring :Gs3, :Fs3)
chord_map["UD50"] = (ring :Cs4, :Gs3)
chord_map["UD54"] = (ring :Cs4, :Gs3, :Fs3)
chord_map["UD55"] = (ring :Cs4, :Gs3, :Ds3)
chord_map["UD58"] = (ring :C5, :F4)
chord_map["UD59"] = (ring :Cs5, :Gs4, :Cs4)
chord_map["UD60"] = (ring :C5, :F4, :Cs4)
chord_map["UD62"] = (ring :As4, :Gs4)
chord_map["UD63"] = (ring :As4, :F4)
chord_map["UD64"] = (ring :F4, :Cs4, :As3)
chord_map["UD68"] = (ring :Cs4, :A3)
chord_map["UD69"] = (ring :D5, :As2, :As3, :D4, :F3)
chord_map["UD70"] = (ring :Ds2, :G3)
chord_map["UD71"] = (ring :G5, :Ds3)
chord_map["UD72"] = (ring :C5, :E3, :C4)
chord_map["UD73"] = (ring :A4, :E2)
chord_map["UD74"] = (ring :A4, :F2, :A3, :C4, :C3)
chord_map["UD75"] = (ring :F4, :Ds3)
chord_map["UD76"] = (ring :F5, :D2, :F4, :F3)
chord_map["UD77"] = (ring :D3, :Gs3)
chord_map["UD78"] = (ring :C3, :Gs3)
chord_map["UD79"] = (ring :C2, :F4)
chord_map["UD80"] = (ring :B1, :G3)
chord_map["UD81"] = (ring :Gs4, :B2)
chord_map["UD82"] = (ring :C5, :G2)
chord_map["UD83"] = (ring :F5, :G3)
chord_map["UD84"] = (ring :Ds5, :C2, :G3, :Ds4, :Ds3)
chord_map["UD85"] = (ring :C3, :C4)
chord_map["UD86"] = (ring :As2, :C4)
chord_map["UD87"] = (ring :As1, :Ds4)
chord_map["UD88"] = (ring :A1, :F3)
chord_map["UD89"] = (ring :G4, :A2)
chord_map["UD90"] = (ring :As4, :F2)
chord_map["UD91"] = (ring :Ds5, :F3)
chord_map["UD92"] = (ring :D5, :As2, :As3, :D4)
chord_map["UD93"] = (ring :E5, :A2, :C4)
chord_map["UD94"] = (ring :As4, :G2, :As3, :D4)
chord_map["UD95"] = (ring :As4, :G3)
chord_map["UD96"] = (ring :D5, :E3, :G3)
chord_map["UD97"] = (ring :C5, :C3, :As3, :C4)
chord_map["UD98"] = (ring :A4, :F3, :A3, :C4)
chord_map["UD99"] = (ring :G4, :As2, :D4)
chord_map["UD100"] = (ring :As4, :C3, :F3, :G3)
chord_map["UD101"] = (ring :A4, :C2, :E3, :C4)
chord_map["UD102"] = (ring :F4, :F2, :A3, :F3)

chords_string = [
  ##| Little Wing
  "UD0 UD1 :Ds2 UD3 UD3 :Gs2 :As2 :Fs3 UD8 :Ds3 UD10 UD11 :Fs2 :Fs3 UD14 :Gs4 :Fs4 UD14 :Fs3 UD19 :B3 UD21 UD19 :B3 :As3 :Fs3 :Gs2 :Cs3 "+
  ":Ds3 :B3 :Ds3 UD31 :Cs4 UD31 :Fs3 :Gs3 UD8 :Ds3 :Fs3 :Gs2 :As2 :Ds2 :Ds3 UD14 :Gs4 :Fs4 :Cs4 UD47 :Ds3 UD49 UD50 UD50 :As3 UD50 UD54 "+
  "UD55 :As2 UD19 UD58 UD59 UD60 :F4 UD62 UD63 UD64 :As2 :A2 :E3 UD68 :Gs3 :Gs2 ",
  ##| Air on G string
  ##| "UD69 :As3 :A3 :A2 :G2 :G3 :F3 :F2 UD70 UD71 :Ds5 UD72 :As4 UD73 :As4 UD74 :As4 :A4 :F3 :G4 UD75 :Ds2 UD76 UD77 :G3 UD78 UD79 :Gs3 UD80 "+
  ##| ":D5 UD81 :G4 UD82 :B4 UD83 :Ds5 UD84 UD85 :B3 UD86 :D4 UD87 :C4 UD88 :C5 UD89 :F4 UD90 :A4 UD91 :D5 UD92 :As3 :A3 UD93 :F5 UD94 UD95 "+
  ##| ":C5 :D5 UD96 :C5 UD97 :As4 UD98 :G4 UD99 :A4 :As4 UD100 UD101 :G4 UD102 :G2 "
]

atime = [
  ##| Little Wing
  (ring 0.2143, 0.6428, 0.8572, 0.2143, 0.6428, 0.2143, 0.2143, 0.2143, 0.2143, 0.2143, 0.2142, 0.4286, 0.4286, 0.4286, 0.1428, 0.1429)+
  (ring 0.1428, 0.2143, 0.2143, 0.1071, 0.3215, 0.2143, 0.2142, 0.2143, 0.2143, 0.4286, 0.8571, 0.2143, 0.2143, 0.2143, 0.2143, 0.0535)+
  (ring 0.1608, 0.2142, 0.1072, 0.3214, 0.1429, 0.1428, 0.1429, 0.1607, 0.2679, 0.4285, 0.4286, 0.0536, 0.1607, 0.2143, 0.2143, 0.2142)+
  (ring 0.2143, 0.2143, 0.2143, 0.0536, 0.1607, 0.2143, 0.2142, 0.4286, 0.4286, 0.4286, 0.4285, 0.2143, 0.2143, 0.0536, 0.1607, 0.2143)+
  (ring 0.2143, 0.2142, 0.2143, 0.2143, 0.2143, 0.2143, 0.2143),
  ##| Air on G string
  ##| (ring 0.6722, 0.6722, 0.6723, 0.6722, 0.7333, 0.7222, 0.7334, 0.7333, 0.7333, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.2, 0.2, 0.4, 0.4, 0.4)+
  ##| (ring 0.7334, 0.7333, 0.7333, 0.4, 0.4, 0.7334, 0.4, 0.4, 0.3555, 0.4, 0.4, 0.3889, 0.4, 0.3889, 0.4, 0.3889, 0.7333, 0.4, 0.4, 0.4)+
  ##| (ring 0.4, 0.4, 0.4, 0.3556, 0.4, 0.4, 0.3889, 0.4, 0.3889, 0.4, 0.3888, 0.7334, 0.7333, 0.7333, 0.4, 0.4, 0.7334, 0.2666, 0.2445)+
  ##| (ring 0.2555, 0.4, 0.3889, 0.4, 0.3889, 0.4, 0.3889, 0.2667, 0.2444, 0.2556, 0.7333, 0.4, 0.3889, 0.3667, 0.3667),
]

define :translate do |accum:, chords:, repeat: 1|
  ar = chords.split(" ")
  repeat.times{ar.each{|e| accum.push(chord_map[e])}}
end

a = 3.0
i = 0
cl = chords_string.length
tl = atime.length

use_synth :pluck
use_synth_defaults attack_level: 1, decay_level: 1, sustain_level: 1, coef: 0.1
duration_const = 1.0
dec = 0.5*duration_const
sus = 0.4*duration_const
rel = 0.1*duration_const

with_fx :reverb, room: 1, mix: 0.5 do
  ##| with_fx :rlpf do
  loop do
    puts chords_string[i%cl]
    puts atime[i%tl]
    achord = []
    translate accum: achord, chords: chords_string[i%cl]
    atr = atime[i%tl]
    j = 0
    l = atr.length
    achord.each {|ac|
      s = atr[j%l]
      cs = 1
      cs = ac.length if ac.instance_of?(SonicPi::Core::RingVector)
      play ac, amp: a*cs, decay: s*dec, sustain: s*sus, release: s*rel
      sleep s
      j += 1
    }
    i +=1
  end
  ##| end
end
