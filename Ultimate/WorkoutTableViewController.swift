//
//  WorkoutTableViewController.swift
//  Ultimate
//
//  Created by Kenta Kawaguchi on 1/7/17.
//  Copyright © 2017 Kenta Kawaguchi. All rights reserved.
//

import UIKit
import os.log


class WorkoutTableViewController: UITableViewController {

    
    // MARK: Properties
    var workouts = [Workout]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load sample data
        if let savedWorkouts = loadWorkouts() {
            workouts += savedWorkouts
        }
        else {
            // Load the sample data.
            loadSampleWorkouts()
        }
        //loadSampleWorkouts()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
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
        return workouts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as? WorkoutTableViewCell  else {
            fatalError("The dequeued cell is not an instance of WorkoutTableViewCell.")
        }

        // Configure the cell...
        let workout = workouts[indexPath.row] as Workout
        //cell.textLabel?.text = workout.name
        //cell.detailTextLabel?.text = workout.type
        cell.workout = workout
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
            workouts.remove(at: indexPath.row)
            saveWorkouts()
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
    
    // MARK: Private methods
    
    private func loadSampleWorkouts() {
        guard let work1 = Workout(name: "4 Minute Core", type: "Strength", descript: "This should be done continuously without rest between moves. Set a stop watch and switch moves at each 30 seconds for 4 minutes.\n30 sec Open/Close Crunches: \n \u{2022} Sitting down, open your arms wide and extend your legs so they are 6 inches off the ground, bring your knees to your chest and wrap your arms around your knees. Only point of contact is your butt on the ground.\n30 sec Single Leg Lifts: \n \u{2022} Sit upright. Arms extended or lightly placed on the ground. One leg bent and the other extended on the ground. Lift the extended leg up until it is even with the knee. Hold for a one count. At 15 seconds switch legs.\n30 sec Boat Hold: \n \u{2022} Sitting in a V-position. Both legs extended and arms outstretched. Straighten your back so that it brings your arms more forward and hold. The only point of contact should be your butt on the ground.\n30 sec Pendulums: \n \u{2022} Lay back from the V-position in boat with both legs straight up. Arms stretched out to the side for balance. Swing your legs left and right like a pendulum. Slowly. Hold to the side for a count.\n30 sec Bicycle with an Extension: \n \u{2022} Laying on your back, arms behind your head, extend one leg and bring the other towards you like a regular bicycle crunch. Lift your chest to the sky. Extend the bent leg up to the sky so that you are now in scissors/single leg lift and switch legs.\n30 seconds Glute Bridge: \n \u{2022} If you want an extra challenge, do this with one leg extended.\n30 seconds Side Plank with a Dip: \n \u{2022} Get in a side plank on your elbow, dip your hip down and raise it back up, squeezing your glute and obliques. 15 seconds per side. You are just dipping, do not collapse your body forward.\n30 seconds Up and Down Plank: \n \u{2022} From the side plank, roll over to a low plank, then push up to a high plank, then down to a low plank, etc. ") else {
            fatalError("Unable to create workout")
        }
        guard let work2 = Workout(name: "Week 1", type: "Agility", descript: "The \"L\": \n\n2       3\n\n\n1\n\n \u{2022} Place three cones 10 yards apart in an L. Begin at cone 1. Sprint to cone 2, sprint back to cone 1. Sprint to cone 2, plant hard on the inside of cone 2 and sprint to cone 3. Plant at cone 3 sprint back to cone 2, plant on the outside of cone 2 and sprint to cone 1. \n \u{2022} This should be challenging. 3 times with cone 1 in front of cone 2 and then move cone 1 in front of cone 3 and do it 3 more times. \n\n\nBack ‘n 40’s: \n \u{2022} One cone at 40 yards. One cone at 10 yards. Sprint hard on these. You want to break it down quickly at the 10 and change direction into the back pedal.\n \u{2022} Sprint to the 10 yard cone, back pedal back to the line, sprint back to the 10 yard cone, back pedal to the line, 3 times total. On the 4th time, sprint to the 40 yard cone. Walk back. \n \u{2022} Sprint to the 10 yard cone, back pedal back to the line, 4 times. On the 5th time, sprint to the 40 yard cone. Walk back. \n \u{2022} Sprint to the 10 yard cone, back pedal back to the line, 5 times. On the 6th time, sprint to the 40 yard cone. Walk back. \n \u{2022} Sprint to the 10 yard cone, back pedal back to the line, 6 times. On the 7th time, sprint to the 40 yard cone. Walk back. \n \u{2022} Sprint to the 10 yard cone, back pedal back to the line, 7 times. On the 8th time, sprint to the 40 yard cone. Walk back. \n\n\nAgility Cone Sequence: \nSet up 6 cones 5 yards apart in a zip-zag pattern. Each set is through the cones and back, twice.\n Set 1: Lateral Bounding\n \u{2022} Leap off one foot to cone 2. Stick your landing then leap off that foot to the next cone.\n Set 2: Lateral Bound with a hop and stick\n \u{2022} Leap off one foot to cone 2. Add small hop after the leap and before you stick the landing.\n Set 3: Frog Jumps\n \u{2022} On two feet jump to cone 2. Stick the landing, turn and jump to cone 3. Knees should not pass your feet.\n Set 4: Shuffle\n \u{2022} Leading with the inside foot. \n Set 5: Cross-over Step \n \u{2022} This is about getting as many reps in between cones as you can. At cone 1, facing cone 3, lift the outside knee up high and cross over your body. It’s kind of like high knees, except you’re only doing one knee. Really emphasize the knee pop. When you get to cone two the outside foot has changed so do the same thing but with the other leg. This should be fast. ") else {
            fatalError("Unable to create workout")
        }
        guard let work3 = Workout(name: "Week 1", type: "Track", descript: "Plyometric Warm-up: \n \u{2022} Place a cone or disc about 20 yards away\n \u{2022} Lunges with a twist down, Sumo squats back\n \u{2022} Spiderman lunges down, knee hug then scooping hamstring stretch on the way back, alternating legs. \n \u{2022} 8’s. 8 butt-kicks, then 8 high knees, there and back. \n \u{2022} A skips there, B skips back\n \u{2022} Skips for height there, then skips for distance back\n \u{2022} Shuffle, there and back\n \u{2022} Karaoke, there and back\n \u{2022} Retro-runs (a backward run where you extend your foot back farther than normal, almost like a backward kick) there, mummy kicks (on your toes, arms extended like a mummy) back. \n \u{2022} Move the disc 10 yards farther away.\n \u{2022} Backpedal and Jog\n \u{2022} .50% speed, 75% speed\n \u{2022} 75% speed, 90% speed\n \u{2022} Sprint. All you got there and back. \n \u{2022} Stretch what you need.\n\n\nDistance Sprints: \n \u{2022} Set 1: 3 x 50m, 2 x 100m, 1 x 200m\n \u{2022} Set 2: 1 x 200m, 2 x 100m, 3 x 50m\n \u{2022} Set 3: 1 x 200m, 1 x 100m, 1 x 50m\n \u{2022} 30 sec rest between reps or walk back during 50m/100m to start line as rest.\n \u{2022} 2 min rest between sets.\n \u{2022} Please don't sacrifice form for speed!\n\n\nFartleks \n \u{2022} 4 laps.\n \u{2022} Start on a curve. Jog the curve, stride the straight, jog half of the next curve and walk the other half of the curve. Line up at the straight and sprint the straight. Repeat for 4 laps. \n \u{2022} Note: On the strides, try swinging your legs back farther than normal rather than reaching forward. This will naturally increase the distance your foot swings forward, thus increasing your stride.\n\n\nPlyometric Strength Series \n \u{2022} 2 x 10 Squat Jumps\n \u{2022} Focus on explosiveness when jumping and a slow and controlled landing.\n \u{2022} 2 x 10 Continuous Alternating Lunge Jumps \n \u{2022} Get in a lunge, jump up and switch legs. 10 per leg. \n \u{2022} 2 x 10 Lateral Broad Jump and Stick \n \u{2022} Jump as far as you can to one direction and stick the landing on one foot, hold it for a 2 count then explode back as far as you can the other direction, stick and hold.\n \u{2022} 2 x 10 One-Legged Box Hops \n \u{2022} Make a 1’ x 1’ box on the ground, you can eyeball it. Hop to each point of the box on one foot. One time around the box is one rep. Go the other direction on the second set. ") else {
            fatalError("Unable to create workout")
        }
        
        workouts += [work2, work3, work1]
    }
    
    private func saveWorkouts() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(workouts, toFile: Workout.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Workoutss successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save workouts...", log: OSLog.default, type: .error)
        }
    }
    
    
    private func loadWorkouts() -> [Workout]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Workout.ArchiveURL.path) as? [Workout]
    }
    
    // MARK: Actions
    @IBAction func unwindToWorkoutList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewWorkoutViewController, let workout = sourceViewController.workout {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                workouts[selectedIndexPath.row] = workout
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: workouts.count, section: 0)
                
                workouts.append(workout)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the meals.
            saveWorkouts()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddWorkout":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowWorkout":
            guard let workoutDetailViewController = segue.destination as? WorkoutViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedWorkoutCell = sender as? WorkoutTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedWorkoutCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedWorkout = workouts[indexPath.row]
            workoutDetailViewController.workout = selectedWorkout
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }


    }
    

}
