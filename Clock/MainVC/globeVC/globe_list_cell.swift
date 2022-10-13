//
//  globe_list_cell.swift
//  Clock
//
//  Created by 阿瑋 on 2022/7/28.
//

import UIKit

class globe_list_cell: UITableViewCell {

    @IBOutlet weak var time_diff: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
