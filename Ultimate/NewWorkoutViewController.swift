//
//  NewWorkoutViewController.swift
//  Ultimate
//
//  Created by Kenta Kawaguchi on 1/7/17.
//  Copyright © 2017 Kenta Kawaguchi. All rights reserved.
//

import UIKit
import os.log

class NewWorkoutViewController: UIViewController, UITextFieldDelegate {

    
    // MARK: Properties
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    var workout: Workout?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }

    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = textField.text ?? ""
        let type = typeTextField.text ?? ""
        let descript = textView.text ?? ""
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        workout = Workout(name: name, type: type, descript: descript)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
