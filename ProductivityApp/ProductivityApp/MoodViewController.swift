//
//  MoodViewController.swift
//  ProductivityApp
//
//  Created by Tan Zi Fan on 10/27/19.
//  Copyright © 2019 Sharon Lee Su Yen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyGif

class MoodViewController: UIViewController {
    
    @IBOutlet weak var waveImageView: UIImageView!
    @IBOutlet weak var avgHeartRateLabel: UILabel!
    @IBOutlet weak var rangeHeartRateLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        avgHeartRateLabel.isHidden = true
        rangeHeartRateLabel.isHidden = true
        moodLabel.isHidden = true
        */
        do {
            let gif = try UIImage(gifName: "Wave-20Hz_1.gif")
            self.waveImageView.setGifImage(gif)
        } catch {
            print(error)
        }
        
        AF.request("https://calhacks-fitbit-server.appspot.com", method: .get)
        .responseJSON { response in
            let json = JSON(response.value)
            
            let avgHeartRateDay = json["avg_hr_day"].doubleValue
            let rangeHeartRateDay = json["ran_hr_hour"].intValue
            let moodString = json["mood"].stringValue
            
            self.avgHeartRateLabel.text = String(format: "%.2f", avgHeartRateDay)
            self.rangeHeartRateLabel.text = String(rangeHeartRateDay)
            self.moodLabel.text = moodString
            
            /*
            self.avgHeartRateLabel.isHidden = false
            self.rangeHeartRateLabel.isHidden = false
            self.moodLabel.isHidden = false
            */
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
