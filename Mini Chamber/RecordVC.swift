//
//  RecordVC.swift
//  Mini Chamber
//
//  Created by Omar Peracha on 14/04/2017.
//  Copyright © 2017 Omar Peracha. All rights reserved.
//

import UIKit
import AudioKit

class RecordVC: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let lower = (34.0/36.0)
    let upper = (36.0/34.0)
    var lastFreq = 0.0
    
    let tracker = AKFrequencyTracker(input, hopSize: 512, peakCount: 1)
    
    let sus = 12.0
    
    //MARK - DECLARE OSCILLATORS
    var s1 = AKOscillator()
    var s2 = AKOscillator()
    
    var s3 = AKOscillator()
    var s4 = AKOscillator()
    
    var s5 = AKOscillator()
    var s6 = AKOscillator()
    
    var s7 = AKOscillator()
    var s8 = AKOscillator()
    
    var s9 = AKOscillator()
    var s10 = AKOscillator()
    
    var s11 = AKOscillator()
    var s12 = AKOscillator()
    
    var s13 = AKOscillator()
    var s14 = AKOscillator()
    
    
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
    
    
    
    
    var output = AKMixer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //MARK - SET UP OSCILLATORS
        s1.start(); s2.start(); s3.start(); s4.start(); s5.start(); s6.start()
        s7.start(); s8.start(); s9.start(); s10.start(); s11.start(); s12.start()
        s13.start(); s14.start()
        
        
        
        tracker.start()
        input.start()
        
        
        
        
        //MARK - SET UP ENVELOPES
        env1 = AKAmplitudeEnvelope(s1, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        env2 = AKAmplitudeEnvelope(s2, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        
        env3 = AKAmplitudeEnvelope(s3, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        env4 = AKAmplitudeEnvelope(s4, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        env5 = AKAmplitudeEnvelope(s5, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        env6 = AKAmplitudeEnvelope(s6, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        
        env7 = AKAmplitudeEnvelope(s7, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        env8 = AKAmplitudeEnvelope(s8, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        
        env9 = AKAmplitudeEnvelope(s9, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        env10 = AKAmplitudeEnvelope(s10, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        
        env11 = AKAmplitudeEnvelope(s11, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        env12 = AKAmplitudeEnvelope(s12, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        
        env13 = AKAmplitudeEnvelope(s13, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        env14 = AKAmplitudeEnvelope(s14, attackDuration: 1, decayDuration: 6, sustainLevel: 0.7, releaseDuration: 0.5)
        
        
        
        
        
        
        output = AKMixer(env1!, env2!, env3!, env4!, env5!, env6!,
                         env7!, env8!,env9!, env10!, env11!, env12!,
                         env13!, env14!,
                         input, tracker)
        output.volume = 0.08
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        
        AudioKit.output = output
        AudioKit.start()
        Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(RecordVC.initiate), userInfo: nil, repeats: true)
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
