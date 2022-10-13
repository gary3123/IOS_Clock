//
//  day_insert.swift
//  Clock
//
//  Created by 阿瑋 on 2022/8/9.
//

import UIKit

class day_value {
    var select = [0,1,2,3,4,5,6]
    static let shared = day_value()
    private init() {}
}


class day_insert: UIViewController {
    
    var day = ["Every Sonday" , "Every Monday" , "Every Tuesday" , "Every Wednesday" , "Every Thursday" , "Every Friday" , "Every Saturday"]
    
    @IBOutlet weak var tabelview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "daypick_cell", bundle: nil)
        tabelview.register(nib, forCellReuseIdentifier: "daypick_cell")
        tabelview.dataSource = self
        tabelview.delegate = self
        
    }

    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension  day_insert : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        day.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "daypick_cell", for: indexPath) as! daypick_cell
        cell.label.text = day[indexPath.row]
        if day_value.shared.select.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if day_value.shared.select.contains(indexPath.row) {
            day_value.shared.select = day_value.shared.select.filter{$0 != indexPath.row}
        }
        else {
            day_value.shared.select.append(indexPath.row)
        }
        day_value.shared.select.sort(by: <)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
