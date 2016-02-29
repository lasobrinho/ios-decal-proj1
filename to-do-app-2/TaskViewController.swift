//
//  TaskViewController.swift
//  to-do-app-2
//
//  Created by Lucas Alves Sobrinho on 2/20/16.
//  Copyright © 2016 Lucas Alves Sobrinho. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var task: Task?
    var color: UIColor?
    
    @IBAction func red(sender: AnyObject) {
        color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.200)
        nameTextField.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.200)
    }
    @IBAction func green(sender: AnyObject) {
        color = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.200)
        nameTextField.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.200)    }
    @IBAction func yellow(sender: AnyObject) {
        color = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.200)
        nameTextField.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.200)
    }
    @IBAction func blue(sender: AnyObject) {
        color = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.200)
        nameTextField.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.200)
    }
    @IBAction func white(sender: AnyObject) {
        color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.200)
        nameTextField.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.200)
    }
    
    func editTask() {
        nameTextField.text = task?.name
        nameTextField.backgroundColor = task?.color
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.enabled = false
        nameTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        nameTextField.delegate = self
        
        editTask()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidChange(textField: UITextField) {
        if nameTextField.text?.characters.count == 0 {
            saveButton.enabled = false
        } else {
            saveButton.enabled = true
        }
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text!
            task = Task(name: name)
            task!.color = color ?? UIColor.whiteColor()
        }
    }

}

