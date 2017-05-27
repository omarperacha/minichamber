//
//  MiniChamberVC.swift
//  Mini Chamber
//
//  Created by Omar Peracha on 21/03/2017.
//  Copyright © 2017 Omar Peracha. All rights reserved.
//

import UIKit
import AudioKit

let input = AKMicrophone()

class MiniChamberVC: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var closeButton: RoundButton!
    
    
    @IBOutlet weak var wave1: UIImageView!
    
    @IBOutlet weak var wave2: UIImageView!
    
    @IBOutlet weak var wave3: UIImageView!
    
    @IBOutlet weak var wave4: UIImageView!
    
    @IBOutlet weak var wave5: UIImageView!
    
    @IBAction func dismissVC(_ sender: Any) {
        self.dismiss(animated: false, completion: {})
        AudioKit.stop()
    }
    
    let lower = (34.0/36.0)
    let upper = (36.0/34.0)
    var lastFreq = 0.0
    
    let tracker = AKFrequencyTracker(input, hopSize: 512, peakCount: 1)
    
    let sus = 12.0
    
    //MARK - DECLARE OSCILLATORS
    var s1 = HumOsc()
    var s2 = HumOsc()
    
    var s3 = HumOsc()
    var s4 = HumOsc()
    
    var s5 = HumOsc()
    var s6 = HumOsc()
    
    var s7 = HumOsc()
    var s8 = HumOsc()
    
    var s9 = HumOsc()
    var s10 = HumOsc()
    
    var s11 = HumOsc()
    var s12 = HumOsc()
    
    var s13 = HumOsc()
    var s14 = HumOsc()
    
    
    //MARK - DECLARE ENVELOPES
    var env1 : AKAmplitudeEnvelope?
    var env2 : AKAmplitudeEnvelope?
    
    var env3 : AKAmplitudeEnvelope?
    var env4 : AKAmplitudeEnvelope?
    
    var env5 : AKAmplitudeEnvelope?
    var env6 : AKAmplitudeEnvelope?
    
    var env7 : AKAmplitudeEnvelope?
    var env8 : AKAmplitudeEnvelope?
    
    var env9 : AKAmplitudeEnvelope?
    var env10 : AKAmplitudeEnvelope?
    
    var env11 : AKAmplitudeEnvelope?
    var env12 : AKAmplitudeEnvelope?
    
    var env13 : AKAmplitudeEnvelope?
    var env14 : AKAmplitudeEnvelope?
    
    //MARK - Declare Mixers for HumOsc Partials
    var m1 = AKMixer()
    var m2 = AKMixer()
    
    var m3 = AKMixer()
    var m4 = AKMixer()
    
    var m5 = AKMixer()
    var m6 = AKMixer()
    
    var m7 = AKMixer()
    var m8 = AKMixer()
    
    var m9 = AKMixer()
    var m10 = AKMixer()
    
    var m11 = AKMixer()
    var m12 = AKMixer()
    
    var m13 = AKMixer()
    var m14 = AKMixer()
    
    var filtMix = AKMixer()
    
    var filter : AKLowPassFilter?
    
    var output = AKMixer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        wave1.alpha = 0
        wave2.alpha = 0
        wave3.alpha = 0
        wave4.alpha = 0
        wave5.alpha = 0
        
        closeButton.layer.borderWidth = 1.5
        closeButton.layer.borderColor = UIColor.lightGray.cgColor

        
        //MARK - SET UP OSCILLATORS
        s1.start(); s2.start(); s3.start(); s4.start(); s5.start(); s6.start()
        s7.start(); s8.start(); s9.start(); s10.start(); s11.start(); s12.start()
        s13.start(); s14.start()
        
        //MARK - SET UP PARTIAL MIXERS
        m1 = AKMixer(s1, s1.partial1, s1.partial2, s1.partial3, s1.partial4, s1.partial5)
        m2 = AKMixer(s2, s2.partial1, s2.partial2, s2.partial3, s2.partial4, s2.partial5)
        
        m3 = AKMixer(s3, s3.partial1, s3.partial2, s3.partial3, s3.partial4, s3.partial5)
        m4 = AKMixer(s4, s4.partial1, s4.partial2, s4.partial3, s4.partial4, s4.partial5)

        m5 = AKMixer(s5, s5.partial1, s5.partial2, s5.partial3, s5.partial4, s5.partial5)
        m6 = AKMixer(s6, s6.partial1, s6.partial2, s6.partial3, s6.partial4, s6.partial5)
        
        m7 = AKMixer(s7, s7.partial1, s7.partial2, s7.partial3, s7.partial4, s7.partial5)
        m8 = AKMixer(s8, s8.partial1, s8.partial2, s8.partial3, s8.partial4, s8.partial5)
        
        m9 = AKMixer(s9, s9.partial1, s9.partial2, s9.partial3, s9.partial4, s9.partial5)
        m10 = AKMixer(s10, s10.partial1, s10.partial2, s10.partial3, s10.partial4, s10.partial5)

        m11 = AKMixer(s11, s11.partial1, s11.partial2, s11.partial3, s11.partial4, s11.partial5)
        m12 = AKMixer(s12, s12.partial1, s12.partial2, s12.partial3, s12.partial4, s12.partial5)
        
        m13 = AKMixer(s13, s13.partial1, s13.partial2, s13.partial3, s13.partial4, s13.partial5)
        m14 = AKMixer(s14, s14.partial1, s14.partial2, s14.partial3, s14.partial4, s14.partial5)
        
        
        tracker.start()
        input.start()
        
        
        
        
        //MARK - SET UP ENVELOPES
        env1 = AKAmplitudeEnvelope(m1, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        env2 = AKAmplitudeEnvelope(m2, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        
        env3 = AKAmplitudeEnvelope(m3, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        env4 = AKAmplitudeEnvelope(m4, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        env5 = AKAmplitudeEnvelope(m5, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        env6 = AKAmplitudeEnvelope(m6, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        
        env7 = AKAmplitudeEnvelope(m7, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        env8 = AKAmplitudeEnvelope(m8, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        
        env9 = AKAmplitudeEnvelope(m9, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        env10 = AKAmplitudeEnvelope(m10, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        
        env11 = AKAmplitudeEnvelope(m11, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        env12 = AKAmplitudeEnvelope(m12, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        
        env13 = AKAmplitudeEnvelope(m13, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        env14 = AKAmplitudeEnvelope(m14, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 2)
        
        
        filtMix = AKMixer(env1!, env2!, env3!, env4!, env5!, env6!,
                          env7!, env8!,env9!, env10!, env11!, env12!,
                          env13!, env14!)
        
        filter = AKLowPassFilter(filtMix, cutoffFrequency: 440)
        
        output = AKMixer(filter!,
                         input, tracker)
        output.volume = 0.04
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        AudioKit.output = output
        AudioKit.start()
        Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(MiniChamberVC.initiate), userInfo: nil, repeats: true)
    }
    
    func initiate(){
        if tracker.amplitude > 0.01 {
            
            if tracker.frequency < (lower * lastFreq) {
                lastFreq = tracker.frequency
                print(lastFreq)
                theBusiness()
            }
            if tracker.frequency > (upper * lastFreq) {
                lastFreq = tracker.frequency
                print(lastFreq)
                theBusiness()
            }
        
            animateUp1()
        }
        
        
        if tracker.amplitude <= 0.01 {
        animateDown1()
        }
        
        if tracker.amplitude > 0.025 {
        animateUp2()
        }
        
        if tracker.amplitude <= 0.025 {
            animateDown2()
        }
        
        if tracker.amplitude > 0.05 {
            animateUp3()
        }
        
        if tracker.amplitude <= 0.05 {
            animateDown3()
        }
        
        if tracker.amplitude > 0.08 {
            animateUp4()
        }
        
        if tracker.amplitude <= 0.08 {
            animateDown4()
        }
        
        if tracker.amplitude > 0.13 {
            animateUp5()
        }
        
        if tracker.amplitude <= 0.13 {
            animateDown5()
        }
        
    }
    
    func theBusiness() {
        
        
        if env1!.isPlaying == false {
            s1.frequency = lastFreq
            env1!.start()
            print("env1 started at", s1.frequency)
            DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                self.env1!.stop()})
        } else
            if env2!.isPlaying == false {
                s2.frequency = lastFreq
                env2!.start()
                print("env2 started at", s2.frequency)
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.env2!.stop()})
            } else
                if env3!.isPlaying == false {
                    s3.frequency = lastFreq
                    env3!.start()
                    print("env3 started at", s3.frequency)
                    DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                        self.env3!.stop()})
                } else
                    if env4!.isPlaying == false {
                        s4.frequency = lastFreq
                        env4!.start()
                        print("env4 started at", s4.frequency)
                        DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                            self.env4!.stop()})
                    } else
                        if env5!.isPlaying == false {
                            s5.frequency = lastFreq
                            env5!.start()
                            print("env5 started at", s5.frequency)
                            DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                                self.env5!.stop()})
                        } else
                            if env6!.isPlaying == false {
                                s6.frequency = lastFreq
                                env6!.start()
                                print("env6 started at", s6.frequency)
                                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                                    self.env6!.stop()})
                            } else
                                if env7!.isPlaying == false {
                                    s7.frequency = lastFreq
                                    env7!.start()
                                    print("env7 started at", s7.frequency)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                                        self.env7!.stop()})
                                } else
                                    if env8!.isPlaying == false {
                                        s8.frequency = lastFreq
                                        env8!.start()
                                        print("env8 started at", s8.frequency)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                                            self.env8!.stop()})
                                    } else
                                        if env9!.isPlaying == false {
                                            s9.frequency = lastFreq
                                            env9!.start()
                                            print("env9 started at", s9.frequency)
                                            DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                                                self.env9!.stop()})
                                        } else
                                            if env10!.isPlaying == false {
                                                s10.frequency = lastFreq
                                                env10!.start()
                                                print("env10 started at", s10.frequency)
                                                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                                                    self.env10!.stop()})
                                            } else
                                                if env11!.isPlaying == false {
                                                    s11.frequency = lastFreq
                                                    env11!.start()
                                                    print("env11 started at", s11.frequency)
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                                                        self.env11!.stop()})
                                                } else
                                                    if env12!.isPlaying == false {
                                                        s12.frequency = lastFreq
                                                        env12!.start()
                                                        print("env9 started at", s12.frequency)
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                                                            self.env12!.stop()})
                                                    } else
                                                        if env12!.isPlaying == false {
                                                            s12.frequency = lastFreq
                                                            env12!.start()
                                                            print("env12 started at", s12.frequency)
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                                                                self.env12!.stop()})
                                                        } else
                                                            if env13!.isPlaying == false {
                                                                s13.frequency = lastFreq
                                                                env13!.start()
                                                                print("env13 started at", s13.frequency)
                                                                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                                                                    self.env13!.stop()})
                                                            } else
                                                                if env14!.isPlaying == false {
                                                                    s14.frequency = lastFreq
                                                                    env14!.start()
                                                                    print("env14 started at", s14.frequency)
                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                                                                        self.env14!.stop()})
                                                                    
        }
    }
    
        func animateUp1() {
            if wave1.alpha < 0.5 {
                UIView.animate(withDuration: 0, animations: {
                    self.wave1.alpha = 1})
            }
        }
    
    func animateDown1() {
        if wave1.alpha > 0.5 {
            UIView.animate(withDuration: 0, animations: {
                self.wave1.alpha = 0})
        }
    }
    
    func animateUp2() {
        if wave2.alpha < 0.5 {
            UIView.animate(withDuration: 0, animations: {
                self.wave2.alpha = 1})
        }
    }
    
    func animateDown2() {
        if wave2.alpha > 0.5 {
            UIView.animate(withDuration: 0, animations: {
                self.wave2.alpha = 0})
        }
    }
    
    
    func animateUp3() {
        if wave3.alpha < 0.5 {
            UIView.animate(withDuration: 0, animations: {
                self.wave3.alpha = 1})
        }
    }
    
    func animateDown3() {
        if wave3.alpha > 0.5 {
            UIView.animate(withDuration: 0, animations: {
                self.wave3.alpha = 0})
        }
    }
    
    func animateUp4() {
        if wave4.alpha < 0.5 {
            UIView.animate(withDuration: 0, animations: {
                self.wave4.alpha = 1})
        }
    }
    
    func animateDown4() {
        if wave4.alpha > 0.5 {
            UIView.animate(withDuration: 0, animations: {
                self.wave4.alpha = 0})
        }
    }
    
    func animateUp5() {
        if wave5.alpha < 0.5 {
            UIView.animate(withDuration: 0, animations: {
                self.wave5.alpha = 1})
        }
    }
    
    func animateDown5() {
        if wave5.alpha > 0.5 {
            UIView.animate(withDuration: 0, animations: {
                self.wave5.alpha = 0})
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
