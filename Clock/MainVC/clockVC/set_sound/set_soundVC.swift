//
//  set_soundVC.swift
//  Clock
//
//  Created by 阿瑋 on 2022/8/11.
//

import UIKit

class Sound_select  {
    var sound_select = "Rader"
    static let sharedsound = Sound_select()
    private init() {}
}

class set_soundVC: UIViewController {
    
    let sound = ["Radar" , "Marimba" , "Opening" , "Waves" , "XyloPhone"]
    var check = "Radar"
    var i = 0
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "sound_cell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "sound_cell")
        tableview.dataSource = self
        tableview.delegate = self
        tableview.allowsSelection = true
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
  
}

extension set_soundVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sound.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "sound_cell", for: indexPath) as! sound_cell
        cell.sound_label.text = sound[indexPath.row]
        if check == sound[indexPath.row] {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        check = sound[indexPath.row]
        Sound_select.sharedsound.sound_select = sound[indexPath.row]
        tableView.reloadData()
    }
    
}
