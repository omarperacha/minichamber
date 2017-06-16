//
//  TableViewControllerMC.swift
//  Mini Chamber
//
//  Created by Omar Peracha on 04/06/2017.
//  Copyright © 2017 Omar Peracha. All rights reserved.
//

import UIKit
import AudioKit
import Foundation

class TableViewControllerMC: UITableViewController {
    
    func audioRouteChangeListener(notification:NSNotification) {
        let audioRouteChangeReason = notification.userInfo![AVAudioSessionRouteChangeReasonKey] as! UInt
        
        switch audioRouteChangeReason {
        case AVAudioSessionRouteChangeReason.newDeviceAvailable.rawValue:
            AudioKit.start()
        case AVAudioSessionRouteChangeReason.oldDeviceUnavailable.rawValue:
            AudioKit.start()
        default:
            break
        }
    }


    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var indPath = 0
    var shareInd = 0
    var indCount : Int?
    var documentController = UIDocumentInteractionController()
    var audioFile : AKAudioFile?
    var player: AKAudioPlayer?
    var startStop = false
    var AKOn = false
    
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var xButton: RoundButton!
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: {})
        AudioKit.stop()
    }
    
    @IBOutlet weak var playButton: RoundButton!
    
    @IBAction func playButtonFunc(_ sender: Any) {
        
    
        
        if startStop == false {
            startStop = true
        do{player = try AKAudioPlayer(file: audioFile!)} catch {print("player error")}
            AudioKit.output = player
                AudioKit.start()
        player!.start()
        } else {
            startStop = false
            AudioKit.stop()
            player!.stop()
            player = nil
        }
    }
    
    @IBOutlet weak var shareButton: RoundButton!
    
    @IBAction func shareButtonFunc(_ sender: Any) {
         documentController.presentOptionsMenu(from: self.shareButton.frame, in: self.view, animated: true)
    }
    
   
    
    var files: [String] = []
    var fileName: NSString?
    var finalArray: [String] = []
    
    
    // Get the document directory url
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(String(describing: AudioKit.outputs))")
        
        indCount = 0
        
        xButton.layer.borderWidth = 1.5
        xButton.layer.borderColor = UIColor.lightGray.cgColor
        
        playButton.layer.borderWidth = 1.5
        playButton.layer.borderColor = UIColor.lightGray.cgColor
        playButton.isEnabled = false
        
        shareButton.layer.borderWidth = 1.5
        shareButton.layer.borderColor = UIColor.lightGray.cgColor
        shareButton.isEnabled = false
        
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            files = directoryContents.map{String(describing: $0)}
            for file in files{
             fileName = file as NSString
                if fileName?.lastPathComponent != ".DS_Store" {
                finalArray.append(fileName!.lastPathComponent)
                }
            }
        } catch {
            print("didn't work")
        }
        
        //print("\(files.count)")
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Make footerview so it fill up size of the screen
        // The button is aligned to bottom of the footerview
        // using autolayout constraints
        self.tableView.tableFooterView = nil
        self.footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.tableView.frame.size.height - self.tableView.contentSize.height
            //- self.footerView.frame.size.height
        )
        self.tableView.tableFooterView = self.footerView
        NotificationCenter.default.addObserver(self, selector: #selector(TableViewControllerMC.reloadData), name:NSNotification.Name(rawValue: "reloadData"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return finalArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = finalArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Files"
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


     //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            finalArray.remove(at: indexPath.row)
            indPath = indexPath.row
            tableView.deleteRows(at: [indexPath], with:UITableViewRowAnimation.automatic)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"),object: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.isSelected {
                shareButton.isEnabled = true
                playButton.isEnabled = true
                shareInd = indexPath.row
                do {let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
                    documentController = UIDocumentInteractionController.init(url: directoryContents[shareInd-indCount!])
                    audioFile = try AKAudioFile(forReading: directoryContents[shareInd-indCount!])
                } catch {print("fail")}
            }
        }
    }
    
    func reloadData(notification:NSNotification){
        // reload function here, so when called it will reload the tableView
        finalArray.insert("Successfully Deleted", at: indPath)
        //tableView.reloadData()
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: indPath, section: 0)], with: .automatic)
        tableView.endUpdates()
        do{let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            try FileManager.default.removeItem(at: directoryContents[indPath-indCount!])
        } catch{print("deletion failed")}
        indCount! += 1
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
