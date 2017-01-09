//
//  WorkoutViewController.swift
//  Ultimate
//
//  Created by Kenta Kawaguchi on 1/7/17.
//  Copyright © 2017 Kenta Kawaguchi. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var workout: Workout?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let workout = workout {
            nameLabel.text = workout.name
            textView.text = workout.descript
            subtitleLabel.text = workout.type
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
