//
//  alarm_insertVC.swift
//  Clock
//
//  Created by 阿瑋 on 2022/8/9.
//

import UIKit
import RealmSwift
import SwiftUI

class snooze_switch {
    var snooze_select = true
    static let snooze_shared = snooze_switch()
    private init() {}
}

class time {
    let hour = [Int](0...23)
    let minute = [Int](0...59)
    static let time_shared = time()
    private init() {}
}

class alarm_insertVC: UIViewController{
    
    @IBOutlet weak var time_picker: UIPickerView!
    
    @IBOutlet weak var save: UIBarButtonItem!
    @IBOutlet weak var day_insert: UIButton!
    @IBOutlet weak var label_insert: UIButton!
    @IBOutlet weak var sound_insert: UIButton!
    @IBOutlet weak var snooze: UISwitch!
    
    @IBOutlet weak var pickerview: UIPickerView!
    
    let day_array = ["Sun " , "Mon " , "Tues " , "Wed " , "Thur " , "Fri " , "Sat "]
    
    var hour_select : Int = 0
    var minute_select : Int = 0
    
    
//    let timeformatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label_insert.setTitle(label_text.shareinstance.label, for: .normal)
        pickerview.delegate = self
        pickerview.dataSource = self
        if snooze_switch.snooze_shared.snooze_select == true
        {
            snooze.isOn = true
        }
        else
        {
            snooze.isOn = false
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        add_day()  //新增重複天數的函數
        label_insert.setTitle(label_text.shareinstance.label, for: .normal)
        sound_insert.setTitle(Sound_select.sharedsound.sound_select, for: .normal)
        sound_insert.setTitle(Sound_select.sharedsound.sound_select, for: .normal)
    }
    
    func add_day() {           //新增重複天數的函數
        var final_check : String = ""
        if day_value.shared.select.count == 7 {
            day_insert.setTitle("Every Day", for: .normal)
        }
        else if day_value.shared.select.count == 0 {
            day_insert.setTitle("Never", for: .normal)
        }
        else {
            for i in 1...(day_value.shared.select.count) {
                final_check.append(day_array[day_value.shared.select[i-1]])
            }
            day_insert.setTitle("\(final_check)", for: .normal)
        }
    }
    
    
    @IBAction func day_insert(_ sender: Any) {
        let dayinsert = Clock.day_insert()
        self.navigationController?.pushViewController(dayinsert, animated: true)
    }
    @IBAction func set_labelVC(_ sender: Any) {
        let set_labelVC = Clock.set_labelVC()
        self.navigationController?.pushViewController(set_labelVC, animated: true)
    }
    
    @IBAction func set_sound(_ sender: Any) {
        let set_soundVC = Clock.set_soundVC()
        self.navigationController?.pushViewController(set_soundVC, animated: true)
        
    }
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func save(_ sender: Any) {
        if alarm_edit.edit_value_shared.edit_value == false {
            let realm = try! Realm()
            let table : alarm_realm = alarm_realm()
            table.hour = hour_select
            table.minute = minute_select
            for i in 0...day_value.shared.select.count-1 {
                switch day_value.shared.select[i] {
                case 0:
                    table.Sun = true
                case 1:
                    table.Mon = true
                case 2:
                    table.Tues = true
                case 3:
                    table.Wed = true
                case 4:
                    table.Thur = true
                case 5:
                    table.Fri = true
                case 6:
                    table.Sat = true
                default:
                    break
                }
            }
            table.label = label_text.shareinstance.label
            table.sound = Sound_select.sharedsound.sound_select
            table.snooze = snooze.isOn
            table.alarm_switch = true
            
            try! realm.write {
                realm.add(table)
            }
            print("fileURl:\(realm.configuration.fileURL!)")
            self.navigationController?.popViewController(animated: true)
        }
        else {
            let realm = try! Realm()
            let table = realm.objects(alarm_realm.self)
            let edit_alarm = table[alarm_didselect.edit_value_shared.select_index!]
            try! realm.write {
                edit_alarm.hour = hour_select
                edit_alarm.minute = minute_select
                edit_alarm.Sun = false
                edit_alarm.Mon = false
                edit_alarm.Tues = false
                edit_alarm.Wed = false
                edit_alarm.Thur = false
                edit_alarm.Fri = false
                edit_alarm.Sat = false
                
                for i in 0...day_value.shared.select.count-1 {
                    switch day_value.shared.select[i] {
                    case 0:
                        edit_alarm.Sun = true
                    case 1:
                        edit_alarm.Mon = true
                    case 2:
                        edit_alarm.Tues = true
                    case 3:
                        edit_alarm.Wed = true
                    case 4:
                        edit_alarm.Thur = true
                    case 5:
                        edit_alarm.Fri = true
                    case 6:
                        edit_alarm.Sat = true
                    default:
                        break
                    }
                }
                edit_alarm.label = label_text.shareinstance.label
                edit_alarm.sound = Sound_select.sharedsound.sound_select
                edit_alarm.snooze = snooze.isOn
                alarm_edit.edit_value_shared.edit_value = false
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func delete_alarm(_ sender: Any) {
        if  alarm_didselect.edit_value_shared.select_index != nil {
            let realm = try! Realm()
            let table = realm.objects(alarm_realm.self)
            let edit_alarm = table[alarm_didselect.edit_value_shared.select_index!]
            try! realm.write {
                realm.delete(edit_alarm)
            }
            self.navigationController?.popViewController(animated: true)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
extension alarm_insertVC : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return time.time_shared.hour.count
        }
        else {
            return time.time_shared.minute.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            if time.time_shared.hour[row] < 10 {
                return "0\(time.time_shared.hour[row])"
            }
            else {
                return "\(time.time_shared.hour[row])"
            }
        }
        else {
            if time.time_shared.minute[row] < 10 {
                return "0\(time.time_shared.minute[row])"
            }
            else {
                return "\(time.time_shared.minute[row])"
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if component == 0 {
            hour_select = time.time_shared.hour[row]
        }
        else if component == 1 {
            minute_select = time.time_shared.minute[row]
        }
        print("print : \(hour_select) : \(minute_select)")
    }
}
