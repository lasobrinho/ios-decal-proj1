//
//  StatsViewController.swift
//  to-do-app-2
//
//  Created by Lucas Alves Sobrinho on 2/20/16.
//  Copyright © 2016 Lucas Alves Sobrinho. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateCount()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCount() {
        var tasksCompleted = 0
        for task in tasks {
            let dateDifference = NSCalendar.currentCalendar().components(
                [.Minute],
                fromDate: task.dateCompleted ?? NSDate(),
                toDate: NSDate(),
                options: [])
            if dateDifference.minute < 1440 && task.status{
                tasksCompleted++
            }
        }
        countLabel.text = String(tasksCompleted)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
