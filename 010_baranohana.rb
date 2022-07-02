cm = {}
cm["Dmaj"] = (chord :d4, :M)
cm["Dmaj_C"] = (chord :d4, :M)+[:c4]
cm["Bm7"] = (chord :b4, :m7)
cm["F#m7"] = (chord :fs4, :m7)
cm["G"] = :g4
cm["R"] = :r

use_bpm 62
use_synth_defaults attack_level: 1.0, decay_level: 1, sustain_level: 1
duration_factor = 1.0
dec = 0.5*duration_factor
sus = 0.4*duration_factor
rel = 0.2*duration_factor
unit_sec = 0.25
a = 0.5

define :translate do |accum:,chords:,repeat: 1|ar=chords.split(" ");repeat.times{ar.each{|e|accum.push(cm[e])}} end

##| Mute
uncomment do
  t = unit_sec
  mt = t*0.1
  chd = []
  chd[0]=cm["Dmaj"]
  chd[1]=cm["Dmaj_C"]
  pattern = "0001"*1000
  live_loop :mute do
    with_fx :rhpf do
      with_fx :rlpf, mix: 0.25 do
        with_fx :distortion, mix: 0.5, distort: 0.5, amp: 1.0 do
          pattern.length.times {|i|
            synth :fm, note: chd[pattern[i].to_i], amp: a*2.5, decay: mt*dec*3.0, sustain: mt*sus*1.0, release: mt*rel*1.0
            sleep t
          }
        end
      end
    end
  end
end

##| Beep
uncomment do
  t = unit_sec
  nptn=[:bb5, :eb6, :c6, :d6, :bb5, :f6, :c6, :g6]
  live_loop :lbeep do
    params = sync :lbeep_cue
    params[0].times {
      nptn.each {|n|
        synth :beep, note: n, amp: a*0.5, release: 0.5
        sleep t
      }
    }
  end
end

##| Tri
uncomment do
  t = unit_sec
  rt = (ring t, t*2, t*2, t*2, t)
  nptn = [:g5, :f5, :eb5, :es5, :r]
  live_loop :ltri do
    params = sync :ltri_cue
    params[0].times {
      nptn.each {|n|
        t = rt.tick(:r1)
        synth :tri, note: n, amp: a*0.4, release: 0.5
        sleep t
      }
    }
  end
end

##| Drum
uncomment do
  t = unit_sec
  live_loop :drum do
    sync :drum_cue
    [
      "0222",
      ("1020"*14+"1023"+"0222")*2,
      "4020"+"1020"*13+"1323",
      "1020"*14+"1023"+"0222","s",
      "1656"*8,"h"
    ].each {|beats|
      beats.length.times {|i|
        b = beats[i]
        sample :drum_snare_soft, amp: a*1.0 if (b == "1" || b == "5")
        sample :drum_snare_hard, amp: a*1.0 if (b == "2" || b == "5")
        sample :drum_cymbal_open, amp: a*1.0, start: 0.0, finish: 0.15 if (b == "3")
        sample :drum_cymbal_open, amp: a*1.0, beat_stretch: 3.0, rate: 1.5 if (b == "4")
        sample :drum_cymbal_open, amp: a*0.5, start: 0.0, finish: 0.15 if (b == "6")
        sync :drum_cue if (b == "s")
        stop if (b == "h")
        sleep t
      }
    }
  end
end

##| Bass
uncomment do
  t = unit_sec
  prg = "R "+"Dmaj "*3+("Dmaj "*16+"Bm7 "*16+"F#m7 "*16+"G "*16)*1000
  live_loop :bass do
    sync :bass_cue
    with_fx :reverb, room: 0.7, mix: 0.5 do
      with_fx :rlpf, mix: 0.5 do
        achord = []
        translate accum: achord, chords: prg
        achord.each { |chd|
          synth :fm, note: chd, amp: a*0.2, pitch: -12, decay: t*dec*1.4, sustain: t*sus*0.6, release: t*rel*0.3, depth: 0.3
          sleep t
        }
      end
    end
  end
end

##| Controller
uncomment do
  t = unit_sec
  live_loop :controller do
    sleep t*4*8
    cue :lbeep_cue, 12
    sleep t*4*7
    cue :drum_cue
    cue :bass_cue
    sleep t*(4+1)
    cue :ltri_cue, 8
    sleep t*(4*31+3)
    cue :lbeep_cue, 24
    sleep t*(4*15+1)
    cue :ltri_cue, 8
    sleep t*4*24
    cue :drum_cue
    stop
  end
end
