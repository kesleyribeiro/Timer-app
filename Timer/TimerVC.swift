//
//  TimerVC.swift
//  Timer
//
//  Created by Kesley Ribeiro on 28/Mar/17.
//  Copyright © 2017 App ao Cubo. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {

    // Vars to timers
    var second = 0
    var minute = 0
    var hour = 0
    var day = 0
    var currentTime = ""
    var timer = Timer()

    // Objects of view    
    @IBOutlet weak var playBtn: UIBarButtonItem!
    @IBOutlet weak var pauseBtn: UIBarButtonItem!
    @IBOutlet weak var resetBtn: UIBarButtonItem!
    @IBOutlet var timerSecondLbl: UILabel!
    @IBOutlet var timerMinuteLbl: UILabel!
    @IBOutlet var timerHourLbl: UILabel!
    @IBOutlet var timerDayLbl: UILabel!
    @IBOutlet var secondTextLbl: UILabel!
    @IBOutlet var minuteTextLbl: UILabel!
    @IBOutlet var hourTextLbl: UILabel!
    @IBOutlet var dayTextLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set timers 0 at objects of view
        timerSecondLbl.text = "\(second)"
        timerMinuteLbl.text = "\(minute)"
        timerHourLbl.text = "\(hour)"
        timerDayLbl.text = "\(day)"
        
        // Pause and reset buttons can not be used while Play button isn't cliked
        self.pauseBtn.isEnabled = false
        self.resetBtn.isEnabled = false
    }

    // Increase/calculate the timers
    func increaseTime() {

        // Start second count
        second += 1
        
        // Set actual value of second var to sencond label in view
        timerSecondLbl.text = "\(second)"
        
        // Update sencond timers labels
        if second == 60 {
            second = 1
            minute += 1
            secondTextLbl.text = "second"
            timerSecondLbl.text = "\(second)"
            timerMinuteLbl.text = "\(minute)"
        }
        // Update minute timers labels
        if minute == 60 {
            second = 1
            minute = 0
            hour += 1
            secondTextLbl.text = "second"
            minuteTextLbl.text = "minute"
            timerSecondLbl.text = "\(second)"
            timerMinuteLbl.text = "\(minute)"
            timerHourLbl.text = "\(hour)"
        }
        // Update hour and day timers labels
        if hour == 24 {
            second = 1
            minute = 0
            hour = 0
            day += 1
            secondTextLbl.text = "second"
            minuteTextLbl.text = "minute"
            hourTextLbl.text = "hour"
            timerSecondLbl.text = "\(second)"
            timerMinuteLbl.text = "\(minute)"
            timerHourLbl.text = "\(hour)"
            timerDayLbl.text = "\(day)"
        }

        // Update texts labels
        if second > 1  {
            secondTextLbl.text = "seconds"
        }
        if minute > 1 {
            minuteTextLbl.text = "minutes"
        }
        if hour > 1 {
            hourTextLbl.text = "hours"
        }
        if day > 1 {
            dayTextLbl.text = "days"
        }
        
        // Update current time var
        currentTime = "\(day) \(dayTextLbl.text!.uppercased())\n\(hour) \(hourTextLbl.text!.uppercased())\n\(minute) \(minuteTextLbl.text!.uppercased())\n\(second) \(secondTextLbl.text!.uppercased())"
    }

    // Play timer was clicked
    @IBAction func playTimer(_ sender: Any) {
        
        // Define the timer interval for 1 and select the function to calculate the timers
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerVC.increaseTime), userInfo: nil, repeats: true)
        
        // Play button can not be used
        self.playBtn.isEnabled = false

        // Pause and reset buttons can be used, is enabled
        self.pauseBtn.isEnabled = true
        self.resetBtn.isEnabled = true
    }

    // Pause timer was clicked
    @IBAction func pauseTimer(_ sender: Any) {
        
        // Timer is paused
        timer.invalidate()
        
        // Play button can be used, is enabled
        self.playBtn.isEnabled = true

        // Alert with current time
        showAlert("TIMER PAUSED", "CURRENT TIME\n\n\(currentTime)")
    }

    // Reset timer was clicked
    @IBAction func resetTimer(_ sender: Any) {

        // Timer is reseted/stoped
        timer.invalidate()

        // Play button can be used, is enabled
        self.playBtn.isEnabled = true

        // Pause and reset buttons can not be used while Play button isn't cliked
        self.pauseBtn.isEnabled = false
        self.resetBtn.isEnabled = false

        // Alert with ocurred time
        showAlert("TIMER RESETED", "OCURRED TIME\n\n\(currentTime)")

        // Set 0 for vars
        second = 0
        minute = 0
        hour = 0
        day = 0
        
        // Set timers 0 at objects of view
        timerSecondLbl.text = "\(0)"
        timerMinuteLbl.text = "\(0)"
        timerHourLbl.text = "\(0)"
        timerDayLbl.text = "\(0)"
        
        // Update texts labels
        secondTextLbl.text = "second"
        minuteTextLbl.text = "minute"
        hourTextLbl.text = "hour"
        dayTextLbl.text = "day"
    }
    
    // Function with structure standard to show alert
    func showAlert (_ title: String, _ message: String) {
        
        // Create alert and define parameters title and message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Add alert to alertActions and define title OK button
        alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: { (action) -> Void in
            print("\nUser touched in the OK!")
        }))

        // Show alert in view
        self.present(alert, animated: true, completion: nil)
    }

    // StatusBar white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

