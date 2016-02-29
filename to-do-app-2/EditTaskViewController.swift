//
//  EditTaskViewController.swift
//  to-do-app-2
//
//  Created by Lucas Alves Sobrinho on 2/23/16.
//  Copyright © 2016 Lucas Alves Sobrinho. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    
    var task: Task?
    var i: Int?
    var color: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)

        // Do any additional setup after loading the view.
        editTask()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    
    func textFieldDidChange(textField: UITextField) {
        if nameTextField.text?.characters.count == 0 {
            saveButton.enabled = false
        } else {
            saveButton.enabled = true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            task?.name = nameTextField.text!
            task!.color = color ?? task!.color
        }
    }

}
