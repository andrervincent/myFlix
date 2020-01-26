//
//  FilmViewCell.swift
//  myFlix
//
//  Created by Andre Vincent on 1/26/20.
//  Copyright © 2020 Andre Vincent. All rights reserved.
//

import UIKit

class FilmViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var filmImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
