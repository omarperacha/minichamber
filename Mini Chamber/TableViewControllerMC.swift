//
//  TableViewControllerMC.swift
//  Mini Chamber
//
//  Created by Omar Peracha on 04/06/2017.
//  Copyright © 2017 Omar Peracha. All rights reserved.
//

import UIKit

class TableViewControllerMC: UITableViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var xButton: RoundButton!
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: {})
    }
    
   
    
    var files: [String] = []
    var fileName: NSString?
    var finalArray: [String] = []
    
    
    // Get the document directory url
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xButton.layer.borderWidth = 1.5
        xButton.layer.borderColor = UIColor.lightGray.cgColor
        
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
