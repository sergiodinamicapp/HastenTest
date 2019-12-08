//
//  PlayerCell.swift
//  PlayersApp
//
//  Created by sergio blanco martin on 04/12/2019.
//  Copyright © 2019 sergio blanco martin. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    //MARK: - Static Properties
    static let identifier = "PlayerCell"
    static let estimateHeight: CGFloat = 230
    static let estimateHeightSection: CGFloat = 40
    
    //MARK: IBOutlets
    @IBOutlet weak var imagePlayer: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.configureCell()
    }

    func configureCell() {
        imagePlayer.layer.cornerRadius = 5
        imagePlayer.layer.borderWidth = 1
        imagePlayer.layer.borderColor = UIColor.green.cgColor
        imagePlayer.contentMode = .scaleAspectFill
    }
}
