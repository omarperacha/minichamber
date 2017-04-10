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

    let tracker = AKFrequencyTracker(input, hopSize: 512, peakCount: 1)
    
    let sus = 12.0
    
//MARK - DECLARE OSCILLATORS
    var a2one = AKOscillator()
    var a2two = AKOscillator()
    
    var ahs2one = AKOscillator()
    var ahs2two = AKOscillator()
    
    var as2one = AKOscillator()
    var as2two = AKOscillator()
    
    
    
    
//MARK - DECLARE ENVELOPES
    var envA2one : AKAmplitudeEnvelope?
    var envA2two : AKAmplitudeEnvelope?
    
    var envAhs2one : AKAmplitudeEnvelope?
    var envAhs2two : AKAmplitudeEnvelope?
    
    var envAs2one : AKAmplitudeEnvelope?
    var envAs2two : AKAmplitudeEnvelope?
    
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
        
        tracker.start()
        input.start()
   
//MARK - SET UP ENVELOPES
        envA2one = AKAmplitudeEnvelope(a2one, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        envA2two = AKAmplitudeEnvelope(a2two, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        
        envAhs2one = AKAmplitudeEnvelope(ahs2one, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        envAhs2two = AKAmplitudeEnvelope(ahs2two, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        
        envAs2one = AKAmplitudeEnvelope(as2one, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        envAs2two = AKAmplitudeEnvelope(as2two, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        
        
        
        
        output = AKMixer(envA2two!, envA2one!,
                         envAhs2one!, envAhs2two!,
                         envAs2one!, envAs2two!,
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
