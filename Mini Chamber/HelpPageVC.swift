//
//  HelpPageVC.swift
//  Mini Chamber
//
//  Created by Omar Peracha on 08/05/2017.
//  Copyright © 2017 Omar Peracha. All rights reserved.
//

import UIKit

class HelpPageVC: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    
    @IBOutlet weak var VoxIbutton: UIButton!
    
    
    @IBAction func openVoxURL(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "https://omarperacha.com/vox-i")!)
    }
    
    @IBAction func termsLink(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "https://omarperacha.com/mini-chamber-terms-of-use")!)
    }
    
    @IBAction func iconLink(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "https://icons8.com/")!)
    }
    
    @IBOutlet weak var xButton: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        xButton.layer.borderWidth = 1.5
        xButton.layer.borderColor = UIColor.lightGray.cgColor
        
        VoxIbutton.layer.borderWidth = 1.5
        VoxIbutton.layer.borderColor = UIColor.darkGray.cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: {})
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
