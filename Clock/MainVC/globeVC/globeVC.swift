//
//  globeVC.swift
//  Clock
//
//  Created by 阿瑋 on 2022/7/26.
//

import UIKit

class globeVC: UIViewController {
    
    var timezones = [String]()
    @IBOutlet weak var edit: UIBarButtonItem!
    
    
    @IBOutlet weak var tableview: UITableView!
 
    
    var edit_count = 0
    var timeformatter = DateFormatter()
    var timer : Timer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "globe_list_cell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "globe_list_cell")
        tableview.delegate = self
        tableview.dataSource = self
        self.timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector:#selector(reload_tableview), userInfo: nil, repeats: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func insert_nextVC(_ sender: Any) {
       let nextVC = globe_insertVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
        nextVC.pushvalue = self
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
    
    @objc func reload_tableview() -> Void {
        tableview.reloadData()
    }
    
}

extension globeVC : UITableViewDataSource , UITableViewDelegate , AddTimeZone{
    
    func addtimezone(addtimezone : String) {
        timezones.append(addtimezone)
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timezones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "globe_list_cell", for: indexPath) as? globe_list_cell
        let timezone = TimeZone.init(identifier:timezones[indexPath.row])
        timeformatter.amSymbol = "AM"
        timeformatter.pmSymbol = "PM"
        timeformatter.dateFormat = "h:mm a"
        timeformatter.timeZone = timezone
        cell?.time.text = timeformatter.string(from: Date())
        if tableView.isEditing == true {
            cell?.time.isHidden = true
        }
        else {
            cell?.time.isHidden = false
        }
        cell?.place.text = timezones[indexPath.row].components(separatedBy: "/").last
        
        let second : Int = timeformatter.timeZone.secondsFromGMT()/3600
        cell?.time_diff.text = "\(second) Hours"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            timezones.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        timezones.insert(timezones.remove(at: sourceIndexPath.row) , at: destinationIndexPath.row)
    }
    
    
}
