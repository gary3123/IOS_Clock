//
//  loop_cell.swift
//  Clock
//
//  Created by 阿瑋 on 2022/8/18.
//

import UIKit

class loop_cell: UITableViewCell {
    
    @IBOutlet weak var count_label: UILabel!
    
    @IBOutlet weak var time_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
