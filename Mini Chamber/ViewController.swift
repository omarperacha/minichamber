//
//  ViewController.swift
//  Mini Chamber
//
//  Created by Omar Peracha on 27/02/2017.
//  Copyright © 2017 Omar Peracha. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    @IBOutlet weak var FreePlayButton: UIButton!
    
    @IBOutlet weak var RecordButton: UIButton!
    
    @IBOutlet weak var HeadphoneIcon: UIImageView!

    @IBOutlet weak var QButton: RoundButton!
    
    var fadeIndex : Float = 0.5 {
        didSet {
            if fadeIndex < 0.5 {
                UIView.animate(withDuration: 1.5, animations: {
                    self.HeadphoneIcon.alpha = 1.0})
                Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(ViewController.setFadeIndex), userInfo: nil, repeats: false)
            }
            if fadeIndex >= 0.5 {
                UIView.animate(withDuration: 1.5, animations: {
                    self.HeadphoneIcon.alpha = 0.1})
                Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(ViewController.setFadeIndex), userInfo: nil, repeats: false)
            }
        }
    }
    
    func setFadeIndex() {
        fadeIndex = Float(self.HeadphoneIcon.alpha)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FreePlayButton.layer.borderWidth = 1.5
        FreePlayButton.layer.borderColor = UIColor.black.cgColor
        
        RecordButton.layer.borderWidth = 1.5
        RecordButton.layer.borderColor = UIColor.black.cgColor
        
        QButton.layer.borderWidth = 1.5
        QButton.layer.borderColor = UIColor.black.cgColor
        
        HeadphoneIcon.alpha = 0
        fadeIndex = 0
        
      
    }
    
    
  //override func viewDidAppear(_ animated: Bool) {
     //super.viewDidAppear(animated)
    
    
    //}

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

