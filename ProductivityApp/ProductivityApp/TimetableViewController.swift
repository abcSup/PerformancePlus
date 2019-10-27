//
//  TimetableViewController.swift
//  ProductivityApp
//
//  Created by Tan Zi Fan on 10/27/19.
//  Copyright © 2019 Sharon Lee Su Yen. All rights reserved.
//

import UIKit

class TimetableViewController: UIViewController {
    
    
    @IBOutlet weak var var1: UITextField!
    @IBOutlet weak var var2: UITextField!
    @IBOutlet weak var var3: UITextField!
    @IBOutlet weak var var4: UITextField!
    @IBOutlet weak var var5: UITextField!
    
    @IBOutlet weak var var01: UITextField!
    @IBOutlet weak var var02: UITextField!
    @IBOutlet weak var var03: UITextField!
    @IBOutlet weak var var04: UITextField!
    @IBOutlet weak var var05: UITextField!
    
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    var a = "Create"
    var time1 = 619
    var start_time = 619
    var time2 = 0
    var hours1 = 0
    var minutes1 = 0
    var hours2 = 0
    var minutes2 = 0
    
    @IBOutlet weak var create: UILabel!
    
    @IBAction func submittimes(_ sender: Any) {
        let var11 = Int(var01.text!)
        let var12 = Int(var02.text!)
        let var13 = Int(var03.text!)
        let var14 = Int(var04.text!)
        let var15 = Int(var05.text!)
        
        a = "In Progress"
        create.text = "\(a)"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Change `0.1` to the desired number of seconds.
            let b = "Created"
            
            self.create.text = "\(b)"
            
            
            self.time2 = self.time1 + var11!
            self.hours1 = Int(floor(Double(self.time1 / 60)))
            self.minutes1 = self.time1 % 60
            self.hours2 = Int(floor(Double(self.time2 / 60)))
            self.minutes2 = self.time2 % 60
            
            var string1 = ""
            var string2 = ""
            var string3 = ""
            
            var str_hours1 = "\(self.hours1)"
            var str_minutes1 = "\(self.minutes1)"
            if self.minutes1 < 10 {
                str_minutes1 = "0" + str_minutes1
            }
            
            var str_hours2 = "\(self.hours2)"
            var str_minutes2 = "\(self.minutes2)"
            if self.minutes2 < 10 {
                str_minutes2 = "0" + str_minutes2
            }
            
            string1 = self.var1.text! + "     " + str_hours1 + ":" + str_minutes1
            string2 = " to " + str_hours2 + ":" + str_minutes2
            string3 = string1 + string2
            self.label1.text = "\(string3)"
            
            self.time1 = self.time2
            
            //
            
            self.time2 = self.time1 + var12!
            self.hours1 = Int(floor(Double(self.time1 / 60)))
            self.minutes1 = self.time1 % 60
            self.hours2 = Int(floor(Double(self.time2 / 60)))
            self.minutes2 = self.time2 % 60
            
            str_hours1 = "\(self.hours1)"
            str_minutes1 = "\(self.minutes1)"
            if self.minutes1 < 10 {
                str_minutes1 = "0" + str_minutes1
            }
            
            str_hours2 = "\(self.hours2)"
            str_minutes2 = "\(self.minutes2)"
            if self.minutes2 < 10 {
                str_minutes2 = "0" + str_minutes2
            }
            
            string1 = self.var2.text! + "     " + str_hours1 + ":" + str_minutes1
            string2 = " to " + str_hours2 + ":" + str_minutes2
            string3 = string1 + string2
            self.label2.text = "\(string3)"
            
            self.time1 = self.time2
            
            //
            
            self.time2 = self.time1 + var13!
            self.hours1 = Int(floor(Double(self.time1 / 60)))
            self.minutes1 = self.time1 % 60
            self.hours2 = Int(floor(Double(self.time2 / 60)))
            self.minutes2 = self.time2 % 60
            
            str_hours1 = "\(self.hours1)"
            str_minutes1 = "\(self.minutes1)"
            if self.minutes1 < 10 {
                str_minutes1 = "0" + str_minutes1
            }
            
            str_hours2 = "\(self.hours2)"
            str_minutes2 = "\(self.minutes2)"
            if self.minutes2 < 10 {
                str_minutes2 = "0" + str_minutes2
            }
            
            string1 = self.var3.text! + "     " + str_hours1 + ":" + str_minutes1
            string2 = " to " + str_hours2 + ":" + str_minutes2
            string3 = string1 + string2
            self.label3.text = "\(string3)"
            
            self.time1 = self.time2
            
            //
            
            self.time2 = self.time1 + var14!
            self.hours1 = Int(floor(Double(self.time1 / 60)))
            self.minutes1 = self.time1 % 60
            self.hours2 = Int(floor(Double(self.time2 / 60)))
            self.minutes2 = self.time2 % 60
            
            str_hours1 = "\(self.hours1)"
            str_minutes1 = "\(self.minutes1)"
            if self.minutes1 < 10 {
                str_minutes1 = "0" + str_minutes1
            }
            
            str_hours2 = "\(self.hours2)"
            str_minutes2 = "\(self.minutes2)"
            if self.minutes2 < 10 {
                str_minutes2 = "0" + str_minutes2
            }
            
            string1 = self.var4.text! + "     " + str_hours1 + ":" + str_minutes1
            string2 = " to " + str_hours2 + ":" + str_minutes2
            string3 = string1 + string2
            self.label4.text = "\(string3)"
            
            self.time1 = self.time2
            
            //
            self.time2 = self.time1 + var15!
            self.hours1 = Int(floor(Double(self.time1 / 60)))
            self.minutes1 = self.time1 % 60
            self.hours2 = Int(floor(Double(self.time2 / 60)))
            self.minutes2 = self.time2 % 60
            
            str_hours1 = "\(self.hours1)"
            str_minutes1 = "\(self.minutes1)"
            if self.minutes1 < 10 {
                str_minutes1 = "0" + str_minutes1
            }
            
            str_hours2 = "\(self.hours2)"
            str_minutes2 = "\(self.minutes2)"
            if self.minutes2 < 10 {
                str_minutes2 = "0" + str_minutes2
            }
            
            string1 = self.var5.text! + "     " + str_hours1 + ":" + str_minutes1
            string2 = " to " + str_hours2 + ":" + str_minutes2
            string3 = string1 + string2
            self.label5.text = "\(string3)"
            
            self.time1 = self.start_time
            
        }
    }
    @IBAction func createbutton(_ sender: Any) {
        let var11 = Int(var01.text!)
        let var12 = Int(var02.text!)
        let var13 = Int(var03.text!)
        let var14 = Int(var04.text!)
        let var15 = Int(var05.text!)
        
        a = "In Progress"
        create.text = "\(a)"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Change `0.1` to the desired number of seconds.
            let b = "Created"
            
            self.create.text = "\(b)"
            
            
            self.time2 = self.time1 + var11!
            self.hours1 = Int(floor(Double(self.time1 / 60)))
            self.minutes1 = self.time1 % 60
            self.hours2 = Int(floor(Double(self.time2 / 60)))
            self.minutes2 = self.time2 % 60
            
            var string1 = ""
            var string2 = ""
            var string3 = ""
            
            var str_hours1 = "\(self.hours1)"
            var str_minutes1 = "\(self.minutes1)"
            if self.minutes1 < 10 {
                str_minutes1 = "0" + str_minutes1
            }
            
            var str_hours2 = "\(self.hours2)"
            var str_minutes2 = "\(self.minutes2)"
            if self.minutes2 < 10 {
                str_minutes2 = "0" + str_minutes2
            }
            
            string1 = self.var1.text! + "     " + str_hours1 + ":" + str_minutes1
            string2 = " to " + str_hours2 + ":" + str_minutes2
            string3 = string1 + string2
            self.label1.text = "\(string3)"
            
            self.time1 = self.time2
            
            //
            
            self.time2 = self.time1 + var12!
            self.hours1 = Int(floor(Double(self.time1 / 60)))
            self.minutes1 = self.time1 % 60
            self.hours2 = Int(floor(Double(self.time2 / 60)))
            self.minutes2 = self.time2 % 60
            
            str_hours1 = "\(self.hours1)"
            str_minutes1 = "\(self.minutes1)"
            if self.minutes1 < 10 {
                str_minutes1 = "0" + str_minutes1
            }
            
            str_hours2 = "\(self.hours2)"
            str_minutes2 = "\(self.minutes2)"
            if self.minutes2 < 10 {
                str_minutes2 = "0" + str_minutes2
            }
            
            string1 = self.var2.text! + "     " + str_hours1 + ":" + str_minutes1
            string2 = " to " + str_hours2 + ":" + str_minutes2
            string3 = string1 + string2
            self.label2.text = "\(string3)"
            
            self.time1 = self.time2
            
            //
            
            self.time2 = self.time1 + var13!
            self.hours1 = Int(floor(Double(self.time1 / 60)))
            self.minutes1 = self.time1 % 60
            self.hours2 = Int(floor(Double(self.time2 / 60)))
            self.minutes2 = self.time2 % 60
            
            str_hours1 = "\(self.hours1)"
            str_minutes1 = "\(self.minutes1)"
            if self.minutes1 < 10 {
                str_minutes1 = "0" + str_minutes1
            }
            
            str_hours2 = "\(self.hours2)"
            str_minutes2 = "\(self.minutes2)"
            if self.minutes2 < 10 {
                str_minutes2 = "0" + str_minutes2
            }
            
            string1 = self.var3.text! + "     " + str_hours1 + ":" + str_minutes1
            string2 = " to " + str_hours2 + ":" + str_minutes2
            string3 = string1 + string2
            self.label3.text = "\(string3)"
            
            self.time1 = self.time2
            
            //
            
            self.time2 = self.time1 + var14!
            self.hours1 = Int(floor(Double(self.time1 / 60)))
            self.minutes1 = self.time1 % 60
            self.hours2 = Int(floor(Double(self.time2 / 60)))
            self.minutes2 = self.time2 % 60
            
            str_hours1 = "\(self.hours1)"
            str_minutes1 = "\(self.minutes1)"
            if self.minutes1 < 10 {
                str_minutes1 = "0" + str_minutes1
            }
            
            str_hours2 = "\(self.hours2)"
            str_minutes2 = "\(self.minutes2)"
            if self.minutes2 < 10 {
                str_minutes2 = "0" + str_minutes2
            }
            
            string1 = self.var4.text! + "     " + str_hours1 + ":" + str_minutes1
            string2 = " to " + str_hours2 + ":" + str_minutes2
            string3 = string1 + string2
            self.label4.text = "\(string3)"
            
            self.time1 = self.time2
            
            //
            self.time2 = self.time1 + var15!
            self.hours1 = Int(floor(Double(self.time1 / 60)))
            self.minutes1 = self.time1 % 60
            self.hours2 = Int(floor(Double(self.time2 / 60)))
            self.minutes2 = self.time2 % 60
            
            str_hours1 = "\(self.hours1)"
            str_minutes1 = "\(self.minutes1)"
            if self.minutes1 < 10 {
                str_minutes1 = "0" + str_minutes1
            }
            
            str_hours2 = "\(self.hours2)"
            str_minutes2 = "\(self.minutes2)"
            if self.minutes2 < 10 {
                str_minutes2 = "0" + str_minutes2
            }
            
            string1 = self.var5.text! + "     " + str_hours1 + ":" + str_minutes1
            string2 = " to " + str_hours2 + ":" + str_minutes2
            string3 = string1 + string2
            self.label5.text = "\(string3)"
            
            self.time1 = self.start_time
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
