//
//  HumOsc.swift
//  Mini Chamber
//
//  Created by Omar Peracha on 27/05/2017.
//  Copyright © 2017 Omar Peracha. All rights reserved.
//

import Foundation
import AudioKit

public class HumOsc: AKOscillator {
    
    var partial1 = AKOscillator()
    var partial2 = AKOscillator()
    var partial3 = AKOscillator()
    var partial4 = AKOscillator()
    var partial5 = AKOscillator()

    
    override public var frequency: Double {
        didSet {
            partial1.frequency = super.frequency*2
            partial2.frequency = super.frequency*3
            partial3.frequency = super.frequency*4
            partial4.frequency = super.frequency*6
            partial5.frequency = super.frequency*7
        }
    }
    

    
    override public func start(){
        super.start()
        partial1.amplitude = super.amplitude*0.25*random(0.9, 1.1)
        partial2.amplitude = super.amplitude*0.2*random(0.9, 1.1)
        partial3.amplitude = super.amplitude*0.15*random(0.9, 1.1)
        partial4.amplitude = super.amplitude*0.1*random(0.9, 1.1)
        partial5.amplitude = super.amplitude*0.05*random(0.9, 1.1)
        partial1.start()
        partial2.start()
        partial3.start()
        partial4.start()
        partial5.start()
    }

    override public func stop() {
        super.stop()
        partial1.stop()
        partial2.stop()
        partial3.stop()
        partial4.stop()
        partial5.stop()
    }

}
