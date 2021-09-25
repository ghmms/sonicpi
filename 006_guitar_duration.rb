uncomment do
  use_synth :pluck
  use_synth_defaults attack_level: 1, decay_level: 1, sustain_level: 1, coef: 0.1
  
  a = 2
  numo = 3
  notes = (scale :e2, :minor_pentatonic, num_octaves: numo)
  idx = (0..notes.length-1).to_a.shuffle
  ##| idx.shuffle!
  rs = (ring 0.25)
  ##| rs = (ring 0.25, 0.25, 0.15, 0.35)
  
  live_loop :l2 do
    with_fx :reverb, room: 1, mix: 0.5 do
      ##| with_fx :rlpf do
      notes = (scale [:e2, :a2, :b2].choose, :minor_pentatonic, num_octaves: numo)#.shuffle
      idx.each {|i|
        s = rs.tick
        play notes[i], decay: s*0.5, sustain: s*0.4, release: s*0.1, amp: a
        ##| play notes[i], amp: a
        sleep s
      }
      ##| end
    end
  end
end
