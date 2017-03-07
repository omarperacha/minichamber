//
//  ViewController.swift
//  Mini Chamber
//
//  Created by Omar Peracha on 27/02/2017.
//  Copyright © 2017 Omar Peracha. All rights reserved.
//

import UIKit
import AudioKit

let input = AKMicrophone()

class ViewController: UIViewController {
    
    let tracker = AKFrequencyTracker(input, hopSize: 512, peakCount: 1)
    
    var a1 = AKOscillator()
    var a2 = AKOscillator()
    
    var envA1 : AKAmplitudeEnvelope?
    var envA2 : AKAmplitudeEnvelope?
    
    var output = AKMixer()
    var stored : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        a1.frequency = 110; a2.frequency = 110
        a1.amplitude = 0.3; a2.amplitude = 0.3
        a1.start(); a2.start()
        tracker.start()
        input.start()
        
        envA1 = AKAmplitudeEnvelope(a1, attackDuration: 1, decayDuration: 0, sustainLevel: 0.3, releaseDuration: 0.5)
        envA2 = AKAmplitudeEnvelope(a2, attackDuration: 1, decayDuration: 0, sustainLevel: 0.3, releaseDuration: 0.5)
        
        
        
        
        output = AKMixer(envA2!, envA1!, input, tracker)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AudioKit.output = output
        AudioKit.start()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.theBusiness), userInfo: nil, repeats: true)
    }
    
    func theBusiness() {
        print(tracker.frequency)
        if tracker.frequency <= 111.6 && tracker.frequency >= 108.43 {
            print("we in range, biatch")
            if self.envA1!.isStarted{
                self.envA2!.start()
            } else {
                self.envA1!.start()
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

