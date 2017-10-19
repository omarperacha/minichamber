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

    
    @objc func audioRouteChangeListener(notification:NSNotification) {
        let audioRouteChangeReason = notification.userInfo![AVAudioSessionRouteChangeReasonKey] as! UInt
        
        switch audioRouteChangeReason {
        case AVAudioSessionRouteChangeReason.newDeviceAvailable.rawValue:
            if AKSettings.headPhonesPlugged == false {
                dismiss()} else {AudioKit.start()}
        case AVAudioSessionRouteChangeReason.oldDeviceUnavailable.rawValue:
            if AKSettings.headPhonesPlugged == false {
                dismiss()} else {AudioKit.start()}
        default:
            break
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    var documentController = UIDocumentInteractionController()
    var audioFile : AKAudioFile?
    var player: AKAudioPlayer?
    var startStop = false
    var AKOn = false
    var silence = AKMixer(input)
    var outputMix = AKMixer()
    
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var xButton: RoundButton!
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss()
    }
    
    @IBOutlet weak var playButton: RoundButton!
    
    @IBAction func playButtonFunc(_ sender: Any) {
        
        
        if startStop == false {
            startStop = true
            do{player = try AKAudioPlayer(file: audioFile!, looping: false, completionHandler: {() in
                self.debug()
            })} catch {print("player error")}
            outputMix = AKMixer(player, silence)
            AudioKit.output = outputMix
            playButton.setImage(UIImage(named: "icons8-Stop Filled-50.png"), for: .normal)
                AudioKit.start()
        player!.start()
        } else {
            if player != nil {
            debug()
            }
        }
    }
    
    @IBOutlet weak var shareButton: RoundButton!
    
    @IBAction func shareButtonFunc(_ sender: Any) {
         documentController.presentOptionsMenu(from: self.shareButton.frame, in: self.view, animated: true)
    }
    
   
    
    var files: [String] = []
    var fileName: NSString?
    var finalArray: [String] = []
    
    var selectedFile = ""
    
    // Get the document directory url
    let docstring = NSSearchPathForDirectoriesInDomains( FileManager.SearchPathDirectory.documentDirectory,  FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
    
    let docsurl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    var docspath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         NotificationCenter.default.addObserver(self, selector: #selector(TableViewControllerMC.audioRouteChangeListener(notification:)), name: NSNotification.Name.AVAudioSessionRouteChange, object: nil)
        
        AKSettings.playbackWhileMuted = true
        silence.volume = 0
        
        if AKSettings.headPhonesPlugged == false {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
        } catch let error as NSError {
            print("Audio Session error: \(error.localizedDescription)")
            }}
        
        xButton.layer.borderWidth = 1.5
        xButton.layer.borderColor = UIColor.lightGray.cgColor
        
        playButton.layer.borderWidth = 1.5
        playButton.layer.borderColor = UIColor.lightGray.cgColor
        playButton.isEnabled = false
        playButton.setImage(UIImage(named: "icons8-Play Filled-50.png"), for: .normal)
        
        shareButton.layer.borderWidth = 1.5
        shareButton.layer.borderColor = UIColor.lightGray.cgColor
        shareButton.isEnabled = false
        
        
       getfiles()
        
        docspath = docsurl.path
        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        // Make footerview so it fill up size of the screen
        // The button is aligned to bottom of the footerview
        // using autolayout constraints
        self.tableView.tableFooterView = nil
        
        if finalArray.count <= 7{
            self.footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.tableView.frame.size.height - self.tableView.contentSize.height)} else {self.footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.tableView.frame.size.height - self.tableView.contentSize.height+CGFloat((finalArray.count-7)*46))}
            
            //self.tableView.frame.size.height - self.tableView.contentSize.height - self.footerView.frame.size.height)
        self.tableView.tableFooterView = self.footerView
        
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

     //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            selectedFile = (cell.textLabel?.text)!}
        if editingStyle == .delete {
            finalArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with:UITableViewRowAnimation.automatic)
            deleteFile()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.isSelected {
                shareButton.isEnabled = true
                playButton.isEnabled = true
                selectedFile = (cell.textLabel?.text)!
                
                do {
                    audioFile = try AKAudioFile(forReading: URL(string: "file://\(docspath)/\(selectedFile)")!)
                    documentController = UIDocumentInteractionController.init(url: URL(string: "file://\(docspath)/\(selectedFile)")!)
                } catch {print(error.localizedDescription)}
            }
        }
    }
    
    func  refreshTable(){
        getfiles()
        tableView.reloadData()
    }
    
    func deleteFile(){
        do {let fileManager = FileManager.default
            if fileManager.fileExists(atPath: "/\(docspath)/\(selectedFile)") {
                print("exists")
                print("/\(docspath)/\(selectedFile)")
                try fileManager.removeItem(atPath: "/\(docspath)/\(selectedFile)")
            } else {
                print("File does not exist")
            }
        } catch{print(error.localizedDescription)}
    }
    
    func getfiles(){
        do {
            // Get the directory contents urls (including subfolders urls)
            finalArray = []
            let directoryContents = try FileManager.default.contentsOfDirectory(at: docsurl, includingPropertiesForKeys: nil, options: [])
            files = directoryContents.map{String(describing: $0)}
            for file in files{
                fileName = file as NSString
                if fileName?.lastPathComponent != ".DS_Store" {
                    finalArray.append(fileName!.lastPathComponent)
                }
            }
            finalArray = finalArray.reversed()
            //print(finalArray)
        } catch {
            print("didn't work")
        }
        
    }
    
    func debug(){
        startStop = false
        AudioKit.stop()
        if player != nil {
        player!.stop()
            player = nil
        }
        DispatchQueue.main.async {
            self.playButton.setImage(UIImage(named: "icons8-Play Filled-50.png"), for: .normal)
        }
    }
    
    func dismiss(){
        AudioKit.stop()
        input.stop()
        if player != nil{
            player!.stop()
        }
        AKSettings.playbackWhileMuted = false
        self.dismiss(animated: false, completion: {
            AudioKit.engine.reset()
            AudioKit.disconnectAllInputs()
            if AKSettings.headPhonesPlugged == false {
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.none)
                } catch let error as NSError {
                    print("Audio Session error: \(error.localizedDescription)")
                }}
        })
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
