//
//  PlayTableViewController.swift
//  Ultimate
//
//  Created by Kenta Kawaguchi on 1/4/17.
//  Copyright © 2017 Kenta Kawaguchi. All rights reserved.
//

import UIKit
import os.log


class PlayTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var plays = [Play]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Use of edit bar button
        navigationItem.leftBarButtonItem = editButtonItem
        
        
        if let savedPlays = loadPlays() {
            plays += savedPlays
        } else {
            loadSamplePlays()
        }
        
        // Load the sample data.
        //loadSamplePlays()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plays.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

 
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PlayTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let play = plays[indexPath.row]
        
        cell.nameLabel.text = play.name
        cell.photoImageView.image = play.photo
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            plays.remove(at: indexPath.row)
            savePlays()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new play.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let playDetailViewController = segue.destination as? PlayViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedPlayCell = sender as? PlayTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedPlayCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedPlay = plays[indexPath.row]
            playDetailViewController.play = selectedPlay
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
 
    
    //MARK: Private methods
    private func loadSamplePlays() {
        let photo1 = UIImage(named: "defaultPhoto")
        let photo2 = UIImage(named: "10series")
        let photo3 = UIImage(named: "20series")
        let photo4 = UIImage(named: "30series")
        
        
        guard let play1 = Play(name: "10 Series", photo: photo2!, text: "Notes ") else {
            fatalError("Unable to instantiate play1")
        }
        guard let play2 = Play(name: "20 Series", photo: photo3!, text: "Notes ") else {
            fatalError("Unable to instantiate play2")
        }
        guard let play3 = Play(name: "30 Series", photo: photo4!, text: "Notes ") else {
            fatalError("Unable to instantiate play2")
        }
        guard let play4 = Play(name: "40", photo: photo1!, text: " ") else {
            fatalError("Unable to instantiate play2")
        }
        guard let play5 = Play(name: "50", photo: photo1!, text: " ") else {
            fatalError("Unable to instantiate play2")
        }
        
        plays += [play1, play2, play3]
        
    }
    
    private func savePlays() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(plays, toFile: Play.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("plays successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save plays...", log: OSLog.default, type: .error)
        }
    }
    
    //MARK: Actions
    @IBAction func unwindToPlayList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? PlayViewController, let play = sourceViewController.play {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing play.
                plays[selectedIndexPath.row] = play
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
               
                // Add a new play.
                let newIndexPath = IndexPath(row: plays.count, section: 0)
                
                plays.append(play)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
             savePlays()
        }
    }

    
    private func loadPlays() -> [Play]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Play.ArchiveURL.path) as? [Play]
    }
}
