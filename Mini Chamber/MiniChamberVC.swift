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
    
    var a2one = AKOscillator()
    var a2two = AKOscillator()
    
    var envA2one : AKAmplitudeEnvelope?
    var envA2two : AKAmplitudeEnvelope?
    
    var output = AKMixer()
    var stored : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        a2one.frequency = 110; a2two.frequency = 110
        a2one.start(); a2two.start()
        tracker.start()
        input.start()
        
        envA2one = AKAmplitudeEnvelope(a2one, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        envA2two = AKAmplitudeEnvelope(a2two, attackDuration: 1, decayDuration: 0, sustainLevel: 1, releaseDuration: 0.5)
        
        
        
        
        output = AKMixer(envA2two!, envA2one!, input, tracker)
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
        
        if tracker.frequency <= 111.6 && tracker.frequency >= 108.43 {
            print("A2")
            if self.envA2one!.isStarted{
                self.envA2two!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
                    self.envA2two!.stop()})
            } else {
                self.envA2one!.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
                    self.envA2one!.stop()})
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
