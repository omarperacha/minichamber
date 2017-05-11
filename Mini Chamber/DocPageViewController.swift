//
//  DocPageViewController.swift
//  Mini Chamber
//
//  Created by Omar Peracha on 10/05/2017.
//  Copyright © 2017 Omar Peracha. All rights reserved.
//

import UIKit

class DocPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            
            // if you want to filter the directory contents you can do like this:
            let cafFiles = directoryContents.filter{ $0.pathExtension == "caf" }
            print("caf urls:",cafFiles)
            let cafFileNames = cafFiles.map{ $0.deletingPathExtension().lastPathComponent }
            print("caf list:", cafFileNames)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Dismiss(_ sender: Any) {
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
