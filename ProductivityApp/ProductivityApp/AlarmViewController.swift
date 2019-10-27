//
//  AlarmViewController.swift
//  ProductivityApp
//
//  Created by Tan Zi Fan on 10/26/19.
//  Copyright © 2019 Sharon Lee Su Yen. All rights reserved.
//

import UIKit
import EventKit
import SCLAlertView
import SwiftyJSON
import Alamofire

class AlarmViewController: UIViewController {
    
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var reminder: EKReminder? = nil
    var isRestless: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Timer.scheduledTimer(timeInterval: 60, target: self, selector: Selector("checkIfRestless"), userInfo: nil, repeats: true)
    }
    
    @objc
    func checkIfRestless() {
        AF.request("https://calhacks-fitbit-server.appspot.com", method: .get)
            .responseJSON { response in
            let json = JSON(response.value!)
            let restless = json["restless"].bool!
            print(restless)
            
            if (!self.isRestless && restless)
            {
                self.isRestless = true
                self.moveAlarmBackward()
            }
        }
        
        /*
        if (!self.isRestless)
        {
            self.isRestless = true
            self.moveAlarmBackward()
        }
        */
    }
    
    func moveAlarmBackward() {
        guard let reminder = self.reminder else {
            return
        }
        guard let alarms = reminder.alarms else {
            return
        }
        guard let date = alarms[0].absoluteDate else {
            return
        }
        
        let newAlarm = EKAlarm(absoluteDate: date.addingTimeInterval(-1800))
        reminder.alarms = [newAlarm]
        do {
            try appDelegate.eventStore?.save(reminder, commit: true)
        } catch {
            
        }
    }
    
    @IBAction func setAlarmPressed(_ sender: Any) {
        if appDelegate.eventStore == nil {
            appDelegate.eventStore = EKEventStore()

        appDelegate.eventStore?.requestAccess(
            to: EKEntityType.reminder, completion: {(granted, error) in
                if !granted {
                    print("Access to store not granted")
                } else {
                    print("Access granted")
                }
            })
        }

        if (appDelegate.eventStore != nil) {
            self.createAlarm()
        }
    }
    
    func createAlarm() {
        let reminder = EKReminder(eventStore: appDelegate.eventStore!)

        reminder.title = "Alarm"
        reminder.calendar =
        appDelegate.eventStore!.defaultCalendarForNewReminders()
        let date = alarmDatePicker.date
        let alarm = EKAlarm(absoluteDate: date)

        reminder.addAlarm(alarm)
        self.reminder = reminder

        do {
            try appDelegate.eventStore?.save(reminder, commit: true)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm:ss a yyyy-MM-dd"
            let dateString = formatter.string(from: date)
            let alert = SCLAlertView()
            _ = alert.showSuccess("Alarm set", subTitle: dateString)
        } catch let error {
                print("Reminder failed with error \(error.localizedDescription)")
        }
    }
}
