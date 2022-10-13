//
//  stopwatchVC.swift
//  Clock
//
//  Created by 阿瑋 on 2022/7/26.
//

import UIKit

class stopwatchVC: UIViewController {

    @IBOutlet weak var start_button: UIButton!
    @IBOutlet weak var stop_button: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var loop_button: UIButton!
    
    @IBOutlet weak var showtime: UILabel!
    
    @IBOutlet weak var reset_button: UIButton!
    
    var start_status = true
    var timer = Timer()
    var stopwatch_list = [String]()
    var millsecond = 0
    var millsec = 0
    var sec = 0
    var min = 0
    var hour = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "loop_cell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "loop_cell")
        tableview.delegate = self
        tableview.dataSource = self
        
    }

    @IBAction func action_button(_ sender: Any) {
        start_status = false
        start_button.isHidden = true
        stop_button.isHidden = false
        loop_button.isHidden  = false
        reset_button.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(0.01), target: self, selector: #selector(count_minute), userInfo: nil, repeats: true)
        
        RunLoop.current.add(timer, forMode: .common)
    }
   
    @IBAction func stop(_ sender: Any) {
        start_status = true
        start_button.isHidden = false
        stop_button.isHidden = true
        loop_button.isHidden  = true
        reset_button.isHidden = false
        timer.invalidate()
    }
    
    
    @objc func count_minute() {
        if start_status == false {
            millsecond += 1
            millsec = millsecond % 100
            sec = (millsecond / 100) % 60
            min = millsecond / 6000
            hour = millsecond / 360000
            
            let showmillsec = millsec > 9 ? "\(millsec)" : "0\(millsec)"
            let showsec = sec > 9 ? "\(sec)" : "0\(sec)"
            let showmin = min > 9 ? "\(min)" : "0\(min)"
            let showhour = hour > 9 ? "\(hour)" : "0\(hour)"
            showtime.text = "\(showhour):\(showmin):\(showsec):\(showmillsec)"
        }
        
    }
    
    @IBAction func lap(_ sender: Any) {
        stopwatch_list.insert(showtime.text!, at: 0)
        tableview.reloadData()
        
    }
    
    @IBAction func reset(_ sender: Any) {
        stopwatch_list = []
        millsecond = 0
        showtime.text = "00:00:00:00"
        tableview.reloadData()
    }
    
}
extension stopwatchVC: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stopwatch_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loop_cell", for: indexPath) as! loop_cell
        cell.count_label.text = "Lap \(stopwatch_list.count-indexPath.row)"
        cell.time_label.text = stopwatch_list[indexPath.row]
        return cell
    }
    
    
}
