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

    let tracker = AKFrequencyTracker(input, hopSize: 512, peakCount: 1)
    
    let sus = 12.0
    
//MARK - DECLARE OSCILLATORS
    var a2one = AKOscillator()
    var a2two = AKOscillator()
    
    var ahs2one = AKOscillator()
    var ahs2two = AKOscillator()
    
    var as2one = AKOscillator()
    var as2two = AKOscillator()
    
    var bhf2one = AKOscillator()
    var bhf2two = AKOscillator()
    
    var b2one = AKOscillator()
    var b2two = AKOscillator()
    
    var bhs2one = AKOscillator()
    var bhs2two = AKOscillator()
    
    var c3one = AKOscillator()
    var c3two = AKOscillator()
    
    
//MARK - DECLARE ENVELOPES
    var envA2one : AKAmplitudeEnvelope?
    var envA2two : AKAmplitudeEnvelope?
    
    var envAhs2one : AKAmplitudeEnvelope?
    var envAhs2two : AKAmplitudeEnvelope?
    
    var envAs2one : AKAmplitudeEnvelope?
    var envAs2two : AKAmplitudeEnvelope?
    
    var envBhf2one : AKAmplitudeEnvelope?
    var envBhf2two : AKAmplitudeEnvelope?
    
    var envB2one : AKAmplitudeEnvelope?
    var envB2two : AKAmplitudeEnvelope?
    
    var envBhs2one : AKAmplitudeEnvelope?
    var envBhs2two : AKAmplitudeEnvelope?
    
    var envC3one : AKAmplitudeEnvelope?
    var envC3two : AKAmplitudeEnvelope?
    
    
    
    
    var output = AKMixer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//MARK - SET UP OSCILLATORS
        a2one.frequency = 110; a2two.frequency = 110
        a2one.start(); a2two.start()
        
        ahs2one.frequency = 113.223; ahs2two.frequency = 113.223
        ahs2one.start(); ahs2two.start()
        
        as2one.frequency = 116.541; as2two.frequency = 116.541
        as2one.start(); as2two.start()
        
        bhf2one.frequency = 119.956; bhf2two.frequency = 119.956
        bhf2one.start(); bhf2two.start()
        
        b2one.frequency = 123.471; b2two.frequency = 123.471
        b2one.start(); b2two.start()
        
        bhs2one.frequency = 127.089; bhs2two.frequency = 127.089
        bhs2one.start(); bhs2two.start()
        
        c3one.frequency = 130.813; c3two.frequency = 130.813
        c3one.start(); c3two.start()
        
        
        
        tracker.start()
        input.start()
        
        
        
   
//MARK - SET UP ENVELOPES
        envA2one = AKAmplitudeEnvelope(a2one, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        envA2two = AKAmplitudeEnvelope(a2two, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        
        envAhs2one = AKAmplitudeEnvelope(ahs2one, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        envAhs2two = AKAmplitudeEnvelope(ahs2two, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        
        envAs2one = AKAmplitudeEnvelope(as2one, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        envAs2two = AKAmplitudeEnvelope(as2two, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        
        envBhf2one = AKAmplitudeEnvelope(bhf2one, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        envBhf2two = AKAmplitudeEnvelope(bhf2two, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        
        envB2one = AKAmplitudeEnvelope(b2one, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        envB2two = AKAmplitudeEnvelope(b2two, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        
        envBhs2one = AKAmplitudeEnvelope(bhs2one, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        envBhs2two = AKAmplitudeEnvelope(bhs2two, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        
        envC3one = AKAmplitudeEnvelope(c3one, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        envC3two = AKAmplitudeEnvelope(c3two, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)

        

    
        
        
        output = AKMixer(envA2two!, envA2one!,
                         envAhs2one!, envAhs2two!,
                         envAs2one!, envAs2two!,
                         envBhf2one!, envBhf2two!,
                         envB2one!, envB2two!,
                         envBhs2one!, envBhs2two!,
                         envC3one!, envC3two!,
                         input, tracker)
        output.volume = 0.1
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AudioKit.output = output
        AudioKit.start()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(MiniChamberVC.theBusiness), userInfo: nil, repeats: true)
    }
    
    func theBusiness() {
        print(tracker.frequency)
        
        if tracker.frequency <= 111.6 && tracker.frequency > 108.43 {
            print("A2")
            if self.envA2one!.isStarted{
                self.envA2two!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envA2two!.stop()})
            } else {
                self.envA2one!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envA2one!.stop()})
            }
        }
        
        if tracker.frequency <= 114.87 && tracker.frequency > 111.6 {
            print("A+2")
            if self.envAhs2one!.isStarted{
                self.envAhs2two!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envAhs2two!.stop()})
            } else {
                self.envAhs2one!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envAhs2one!.stop()})
            }
        }
        
        if tracker.frequency <= 118.236 && tracker.frequency > 114.87 {
            print("A#2")
            if self.envAs2one!.isStarted{
                self.envAs2two!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envAs2two!.stop()})
            } else {
                self.envAs2one!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envAs2one!.stop()})
            }
        }
        
        if tracker.frequency <= 121.701 && tracker.frequency > 118.236 {
            print("Bd2")
            if self.envBhf2one!.isStarted{
                self.envBhf2two!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envBhf2two!.stop()})
            } else {
                self.envBhf2one!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envBhf2one!.stop()})
            }
        }
        
        if tracker.frequency <= 125.267 && tracker.frequency > 121.701 {
            print("B2")
            if self.envBhf2one!.isStarted{
                self.envBhf2two!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envBhf2two!.stop()})
            } else {
                self.envBhf2one!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envBhf2one!.stop()})
            }
        }
        
        if tracker.frequency <= 128.937 && tracker.frequency > 125.267 {
            print("B+2")
            if self.envBhf2one!.isStarted{
                self.envBhf2two!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envBhf2two!.stop()})
            } else {
                self.envBhf2one!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envBhf2one!.stop()})
            }
        }
        
        if tracker.frequency <= 132.715 && tracker.frequency > 128.937 {
            print("C3")
            if self.envBhf2one!.isStarted{
                self.envBhf2two!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envBhf2two!.stop()})
            } else {
                self.envBhf2one!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + sus, execute: {
                    self.envBhf2one!.stop()})
            }
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
