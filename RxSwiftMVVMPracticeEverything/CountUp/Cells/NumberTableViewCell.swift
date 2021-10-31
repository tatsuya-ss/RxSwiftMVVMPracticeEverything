//
//  NumberTableViewCell.swift
//  RxSwiftMVVMPracticeEverything
//
//  Created by 坂本龍哉 on 2021/10/31.
//

import UIKit

final class NumberTableViewCell: UITableViewCell {

    @IBOutlet private weak var numberLabel: UILabel!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(number: Int) {
        numberLabel.text = String(number)
    }
    
}
