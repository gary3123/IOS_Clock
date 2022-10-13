//
//  MainVC.swift
//  Clock
//
//  Created by 阿瑋 on 2022/7/26.
//

import UIKit

class MainVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let globeVC = globeVC()
        let clockVC = clockVC()
        let stopwatchVC = stopwatchVC()
        let timerVC = timerVC()
        globeVC.title = "World Clock"
        clockVC.title = "Alarm"
        stopwatchVC.title = "Stopwatch"
        timerVC.title = "Timer"
        self.tabBar.backgroundColor = .secondarySystemBackground
        self.setViewControllers([ globeVC , clockVC , stopwatchVC , timerVC ], animated: false )
        guard let items = self.tabBar.items else { return }
        let images = [ "globe" , "clock" , "stopwatch" , "timer"]
        for x in 0...3 {
            items[x].image = UIImage(systemName: images[x])
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
