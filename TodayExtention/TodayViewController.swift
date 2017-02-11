//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Laurent Shala on 2/11/17.
//  Copyright © 2017 Laurent Shala. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var countdownTimerLabel: UILabel!
    
    
    
    var timeRemaining = ""
    let formatter = DateFormatter()
    let userCalendar = Calendar.current
    
    let requestedComponents: Set<Calendar.Component> = [
        Calendar.Component.month,
        Calendar.Component.day,
        Calendar.Component.hour,
        Calendar.Component.minute,
        Calendar.Component.second
        
    ]

    func printTime() {
        formatter.dateFormat = "MM/dd/yy hh:mm:ss"
        let startTime = Date()
        let endTime = formatter.date(from: "05/08/17 08:00:00")
        
        let timeDifference = userCalendar.dateComponents(requestedComponents, from: startTime, to: endTime!)
        
        timeRemaining = "\(timeDifference.month!) Months  \(timeDifference.day!) Days  \(timeDifference.minute!) Minutes  \(timeDifference.second!) Seconds"
//        UserDefaults.init(suiteName: "group.CountdownTimer.TodayExtension")?.setValue(timeRemaining, forKey: "timeRemaining")
        
        countdownTimerLabel.text = timeRemaining
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
//        if let timeRemaining = UserDefaults.init(suiteName: "group.CountdownTimer.TodayExtension")?.value(forKey: "timeRemaining") {
//            countdownTimerLabel.text = timeRemaining as? String
//        } else {
//            countdownTimerLabel.text = "Time Remaining = ..."
//        }
 
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(printTime), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
