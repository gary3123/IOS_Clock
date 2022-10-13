//
//  globe_insertVC.swift
//  Clock
//
//  Created by 阿瑋 on 2022/7/27.
//

import UIKit

protocol AddTimeZone : AnyObject {
    func addtimezone(addtimezone : String)
}

class globe_insertVC : UIViewController
{
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var timeZones = [String]()
    weak var pushvalue : AddTimeZone?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        timeZones = NSTimeZone.knownTimeZoneNames
        let nib = UINib.init(nibName: "globe_place_cell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "globe_place_cell")
        tableView.dataSource = self
        tableView.delegate = self
       
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func search(_ sender: Any) {
        if searchTF.text != "" {
            timeZones = NSTimeZone.knownTimeZoneNames.filter({$0.localizedCaseInsensitiveContains(searchTF.text!)})
        }
        else {
            timeZones = NSTimeZone.knownTimeZoneNames
        }
        tableView.reloadData()
    }
    
}
extension globe_insertVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           timeZones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "globe_place_cell", for: indexPath) as? globe_place_cell
        cell?.place.text = timeZones[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushvalue?.addtimezone(addtimezone: timeZones[indexPath.row])
        
        self.navigationController?.popViewController(animated: true)
    }
    
}



