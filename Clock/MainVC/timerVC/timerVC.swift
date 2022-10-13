//
//  timerVC.swift
//  Clock
//
//  Created by 阿瑋 on 2022/7/26.
//

import UIKit
import UserNotifications

var second_count = 0
var reload_count = 0
var start_status = false
var timer = Timer()

class timerVC: UIViewController {
    
    @IBOutlet weak var timePickerView: UIView!
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var label: UILabel!
    let content = UNMutableNotificationContent()
    let hour = [Int](0...23)
    let minute = [Int](0...59)
    let second = [Int](0...59)
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerview.delegate = self
        pickerview.dataSource = self
    }
    
    @IBAction func start(_ sender: Any) {
        start_status = true
        start.isHidden = true
        stop.isHidden = false
        pickerview.isHidden = true
        label.isHidden = false
        
        let second_label =  second_count % 60
        let minute_label = ( second_count / 60 ) % 60
        let hour_label = second_count / 3600
        
        second_count -= 1
        let showHours = hour_label > 9 ? "\(hour_label)" : "0\(hour_label)"
        let showMinutes = minute_label > 9 ? "\(minute_label)" : "0\(minute_label)"
        let showSeconds = second_label > 9 ? "\(second_label)" : "0\(second_label)"
        
        label.text = "\(showHours):\(showMinutes):\(showSeconds)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count_down), userInfo: nil, repeats: true)
       
    }
    
    @IBAction func stop(_ sender: Any) {
        start_status = false
        start.isHidden = false
        stop.isHidden = true
        pickerview.isHidden = true
        label.isHidden = false
        timer.invalidate()
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        start_status = false
        start.isHidden = false
        stop.isHidden = true
        pickerview.isHidden = false
        label.isHidden = true
        second_count = reload_count
        timer.invalidate()
        start.isEnabled = true
        stop.isEnabled = true
    }
}





func creatnotifaction() {
    let content = UNMutableNotificationContent()
    content.title = "Timer"
    content.subtitle = "Time up"
    content.body = ""
    content.sound = UNNotificationSound.default
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.001, repeats: false)
    let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request,withCompletionHandler: {error in print("成功建立通知...\(second_count)")
    })
}



extension timerVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hour.count
        }
        else if component == 2 {
            return minute.count
        }
        else if component == 4 {
            return second.count
        }
        else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        switch component {
        case 0:
            var label = UILabel()
            if let v = view {
                label = v as! UILabel
            }
            label.font = UIFont (name: "Helvetica Neue", size: 20)
            second_count = 0
            label.text =  hour[row].description
            label.textAlignment = .center
            return label
        case 1:
            var label = UILabel()
            if let v = view {
                label = v as! UILabel
            }
            label.font = UIFont (name: "Helvetica Neue", size: 20)
            label.text =  "hour"
            label.textAlignment = .center
            return label
        case 2:
            var label = UILabel()
            if let v = view {
                label = v as! UILabel
            }
            label.font = UIFont (name: "Helvetica Neue", size: 20)
            second_count = 0
            label.text =  minute[row].description
            label.textAlignment = .center
            return label
        case 3:
            var label = UILabel()
            if let v = view {
                label = v as! UILabel
            }
            label.font = UIFont (name: "Helvetica Neue", size: 20)
            label.text =  "min"
            label.textAlignment = .center
            return label
        case 4:
            var label = UILabel()
            if let v = view {
                label = v as! UILabel
            }
            label.font = UIFont (name: "Helvetica Neue", size: 20)
            second_count = 0
            label.text =  second[row].description
            label.textAlignment = .center
            return label
        case 5:
            var label = UILabel()
            if let v = view {
                label = v as! UILabel
            }
            label.font = UIFont (name: "Helvetica Neue", size: 20)
            label.text =  "sec"
            label.textAlignment = .center
            return label
        default:
            let label = UILabel()
            return label
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            second_count += hour[row] * 3600
        }
        else if component == 2 {
            second_count += minute[row] * 60
        }
        else if component == 4 {
            second_count += second[row]
        }
        else {
            print("")
        }
        reload_count = second_count
    }
    
    @objc func count_down() {
        
        let second_label =  second_count % 60
        let minute_label = ( second_count / 60 ) % 60
        let hour_label = second_count / 3600
        
        let showHours = hour_label > 9 ? "\(hour_label)" : "0\(hour_label)"
        let showMinutes = minute_label > 9 ? "\(minute_label)" : "0\(minute_label)"
        let showSeconds = second_label > 9 ? "\(second_label)" : "0\(second_label)"
        second_count -= 1
        label.text = "\(showHours):\(showMinutes):\(showSeconds)"
        
        
        if second_count <= -1 {
            start.isEnabled = false
            stop.isEnabled = false
            timer.invalidate()
            label.text = "00:00:00"
            creatnotifaction()
        }
        
        
    }
}
