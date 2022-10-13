//
//  alarm_realm.swift
//  Clock
//
//  Created by 阿瑋 on 2022/8/15.
//

import Foundation
import UIKit
import RealmSwift

class alarm_realm : Object {
    
    @objc dynamic var uuid : String = UUID().uuidString
    @objc dynamic var hour : Int = 0
    @objc dynamic var minute : Int = 0
    @objc dynamic var Sun : Bool = false
    @objc dynamic var Mon : Bool = false
    @objc dynamic var Tues : Bool = false
    @objc dynamic var Wed : Bool = false
    @objc dynamic var Thur : Bool = false
    @objc dynamic var Fri : Bool = false
    @objc dynamic var Sat : Bool = false
    @objc dynamic var label : String = ""
    @objc dynamic var sound : String = ""
    @objc dynamic var snooze : Bool = true
    @objc dynamic var alarm_switch : Bool = true
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
