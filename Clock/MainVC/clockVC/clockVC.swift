//
//  clockVC.swift
//  Clock
//
//  Created by 阿瑋 on 2022/7/26.
//

import UIKit
import RealmSwift
import UserNotifications
import SwiftUI

class alarm_edit {
    var edit_value = false
    static let edit_value_shared = alarm_edit()
    private init() {}
}

class alarm_didselect {
    var select_index : Int? = nil
    static let edit_value_shared = alarm_didselect()
    private init() {}
}

class clockVC: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var edit: UIBarButtonItem!
    
    var edit_count = 0
    
    let calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "alarm_realm_cell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "alarm_realm_cell")
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
    }
    
    @IBAction func alarm_insert(_ sender: Any) {
        alarm_edit.edit_value_shared.edit_value = false
        alarm_didselect.edit_value_shared.select_index = nil
        day_value.shared.select = [0,1,2,3,4,5,6]
        label_text.shareinstance.label = "Alarm"
        Sound_select.sharedsound.sound_select = "Rader"
        snooze_switch.snooze_shared.snooze_select = true
        let alarm_insertVC = alarm_insertVC()
        tableview.reloadData()
        self.navigationController?.pushViewController(alarm_insertVC, animated: false)
       
    }
    
    @IBAction func edit(_ sender: Any) {
        edit_count += 1
        if edit_count % 2 == 1 {
            edit.title = "Done"
            tableview.setEditing(true, animated: false)
        }
        else {
            edit.title = "Edit"
            tableview.setEditing(false, animated: false)
        }
        tableview.reloadData()
    }
    
    
}
extension clockVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try? Realm()
        if let realm = realm {
            let table = realm.objects(alarm_realm.self)
            return table.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let realm = try? Realm()
        let table = realm!.objects(alarm_realm.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarm_realm_cell", for: indexPath) as! alarm_realm_cell
        if table[indexPath.row].hour < 10 && table[indexPath.row].minute < 9 {
            cell.list_time.text = "0\(table[indexPath.row].hour):0\(table[indexPath.row].minute)"
        }
        else if table[indexPath.row].hour < 10 {
            cell.list_time.text = "0\(table[indexPath.row].hour):\(table[indexPath.row].minute)"
        }
        else if table[indexPath.row].minute < 10 {
            cell.list_time.text = "\(table[indexPath.row].hour):0\(table[indexPath.row].minute)"
        }
        else {
            cell.list_time.text = "\(table[indexPath.row].hour):\(table[indexPath.row].minute)"
        }
        
        cell.list_label.text = table[indexPath.row].label
        cell.list_switch.tag = indexPath.row
        if cell.list_switch.isOn == true {
            try! realm?.write {
                table[indexPath.row].alarm_switch = true
            }
            
            var weekday_select = [Int]()
            if table[indexPath.row].Sun == true
            {
                weekday_select.append(contentsOf: [1])
            }
            if table[indexPath.row].Mon == true
            {
                weekday_select.append(contentsOf: [2])
            }
            if table[indexPath.row].Tues == true
            {
                weekday_select.append(contentsOf: [3])
            }
            if table[indexPath.row].Wed == true
            {
                weekday_select.append(contentsOf: [4])
            }
            if table[indexPath.row].Thur == true
            {
                weekday_select.append(contentsOf: [5])
            }
            if table[indexPath.row].Fri == true
            {
                weekday_select.append(contentsOf: [6])
            }
            if table[indexPath.row].Sat == true
            {
                weekday_select.append(contentsOf: [7])
            }
            
            for i in 0...weekday_select.count-1 {
                let content = UNMutableNotificationContent()
                content.title = "Clock"
                content.subtitle = "\(table[indexPath.row].hour):\(table[indexPath.row].minute)"
                content.body = table[indexPath.row].label
                content.sound = UNNotificationSound.default
                let alert_time = Date()
                var compnents = Calendar.current.dateComponents([ .weekday , .hour , .minute] , from: alert_time)
                compnents.hour = table[indexPath.row].hour
                compnents.minute = table[indexPath.row].minute
                compnents.weekday = weekday_select[i]
                let trigger = UNCalendarNotificationTrigger(dateMatching: compnents, repeats: true)
                
                let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                    print("成功建立通知...\(compnents)")
                })
            }
        }
        else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["notification"])
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["notification"])
            try! realm?.write {
                table[indexPath.row].alarm_switch = false
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let realm = try? Realm()
            let table = realm!.objects(alarm_realm.self)
            let del = table[indexPath.row]
            try! realm!.write {
                realm?.delete(del)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        let table = realm.objects(alarm_realm.self)
        let alarm_insertVC = Clock.alarm_insertVC()
        day_value.shared.select = []
        if table[indexPath.row].Sun == true
        {
            day_value.shared.select.append(contentsOf: [0])
        }
        if table[indexPath.row].Mon == true
        {
            day_value.shared.select.append(contentsOf: [1])
        }
        if table[indexPath.row].Tues == true
        {
            day_value.shared.select.append(contentsOf: [2])
        }
        if table[indexPath.row].Wed == true
        {
            day_value.shared.select.append(contentsOf: [3])
        }
        if table[indexPath.row].Thur == true
        {
            day_value.shared.select.append(contentsOf: [4])
        }
        if table[indexPath.row].Fri == true
        {
            day_value.shared.select.append(contentsOf: [5])
        }
        if table[indexPath.row].Sat == true
        {
            day_value.shared.select.append(contentsOf: [6])
        }
        label_text.shareinstance.label = table[indexPath.row].label
        Sound_select.sharedsound.sound_select = table[indexPath.row].sound
        snooze_switch.snooze_shared.snooze_select = table[indexPath.row].snooze
        alarm_edit.edit_value_shared.edit_value = true
        alarm_didselect.edit_value_shared.select_index = indexPath.row
        self.navigationController?.pushViewController(alarm_insertVC, animated: true)
    }
}
