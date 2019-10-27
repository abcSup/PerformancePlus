//
//  ViewController.swift
//  ProductivityApp
//
//  Created by Sharon Lee Su Yen on 10/25/19.
//  Copyright © 2019 Sharon Lee Su Yen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dietbutton: UIButton!
    @IBOutlet weak var alarmbutton: UIButton!
    @IBOutlet weak var timetablebutton: UIButton!
    @IBOutlet weak var decisionmakingbutton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBOutlet weak var heartrate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        alarmbutton.layer.cornerRadius = 10.0
        timetablebutton.layer.cornerRadius = 10.0
        decisionmakingbutton.layer.cornerRadius = 10.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
