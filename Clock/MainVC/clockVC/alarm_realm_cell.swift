//
//  alarm_realm_cell.swift
//  Clock
//
//  Created by 阿瑋 on 2022/8/15.
//

import UIKit
import RealmSwift

class alarm_realm_cell: UITableViewCell {

    @IBOutlet weak var list_time: UILabel!
    @IBOutlet weak var list_label: UILabel!
    @IBOutlet weak var list_switch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func alarm_switch(_ sender: Any) {
        let realm = try? Realm()
        let table = realm!.objects(alarm_realm.self)
        if list_switch.isOn == true {
            try! realm?.write {
                table[list_switch.tag].alarm_switch = true
            }
        }
        else {
            try! realm?.write {
                table[list_switch.tag].alarm_switch = false
            }
        }

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
