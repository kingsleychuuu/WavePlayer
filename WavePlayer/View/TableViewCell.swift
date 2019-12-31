//
//  TableViewCell.swift
//  WavePlayer
//
//  Created by admin on 12/31/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
